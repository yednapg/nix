# GUI applications via Homebrew
{ ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ ];
    brews = [
      "nvm" "fish" "postgresql@17" "libpq" "rbenv" "webpack" "yarn"
      "gh" "cocoapods" "httpie" "mas" "asc" "python@3.14" "watchman" "portaudio" "neovim" "awscli"
      "anomalyco/tap/opencode"
    ];
    casks = [
      "helium-browser"  "raycast" "whatsapp"  "zen" "cloudflare-warp" "figma" "zoom" 
      "visual-studio-code@insiders"  "rectangle"  "bitwarden" "selfcontrol" "ungoogled-chromium"  "github" 
      "session-manager-plugin" "conductor" "alfred" "chatgpt"
      "google-chrome" "google-chrome@canary" "firefox@developer-edition"
    ];
    masApps = { };
  };
}
