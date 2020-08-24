"###########
"##Plugins##
"###########

"vim-plug to manage plugins for nvim
call plug#begin()
    Plug 'dense-analysis/ale'               "A collection of linters in one plugin
	Plug 'roxma/nvim-yarp'                  "a remote plugin framework
    Plug 'sheerun/vim-polyglot'             "language highlighting
    Plug 'scrooloose/nerdcommenter'         "Easy commenting
    Plug 'tpope/vim-surround'               "use cs<><> to replace brackets, quotation marks and more
    Plug 'ryanoasis/vim-devicons'           "allows for nerd fonts (icon fonts)
    Plug 'luochen1990/rainbow'              "rainbow parenthesis to make code more readable
    Plug 'dylanaraps/wal.vim'               "Uses pywal to get colour scheme
    " consider nerd tree preservim/nerdtree

    " Autocomplete
    Plug 'ncm2/ncm2'                        "Completion manager
	Plug 'ncm2/ncm2-bufword'                "Adds words in current buffer to autocomplete
	Plug 'ncm2/ncm2-path'                   "Path autocompletion for relative and global autocompletion
    Plug 'ncm2/ncm2-tmux'                   "Allows for autocompletion between mutliple tmux frames
    Plug 'ncm2/ncm2-cssomni'                "css
    Plug 'ncm2/ncm2-tern'                   "javascript
    Plug 'ncm2/ncm2-jedi'                   "python
    Plug 'ncm2/ncm2-racer'                  "rust
    Plug 'artur-shaik/vim-javacomplete2'    "java & jsp
    Plug 'ncm2/ncm2-pyclang'                "c/c++
    Plug 'ncm2/ncm2-vim'                    "vimscript
    Plug 'ncm2/ncm2-markdown-subscope'      "Markdown subscopes
    Plug 'ncm2/ncm2-racer'                  "Rust
    Plug 'eagletmt/neco-ghc'                "Haskel
    Plug 'ncm2/ncm2-go'                     "Go
    Plug 'Shougo/deoplete.nvim'             "A completion framework (not sure how complete the sources are)

    " Building
    Plug 'lervag/vimtex'                    "LaTex
    Plug 'ncm2/ncm2-vim'                    "vimscript
    Plug 'ObserverOfTime/ncm2-jc2'          "Java
    Plug 'gaalcaras/ncm-R'                  "R

    " To Setup/Fix
    "Plug 'lambdalisue/suda.vim'            "allows for saving file when not opened with sudo, doesn't work
    "Plug 'vim-airline/vim-airline'         "A nice status line at the bottom of the window
    "Plug 'numirias/semshi'                 "Semantic highligher (try setting up for easy reading)
call plug#end()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" for pyclang (c++ completor)
" path to directory where libclang.so can be found
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-5.0/lib'

" to shut up vimtex
let g:tex_flavor = "latex"

" enable rainbow parenthesis
let g:rainbow_active = 1

" enable deoplete completion framework
let g:deoplete#enable_at_startup = 1


"###########
"##Linting##
"###########

" consider adding pylint to python
let g:ale_linters = {
    \ 'sh': ['shellcheck', 'shfmt'],
    \ 'c': ['gcc'],
    \ 'python': ['flake8', ],
    \ 'haskell': [],
    \ 'json': ['jq'],
    \ }

" ALE config, stops lint on enter file and only lints on save
"let g:ale_lint_on_enter = 0 "seemed to break ALE
let g:ale_lint_on_save = 1

" Shut up python linting errors
let g:ale_python_flake8_options = "--ignore=E501,E226,VNE001"

"##################### as stolen from Laura
"# Fixers/Formatters #
"#####################

" Use a couple of preferred fixers/formatters for each lang
" Then cull whitespace
" Don't use for whitespace languages
let g:ale_fixers = {
    \ "*": ["trim_whitespace", "remove_trailing_lines"],
    \ "python": ["isort", "yapf", "trim_whitespace", "remove_trailing_lines"],
    \ "rust": ["rustfmt", "trim_whitespace", "remove_trailing_lines"],
    \ "sh" : ["shfmt", "trim_whitespace", "remove_trailing_lines"],
    \ "c" : ["clang-format", "trim_whitespace", "remove_trailing_lines"],
    \ "java" : ["google_java_format", "trim_whitespace", "remove_trailing_lines"],
    \ "json" : ["jq", "trim_whitespace", "remove_trailing_lines"],
    \ "go": ["gofmt", "trim_whitespace", "remove_trailing_lines"],
    \ }
let g:ale_fix_on_save = 1
let g:ale_c_clangformat_options = '-style="{BasedOnStyle: Google, IndentWidth: 4}"'


"###############
"##Custom shit##
"###############

" Laura told me to put this here so F5 executes python commands
" I don't know if this works still
autocmd FileType python nnoremap <buffer> <F5> :exec '!python3' shellescape(@%, 1)<cr>

" setting the size of tab spaces to not be stupid long
set linebreak
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab


" automatic folding enabler for used languages
" sets the foldmethod to syntax over other alternatives
au FileType cpp,c,hpp,h,javascript,zsh,java,json set foldmethod=syntax
au FileType python,html,xml,cmake set foldmethod=indent
au FileType python set foldignore=

" au FileType html set foldmethod=indent
set foldlevelstart=1
set foldnestmax=10
" reformats all folds
au BufRead * normal <CTRL-l>
" closes all folds
au BufRead * normal zM

let javaScript_fold=1       "javascript
let vimsyn_folding='af'     "vim script
let ruby_fold=1             "Ruby
let r_syntax_folding=1      "R
let perl_fold=1             "perl
let xml_syntax_folding=1    "xml


" allows accidental holding shift whilst writing commands to still run commands
command Q q
command W w

" alway set syntax on to enable code highlighting (didn't seem to make a
" difference but don't want to take chances)
syntax on

" should enable sudo saving even when file isn't opened as sudo
" doesn't work as neovim won't take sudo password
"command Sw w !sudo tee > /dev/null %
" Plugin to do that same also doesn't work
"command Sw w suda://%


" spell checking and toggling it
set spelllang=en
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>


"#####################
"##Colour and Themes##
"#####################

" should let nvim use | cursor for insert mode
" doesn't throw errors but not working on arch
:set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" set the background to be dark so that nvim nows for certain and uses light
" colours
set background=dark

set guifont=Hack

" enable pywal colour scheme
colorscheme wal
