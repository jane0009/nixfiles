# definitions

$env.VERBOSE_FUNCTIONS = false

$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

def debug-print [text] {
    if $env.VERBOSE_FUNCTIONS {
        print $text
    }
}

def list_contains [text, searches] {
    #assume text is a string, and searches is a list
    let has = ($searches | split row (char esep) | where ($it == $text))
    (if ($has | is-empty) { false } else { true })
}

def list_exclude [la, lb] {
    #la is the list to remove from
    let excluded = ($la | where (list_contains $it $lb) == false)
    $excluded
}

def does_path_exist [path] {
    let path_has_files = (try {
        not (ls $path | is-empty)
    } catch {
        false
    })
    $path_has_files
}

def dirs_not_existing [paths] {
    # no idea WHY i have to invert this again
    $paths | where (not (does_path_exist $it))
}

def insert_if_not_exists [paths] {
    let nhas = ($env.PATH | split row (char esep) | where (list_contains $it $paths))
    let needs = (list_exclude $paths $nhas)
    let dne = (dirs_not_existing $paths)
    let nne = (list_exclude $needs $dne)
    debug-print ([$nne] | str join)
    mut thepath = []
    if (($nne | is-empty) != true) {
        debug-print (["need to add: ", $nne] | str join)
        $thepath = ($env.PATH | split row (char esep) | prepend $nne)   
    }
    $thepath
}

# we are making paths.

let new_path = (insert_if_not_exists [
    '/run/current-system/bin',
    '/run/current-system/sw/bin', 
    '/run/wrappers/bin',
    '/home/jane/.pnpm',
    '/home/jane/.npm-global/bin',
    '/home/jane/.bin',
    '/home/jane/.nix-profile/bin'
    '/does/not/exist' # here as a litmus test
])
# i do not know if there is an inverse of is-empty, and i also don't care.
if (($new_path | is-empty) != true) {
    $env.PATH = $new_path
}

def get_fnm_path [] {
    debug-print "found fnm, adding to path"
    let fnm_dir = (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | where column1 == "FNM_DIR" | get column2 | get 0)
    let multishell_path = (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | where column1 == "FNM_MULTISHELL_PATH" | get column2 | get 0)
    let fnm_inserted_path = (insert_if_not_exists [
        $"($multishell_path)/bin"
    ])
    debug-print $multishell_path
    debug-print $"($multishell_path)/bin"
    debug-print $fnm_inserted_path
    ($fnm_inserted_path)
}

# only execute once
let blacklisted_terms = [ "vt102" ]

let is_wt = (try { (not ($env | get WT_SESSION | is-empty)) } catch { false })

let fnm_env = (if ($env.TERM not-in $blacklisted_terms) and (not $is_wt) {
    let $is_zellij = (try { (not ($env.ZELLIJ_SESSION_NAME | is-empty)) } catch { false })
    if $is_zellij {
        # we are in zellij
        (get_fnm_path)
    } else {
        ([])
    }
} else {
    (get_fnm_path)
})
if (($fnm_env | is-empty) != true) {
    debug-print $fnm_env
    $env.PATH = $fnm_env
}

# starship overlay

overlay use "/home/jane/.config/nushell/starship.nu"

# env configs

$env.EDITOR = "nvim"
$env.PNPM_HOME = "/home/jane/.pnpm"
#$env.ZELLIJ_AUTO_ATTACH = true
#$env.ZELLIJ_AUTO_EXIT = true

# directories

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# aliases

alias vim = nvim
alias ll = ls -la
