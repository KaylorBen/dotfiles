# Completions
let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # use zoxide completions for zoxide commands -- temporarily disabled since it disables normal cd completion
        # __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
  edit_mode: vi,
  table: {
    mode: rounded
  },
  show_banner: false,
  completions: {
    external: {
      enable: true
      completer: $external_completer
    }
  }
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
    }]
  }
}

$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Function querying free online English dictionary API for definition of given word(s)
def dict [...word #word(s) to query the dictionary API but they have to make sense together like "martial law", not "cats dogs"
] {
	let query = ($word | str join %20)
  let link = ('https://api.dictionaryapi.dev/api/v2/entries/en/' + ($query|str replace ' ' '%20'))
  let output = (http get $link | rename word)
  let w = ($output.word | first)

  if $w == "No Definitions Found" {
  	echo $output.word
  } else {
  	echo $output
    | get meanings
    | flatten
    | select partOfSpeech definitions
    | flatten
    | flatten
    | reject "synonyms"
    | reject "antonyms"
  }
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# LS_COLORS config
$env.LS_COLORS = (vivid generate molokai | str trim)

# Editor
$env.EDITOR = "nvim"

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
# let-env ENV_CONVERSIONS = {
#   "PATH": {
#     from_string: { |s| $s | split row (char esep) }
#     to_string: { |v| $v | str collect (char esep) }
#   }
#   "Path": {
#     from_string: { |s| $s | split row (char esep) }
#     to_string: { |v| $v | str collect (char esep) }
#   }
# }

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
# let-env NU_LIB_DIRS = [
#     ($nu.config-path | path dirname | path join 'scripts')
# ]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
