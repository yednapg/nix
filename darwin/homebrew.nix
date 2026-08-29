# GUI applications via Homebrew
{ ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ ];
    brews = [
      "nvm" "fish" "postgresql@17" "libpq" "rbenv" "webpack" "yarn"
      "gh" "cocoapods" "httpie" "mas" "asc" "python@3.14" "watchman" "portaudio" "neovim" "awscli"
    ];
    casks = [
      "helium-browser"  "raycast" "whatsapp" "ghostty" "zen" "codex" "arc" "monitorcontrol"  "alfred" "cloudflare-warp" "slack"  "chatgpt" "figma" "zoom" "visual-studio-code@insiders"  "rectangle" "codex-app"  "bitwarden" "selfcontrol" "ungoogled-chromium"  "github" "cursor" "claude-code" "session-manager-plugin"
    ];
    masApps = { };
  };
}
