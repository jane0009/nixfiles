(final: prev: {
    discord-canary = prev.discord-canary.overrideAttrs (dprev: {
        # HH3 isn't managed by Nix because we are a developer
        installPhase = dprev.installPhase + "\n" + ''
        mv $out/opt/DiscordCanary/resources/app.asar $out/opt/DiscordCanary/resources/_app.asar
        mkdir -p $out/opt/DiscordCanary/resources/app/app_bootstrap
        cat > $out/opt/DiscordCanary/resources/app/app_bootstrap/index.js <<EOF
        let _hh3_path = "$out/opt/DiscordCanary/resources/_app.asar";
        require("/home/jane/hh3/lib/injector.js").inject(require("path").resolve(_hh3_path));
        require(_hh3_path);
        process.mainModule = require.cache[require.resolve(_hh3_path)];
        EOF
        echo '{"name":"discord","main":"./app_bootstrap/index.js","private":true}' > $out/opt/DiscordCanary/resources/app/package.json
        '';
    });
})