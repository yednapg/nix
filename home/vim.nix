# Vim configuration
{ ... }: {
  programs.vim = {
    enable = true;
    extraConfig = ''
      " Basic settings
      set termguicolors
      set nocompatible
      set encoding=utf-8
      set fileformats=unix,dos,mac

      " Visual settings
      syntax on
      set cursorline
      set showmatch
      set wildmenu
      set ruler

      " Theme
      set background=dark
      colorscheme murphy

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
