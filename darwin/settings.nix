# macOS UI/UX preferences and defaults
{ ... }: {
  # Add your macOS settings here
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      showhidden = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };
}
