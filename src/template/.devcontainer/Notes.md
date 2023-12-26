
# Fedora Codespace (Template) based on  coffedora/feature/setup🧊☕️🪶)

Setup your Fedora devcontainer Environment

## Example Usage

```json
"features": {
		"ghcr.io/coffedora/feature/setup:latest": {
			"userName": "${localEnv:GITHUB_USERNAME}",
			"dnfInstall": "neovim  fzf ripgrep fd tmux"
		}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| userName | Auto use existing user with home dir or create remote-user | string | automatic |
| copr | Add Copr Repositories.automatic Recognizes ENV variables of packages to add their copr repos | string | automatic |
| dnfInstall | packages installed by default separated by whitespaces. automatic installs requirements including those of other settings  | string | automatic |
| dnfRemove | Remove packages from Image | string | automatic |
| languageSupport | Install additional language support. Language Support is distributed in own scripts(Currently only for go) | string | automatic |
| installHomebrew | Install additional package Manager () | string | automatic |

## Customizations

### VS Code Extensions

- `golang.Go`
- `a-h.templ`
- `quillaja.goasm`
- `GitHub.copilot`
- `GitHub.copilot-chat`
- `formulahendry.github-actions`
- `ms-azuretools.vscode-docker`
- `GitHub.vscode-pull-request-github`

# Dev Container Templates: FEdora Based Devcontainer - Coffedora

## How to get the CLI
On linux you can install the ClI tool via homebrew.
On windows you have to use it from wsl or install npm first.
Easiest way to get npm is the *node version manager* **nvm** 
```powershell
scoop install nvm
nvm install lts
nvm apply lts
npm install -g @devcontainers/cli
```


## How to get the Template in my project
Apply the template in a directory and edit the ARG in Dockerfile. YOu have also to adjust the name in the devcontainer.json
```json
	"features": {
		"ghcr.io/coffedora/feature/setup:latest": {
			"userName": "${localEnv:GITHUB_USER}",
			"languageSupport":"go", //only go - other languages to be included
			"dnfInstall": "fzf fd tmux ripgrep nvim",
			"WSLCONFIG":"true", //create /etc/wsl.conf
			"installHomebrew": "true"
		}
	},
```
## VSCode Customizations
```json
	"customizations": {
		"vscode": {
			"extensions": [
				"a-h.templ",
				"quillaja.goasm",
				"GitHub.copilot",
				"GitHub.copilot-chat",
				"yzhang.markdown-all-in-one",
				"bierner.markdown-preview-github-styles",
				"formulahendry.github-actions",
				"ms-azuretools.vscode-docker"
			],
			"settings": {
				"files.autoSave": "afterDelay",
				"editor.smoothScrolling": true,
				"terminal.integrated.lineHeight": 1.5,
				"editor.fontLigatures": true,
				"editor.lineHeight": 1.5,
				"editor.minimap.enabled": false,
				"editor.tabSize": 2,
				"editor.semanticTokenColorCustomizations": {
					"enabled": true
				},
				"editor.semanticHighlighting.enabled": true,
				"files.eol": "\n",
				"extensions.ignoreRecommendations": true,
				"task.problemMatchers.neverPrompt": {
					"shell": true
				}
		}
        //checzmoi example - GH_TOKEN must provide access if repository is private
				// "dotfiles.repository": "${localEnv:GITHUB_USERNAME}/dotfiles",
				// "dotfiles.targetPath": "~/.local/share/chezmoi",
				// "dotfiles.installCommand": "setup.sh"
			}
		},
```