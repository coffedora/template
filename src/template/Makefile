.PHONY: all build run serve kill templ clean css air tmux
# Simple Makefile for a Go project
.PHONY: all build run serve kill templ clean css air tmux

# Build the application
all: serve

serve: kill templ
	@echo "Start tmux session"
	@echo "Killing existing sessions"
	@tmux kill-session -t serve 2>/dev/null || true
	@tmux new-session -d -s serve
	@tmux send-keys -t serve 'make css' C-m
	@tmux split-window -v -t serve
	@tmux send-keys -t serve 'air -c .air.toml' C-m
	@tmux attach -t serve

css:
	@echo "Start Tailwindcss"
	@tailwindcss -i assets/input.css -o assets/dist/css/output.css --watch

build: templ
	@echo "Building..."
	@go build -o ./tmp/app cmd/api/main.go

templ:
	@echo ' Check for teml package'
	@go install github.com/a-h/templ/cmd/templ@latest
	@go mod tidy
	@echo "Creating template..."
	@templ generate

clean:
	@echo "Cleaning..."	
	@echo "remove generated templ content..."	
	rm -rf views/*_templ.go
	rm -rf views/**/*_templ.go



brew:
	@curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
	@echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/d1sev/.bashrc
	@eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)