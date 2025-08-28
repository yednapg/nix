# GUI applications via Homebrew
{ ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ ];
    brews = [
      "nvm" "fish" "postgresql@17" "libpq" "rbenv" "webpack" "yarn"
      "gh" "cocoapods" "mas" "watchman" "portaudio"
    ];
    casks = [
      "whatsapp" "figma" "slack" "discord" "zoom" "visual-studio-code" "arc"
      "rectangle" "firefox" "bitwarden" "cloudflare-warp"
      "selfcontrol" "appcleaner" "ungoogled-chromium" "brave-browser"
    ];
    masApps = { };
  };
}
