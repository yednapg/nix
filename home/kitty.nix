# Kitty terminal configuration
{ ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 18;
    };
    settings = {
      # Window appearance
      window_padding_left = 2;
      window_padding_right = 2;
      window_padding_top = 2;
      window_padding_bottom = 2;
      hide_window_decorations = "no";
      
      # Terminal behavior
      enable_audio_bell = false;
      copy_on_select = true;
      shell = "zsh";
      
    };
    
    keybindings = {
      "cmd+t" = "new_tab";
      "cmd+w" = "close_tab";
      "cmd+shift+]" = "next_tab";
      "cmd+shift+[" = "previous_tab";
    };
  };
}
