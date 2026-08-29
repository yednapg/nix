# Vim configuration
{ pkgs, ... }: {
  programs.vim = {
    enable = true;

    plugins = [
      pkgs.vimPlugins.vim-solarized8
    ];

    extraConfig = ''
      " Basic settings
      set nocompatible
      set encoding=utf-8
      set fileformats=unix,dos,mac

    " Visual settings
      set termguicolors
      autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
      autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
      autocmd ColorScheme * highlight NormalFloat guibg=NONE ctermbg=NONE
      autocmd ColorScheme * highlight SignColumn guibg=NONE
      autocmd ColorScheme * highlight LineNr guibg=NONE
      syntax enable
      set background=dark
      colorscheme murphy

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
}
