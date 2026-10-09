# Modular Nushell Configuration
$env.LANG = "en_US.UTF-8"
$env.LC_ALL = "en_US.UTF-8"

source ($nu.default-config-dir | path join "conf.d" "00_utils.nu")

# Core configuration
source ($nu.default-config-dir | path join "conf.d" "01_env.nu")
source ($nu.default-config-dir | path join "conf.d" "02_history.nu")

# Tool integrations
source ($nu.default-config-dir | path join "conf.d" "03_integrations.nu")

# User interface and experience
source ($nu.default-config-dir | path join "conf.d" "04_aliases.nu")
source ($nu.default-config-dir | path join "conf.d" "05_keybindings.nu")
source ($nu.default-config-dir | path join "conf.d" "06_prompt.nu")
