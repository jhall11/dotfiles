set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Autoformat
Plugin 'Chiel92/vim-autoformat'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Helpful for python
set shiftwidth=4 softtabstop=4
set expandtab
filetype indent on
set nu

set viminfo='10,\"100,:20,%,n~/.viminfo

" Highlight text over 90 characters long
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%91v.\+/

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 79 characters.
  " autocmd FileType text setlocal textwidth=79
  " set colorcolumn=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  "Highlight trailing whitespace
  highlight ExtraWhitespace ctermbg=green guibg=green
  match ExtraWhitespace /\s\+$/


  augroup END


  "match tags
   autocmd FileType html let b:match_words = '<\(\w\w*\):</\1,{:}'
   autocmd FileType xhtml let b:match_words = '<\(\w\w*\):</\1,{:}'
   autocmd FileType xml let b:match_words = '<\(\w\w*\):</\1,{:}'

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"validate xml

map <F8> :w<cr>:%d<cr>!!xmllint --html --format %<cr>



" TO INSTALL REQUIRED PLUGINS
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"
" cd ~/.vim/bundle && \
" git clone git://github.com/tpope/vim-sensible.git
"
" cd ~/.vim/bundle
" git clone git://github.com/tpope/vim-fugitive.git
" vim -u NONE -c "helptags vim-fugitive/doc" -c q
"
"

" vim-Pathogen settings
" See https://github.com/tpope/vim-pathogen
"Disable replace mode
nnoremap R <Esc>
execute pathogen#infect()
" Reenable it after entering the buffer
au BufEnter * nnoremap R R

" Statusline stuff
set laststatus=2                                "Always display the statusline
set statusline=%-3.3n\                          "buffer number
set statusline+=%{fugitive#statusline()}        "Git branch NOTE: Requires fugitive to be installed
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}]                         "file format
set statusline+=%h                              "help file flag
set statusline+=%m                              "modified flag
set statusline+=%r                              "read only flag
set statusline+=%y                              "filetype
set statusline+=%10.t                           "tail of the filename
set statusline+=%=                              "left/right separator
set statusline+=\ %c,                        "cursor column
set statusline+=%l/%L                     "cursor line/total lines
set statusline+=\ %P                            "percent through file

" Diff options
if &diff
    colorscheme almost-default
    set cursorline
    map ] ]c
    map [ [c
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" Syntastic stuff
" see :help syntastic in Vim:

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" ignore python
" let g:syntastic_disabled_filetypes=['py']

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

