# bat: cat with syntax highlighting
{ ... }: {
  programs.bat = {
    enable = true;
    config = {
      # "ansi" uses the terminal's 16 colors, so output matches the
      # original Solarized palette of the Terminal.app profile exactly.
      theme = "ansi";
    };
  };
}
