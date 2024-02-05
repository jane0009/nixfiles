{
  lib,
  inputs,
  ...
}: let
  #######################################################################
  # merge the default parameters for *SYSTEMS* into a system params.nix #
  #######################################################################
  mergeDefaultSystemParams = params:
    lib.attrsets.mergeAttrsList [
      (import ../hosts/default-params.nix)
      params
    ];
  #######################################################################
  # merge the default parameters for *MODULES* into a module params.nix #
  #######################################################################
  mergeDefaultModuleParams = params:
    lib.attrsets.mergeAttrsList [
      {
        has = [];
        requires = [];
        options = {};
      }
      params
    ];
  #############################################
  # get the contents of a module's params.nix #
  # assumes the file exists, merges defaults  #
  #############################################
  getModuleParams = module:
    mergeDefaultModuleParams (import ../modules/${module}/params.nix {
      inherit lib inputs;
    });

  ##########################
  # get the system options #
  ##########################
  getSystemParams = hostname:
    mergeDefaultSystemParams (
      if builtins.pathExists ../hosts/systems/${hostname}/params.nix
      then (import ../hosts/systems/${hostname}/params.nix)
      else {}
    );
  ###############################################################################
  # get the actual module code given the module name and the options to pass in #
  ###############################################################################
  getModuleFilesFromModuleParams = {
    module,
    opts,
  }: let
    params = getModuleParams module;
  in
    builtins.map (
      modHas: (import ../modules/${module}/${modHas}.nix {
        inherit lib inputs opts;
        config = inputs.nixpkgs.config;
        pkgs = inputs.nixpkgs;
      })
    )
    params.has;
  ##########################################################
  # get all possible options from a list of loaded modules #
  # main function                                        #
  ##########################################################
  getMergedOptions = modules:
    lib.lists.flatten (
      builtins.map (module: (getModuleParams module).options) modules
    );
  ###############################################
  # resolve the dependencies of a single module #
  # helper function                             #
  ###############################################
  moduleDepsResolved = module: let
    moduleDeps =
      if (builtins.pathExists ../modules/${module}/params.nix)
      then (getModuleParams module).requires
      else [];
  in [
    module
    (
      if (builtins.length moduleDeps)
      then (modulesDepsResolved moduleDeps)
      else []
    )
  ];
  #################################################
  # resolve the dependencies of a list of modules #
  # helper function                               #
  #################################################
  modulesDepsResolved = modules: lib.lists.flatten (builtins.map moduleDepsResolved modules);
  ############################
  # get default option value #
  # helper function          #
  ############################
  getDefaultOptionValue = option: option.default;
  ###########################################################
  # merge default system options with the options passed in #
  # helper function                                         #
  ###########################################################
  mergeDefaultSystemOptions = {
    possibleOptions,
    systemSettings,
  }:
    builtins.map (
      name:
        if lib.attrsets.hasAttrByPath [name] systemSettings
        then systemSettings.${name}
        else getDefaultOptionValue possibleOptions.${name}
    ) (builtins.attrNames possibleOptions);
  #####################################################################
  # map module strings into a list of module code, with deps resolved #
  # main function                                                     #
  #####################################################################
  mapModuleStrings = {
    hostname,
    params,
  }: let
    filteredModules =
      builtins.filter (
        name: builtins.pathExists ../modules/${name}/params.nix
      )
      params.modules;
    resolvedModules = modulesDepsResolved filteredModules;
    moduleOptions = getMergedOptions resolvedModules;
    systemOptions = getSystemParams hostname;
  in
    (lib.optionals (
        builtins.pathExists ../hosts/systems/${hostname}/hardware.nix
      ) [
        ../hosts/systems/${hostname}/hardware.nix
      ])
    ++ (
      lib.lists.flatten (
        builtins.map (
          name:
            getModuleFilesFromModuleParams {
              module = name;
              opts = moduleOptions;
            }
        )
        resolvedModules
      )
    )
    ++ [../hosts/systems/${hostname}/config.nix]
    ++ (builtins.map (user: ../users/${user}.nix) params.users)
    ++ [
      {
        networking.hostName = hostname;
      }
    ];
  ####################
  # default overlays #
  ####################
  defaultOverlays = with inputs; [
    fenix.overlays.default
    nix-vscode-extensions.overlays.default
    zig.overlays.default
    (import ../derivations/hh3/manual-hh3.nix)
  ];

  #########################
  # handle extra overlays #
  #########################
  handleExtraOverlays = {modules}:
    defaultOverlays
    ++ lib.lists.flatten (builtins.map (
        module: [module] ++ lib.optionals (lib.attrsets.hasAttrByPath ["opts" "extraOverlays"] module) module.opts.extraOverlays
      )
      modules);
  ##########################
  # redefine nixos in here #
  ##########################
  nixos = {
    system,
    modules,
    opts,
    specialArgs ? {},
  }: let
    overlays = handleExtraOverlays {inherit modules;};
  in
    with inputs;
      nixpkgs.lib.nixosSystem {
        inherit system modules;
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };

        specialArgs = specialArgs // {inherit opts inputs;};
      };
in rec {
  ############################
  # generate system settings #
  ############################
  genSystem = {systemName}: let
    params = getSystemParams systemName;
    filteredModules =
      builtins.filter (
        name: builtins.pathExists ../modules/${name}/params.nix
      )
      params.modules;
    resolvedModules = modulesDepsResolved filteredModules;
    moduleOptions = getMergedOptions resolvedModules;
    fullModules = mapModuleStrings {
      hostname = systemName;
      inherit params;
    };
  in
    nixos {
      system = params.system;
      modules = fullModules;
      opts = moduleOptions;
      specialArgs = {
        inherit inputs;
      };
    };

  #####################################
  # generate a tarball for containers #
  #####################################
  genTarball = {systemName}: let
    params = getSystemParams systemName;
    filteredModules =
      builtins.filter (
        name: builtins.pathExists ../modules/${name}/params.nix
      )
      params.modules;
    resolvedModules = modulesDepsResolved filteredModules;
    moduleOptions = getMergedOptions resolvedModules;
    fullModules = mapModuleStrings {
      hostname = systemName;
      inherit params;
    };
    overlays = handleExtraOverlays {modules = fullModules;};
  in
    with inputs;
      nixos-generators.nixosGenerate {
        system = params.system;
        format = "proxmox-lxc";
        modules = fullModules;
        specialArgs = {
          opts = moduleOptions;
          pkgs = import nixpkgs {
            system = params.system;
            config.allowUnfree = true;
            inherit overlays;
          };
        };
      };
}
