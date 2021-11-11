set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'powerline/powerline-fonts'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

"Plugin for markdown viewing
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'derekwyatt/vim-scala'
Plugin 'chrisbra/csv.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'psf/black'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'cespare/vim-toml'

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

"Personal Stuff
set mouse=a
set nu
set relativenumber
set ignorecase
set smartcase
set incsearch
set hlsearch
set virtualedit=onemore
"inoremap <C-BS> <C-w>
map <C-kDel> dw
imap <C-kDel> <esc>ldwi
noremap <C-Del> dw
imap <C-Del> <esc>ldwi
map <C-BS> <C-W>
inoremap <C-BS> <C-W>
noremap Y y$
noremap! <C-h> <C-w>
noremap <F4> <esc>:w<cr><esc>
inoremap <F4> <esc>:w<cr><esc>li
map <F5> <esc>:%s/'/"/g<cr><esc>:%!python -m json.tool <cr> <esc>
imap <F5> <esc>:%s/'/"/g<cr><esc>:%!python -m json.tool <cr> <esc>
" Needed for GVIm
nnoremap <S-CR> A<CR><Esc>
" Needed for CLI VIm (Note: ^[0M was created with Ctrl+V Shift+Enter, don't type it directly
nnoremap  A<CR><Esc>
" Focus nerdtree window
nnoremap <leader>w :NERDTreeFocus<CR>
set autoindent
set smartindent
set wrap
set breakindent
set linebreak
set showbreak=\ \ 
set clipboard=unnamedplus
colors elflord
set guifont=Source\ Code\ Pro\ For\ Powerline\ Medium\ 12
set softtabstop=4
set tabstop=4
set expandtab
set shiftwidth=4
set autochdir " change current directory to directory of file upon opening
set splitright
set encoding=utf-8
syntax on
cmap w!! w !sudo tee > /dev/null %

" Path replacement
command WindowsPath %s@\\@/@g

" Markdown config
let vim_markdown_preview_github=1

" Vim Airline stuff
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256

" Create directory on write if it doesn't already exist
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" NerdTree stuff
let g:NERDTreeGitStatusShowIgnored = 1 " a heavy feature may cost much more time. default: 0
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" Latex stuff "
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
" au FileType tex map <buffer> <F3> :PdfLatex<CR>

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'




if has("autocmd")
    autocmd BufRead,BufNewFile *.md,*.rst setlocal spell
    augroup prog
        au!
        au BufEnter *.py map <F3> <esc>:w\|:new \| 0read !flake8 --count --exit-zero # <cr> <esc>
        au BufEnter *.py imap <F3> <esc>:w\|:new \| 0read !flake8 --count --exit-zero # <cr> <esc>
        au BufEnter *.py map <F5> <esc>:w\|:Black <cr> <esc>
        au BufEnter *.py imap <F5> <esc>:w\|:Black <cr> <esc>
        au BufEnter *.tex map <F3> <esc>:w\|:!pdflatex -shell-escape % <cr> <esc>
        au BufEnter *.tex imap <F3> <esc>:w\|:!pdflatex -shell-escape % <cr> <esc>
        au BufEnter *.tex map <F6> <esc>:w\|:!bibtex %:r <cr> <esc>
        au BufEnter *.tex imap <F6> <esc>:w\|:!bibtex %:r <cr> <esc>
        " Start NERDTree and put the cursor back in the other window.
        autocmd VimEnter * NERDTree | wincmd p
        " Exit Vim if NERDTree is the only window remaining in the only tab.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        " Jump to the last position visited in a file when re-opening
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif

if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window (for an alternative on Windows, see simalt below).
    set columns=120
endif
