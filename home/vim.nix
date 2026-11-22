# Vim configuration
{ pkgs, ... }: {
  programs.vim = {
    enable = true;

    plugins = [
      # Ethan Schoonover's original Solarized colorscheme
      pkgs.vimPlugins.vim-colors-solarized
    ];

    extraConfig = ''
      " Basic settings
      set nocompatible
      set encoding=utf-8
      set fileformats=unix,dos,mac

    " Visual settings
      " Original Solarized in 16-color mode: Vim uses the terminal's own
      " Solarized ANSI palette, so the colors are exactly the official ones.
      set notermguicolors
      let g:solarized_termcolors=16
      autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
      autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
      autocmd ColorScheme * highlight NormalFloat guibg=NONE ctermbg=NONE
      autocmd ColorScheme * highlight SignColumn guibg=NONE
      autocmd ColorScheme * highlight LineNr guibg=NONE
      syntax enable
      " 'background' is not forced: Vim asks the terminal for its background
      " color, so Solarized Dark and Solarized Light profiles both look right.
      colorscheme solarized

      set relativenumber
      set cursorline
      set showmatch
      set wildmenu
      set ruler

      " Indentation
      set smartindent
      set autoindent
      set tabstop=4
      set shiftwidth=4
      set expandtab

      " Language specific indentation
      autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
      autocmd FileType javascript,typescript setlocal tabstop=2 shiftwidth=2 expandtab

      " Search settings
      set incsearch
      set ignorecase
      set smartcase
      set hlsearch

      " System integration
      set clipboard=unnamedplus

      " Split behavior
      set splitbelow
      set splitright

      " Persistence
      set undofile
    '';
  };

  # Neovim (installed via Homebrew): same original Solarized setup.
  xdg.dataFile."nvim/site/pack/nix/start/vim-colors-solarized".source =
    pkgs.vimPlugins.vim-colors-solarized;
  xdg.configFile."nvim/init.vim".text = ''
    set notermguicolors
    let g:solarized_termcolors=16
    syntax enable
    " 'background' is auto-detected from the terminal (dark or light profile).
    colorscheme solarized
  '';
}
