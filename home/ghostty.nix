# Ghostty terminal configuration
{ ... }: {
  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      "shell-integration-features" = "cursor,no-sudo,title,no-ssh-env,no-ssh-terminfo,path";
      "clipboard-read" = "allow";
      "window-theme" = "dark";
      "window-padding-x" = 6;
      "window-padding-y" = 6;
      "window-padding-balance" = false;
      "macos-icon" = "blueprint";
      "macos-titlebar-style" = "hidden";
      "macos-titlebar-proxy-icon" = "hidden";

      "font-family" = "SF Mono";
      "font-size" = 18;

      theme = "Solarized Dark Patched";
      background = "#001e27";
      foreground = "#708284";
      "selection-background" = "#002831";
      "selection-foreground" = "#819090";
      "cursor-color" = "#708284";
      "cursor-text" = "#002831";

      palette = [
        "0=#002831"
        "1=#d11c24"
        "2=#738a05"
        "3=#a57706"
        "4=#2176c7"
        "5=#c61c6f"
        "6=#259286"
        "7=#eae3cb"
        "8=#475b62"
        "9=#bd3613"
        "10=#475b62"
        "11=#536870"
        "12=#708284"
        "13=#5956ba"
        "14=#819090"
        "15=#fcf4dc"
      ];
    };
  };
}
