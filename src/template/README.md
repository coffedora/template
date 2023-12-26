
# Fedora Codespace (template)

Fedora Devcontainer designed for Cloud

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| userName | Name of the home directory owner | string | ${localEnv:GITHUB_USER} |
| dnfInstall | Add extra dnf Packages. | string | fzf fd tmux ripgrep nvim |
| languageSupport | Add extra dnf Packages. | string | automatic |
| WSLCONFIG | Add extra dnf Packages. | string | true |
| installHomebrew | Add Homebrew Packag manager. | string | true |



---

_Note: This file was auto-generated from the [devcontainer-template.json](https://github.com/coffedora/template/blob/main/src/template/devcontainer-template.json).  Add additional notes to a `NOTES.md`._
