"###########
"##Plugins##
"###########

" Requested by polyglot
set nocompatible

"vim-plug to manage plugins for nvim
call plug#begin()
    Plug 'nvim-treesitter/nvim-treesitter'  "Adds more complex syntax highlighting to nvim (unstable?)
    Plug 'dense-analysis/ale'               "A collection of linters in one plugin
	Plug 'roxma/nvim-yarp'                  "a remote plugin framework
    " Plug 'sheerun/vim-polyglot'             "language highlighting
    Plug 'scrooloose/nerdcommenter'         "Easy commenting
    Plug 'tpope/vim-surround'               "use cs<><> to replace brackets, quotation marks and more
    Plug 'ryanoasis/vim-devicons'           "allows for nerd fonts (icon fonts)
    Plug 'luochen1990/rainbow'              "rainbow parenthesis to make code more readable
    Plug 'dylanaraps/wal.vim'               "Uses pywal to get colour scheme
    " consider nerd tree preservim/nerdtree
    Plug 'tpope/vim-sensible'               "Some basic starters for vim
    Plug 'sirtaj/vim-openscad'              "OpenScad support
    "Plug 'Chiel92/vim-autoformat'           "Autoformating
    Plug 'isobit/vim-caddyfile'             " Caddyfile support
    Plug 'pedrohdz/vim-yaml-folds'          "yml folding
    Plug 'vmchale/just-vim'                 " Justfile colours

    " Autocomplete
    Plug 'ncm2/ncm2'                        "Completion manager
	Plug 'ncm2/ncm2-bufword'                "Adds words in current buffer to autocomplete
	Plug 'ncm2/ncm2-path'                   "Path autocompletion for relative and global autocompletion
    Plug 'ncm2/ncm2-tmux'                   "Allows for autocompletion between mutliple tmux frames
    Plug 'filipekiss/ncm2-look.vim'         "Adds dictionary completion using built in word lists
    Plug 'ncm2/ncm2-cssomni'                "css
    Plug 'ncm2/ncm2-tern'                   "javascript
    Plug 'ncm2/ncm2-jedi'                   "python
    Plug 'ncm2/ncm2-racer'                  "rust
    Plug 'artur-shaik/vim-javacomplete2'    "java & jsp
    Plug 'ncm2/ncm2-pyclang'                "c/c++
    Plug 'ncm2/ncm2-vim'                    "vimscript
    Plug 'Shougo/neco-vim'                  "Requirement for vimscript
    Plug 'ncm2/ncm2-markdown-subscope'      "Markdown subscopes
    Plug 'ncm2/ncm2-racer'                  "Rust
    Plug 'eagletmt/neco-ghc'                "Haskel
    Plug 'ncm2/ncm2-go'                     "Go
	Plug 'aklt/plantuml-syntax'				"Syntax complete for plantuml
    "Plug 'Shougo/deoplete.nvim'             "A completion framework (not sure how complete the sources are)(trying ncm2 for now)

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

" to shut up vimtex
let g:tex_flavor = "latex"

" enable rainbow parenthesis
let g:rainbow_active = 1

" ### NERDCommenter ###

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" ##NCM2##

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
"let g:ncm2_pyclang#library_path = system("find /usr/ -mount -iname '*libclang.so*' -print 2>/dev/null")
"let g:ncm2_pyclang#library_path = '~/.clanglib/libclang.so.1'
"let g:ncm2_pyclang#library_path = '/home/becca/.libclang.so'
"let g:ncm2_pyclang#library_path = '/usr/lib/llvm-7/lib'
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-7/lib/libclang-7.so.1'



" #######
" ##ALE##
" #######

"##Linting##

" consider adding pylint to python
let g:ale_linters = {
    \ 'sh': ['shellcheck', 'shfmt'],
    \ 'c': ['gcc', 'cc', 'flawfinder', 'ccls'],
    \ 'cpp' : ['gcc', 'cc', 'flawfinder', 'cclang'],
    \ 'h': ['gcc', 'cc', 'flawfinder', 'ccls'],
    \ 'hpp': ['gcc', 'cc', 'flawfinder', 'cclang'],
    \ 'rs' : ['cargo', 'rls'],
    \ 'python': ['flake8', "pylint"],
    \ 'haskell': [],
    \ 'json': ['jq'],
    \ 'rust': ['rls'],
    \ 'markdown': ['markdownlint', 'mdl', 'remark-lint'],
    \ }

" enable linting after a save event
let g:ale_lint_on_save = 1
" Shut up python linting errors
let g:ale_python_flake8_options = "--ignore=E501,E226,E251,VNE001"

" ##Fixers
" Encountered errors with formatting, using another plugin to do that instead

" Use a couple of preferred fixers/formatters for each lang
" Then cull whitespace
" Don't use for whitespace languages
" "yapf",, "add_blank_lines_for_python_control_statements"

let g:ale_fixers = {
    \ "*": ["trim_whitespace", "remove_trailing_lines"],
    \ "c": ["astyle"],
    \ "cpp": ["astyle"],
    \ "h": ["astyle"],
    \ "hpp": ["astyle"],
    \ "python": ["isort", "yapf"],
    \ "rust": ["rustfmt"],
    \ "sh" : ["shfmt"],
    \ "java" : ["astyle"],
    \ "json" : ["jq"],
    \ "go": ["gofmt"],
	\ "html": ["prettier"],
    \ "markdown": ["pandoc", "prettier", "remark-lint"],
    \ }

" moved to autoformat for easier parameter setting
"\ "c" : ["astyle"],
    "\ "cpp" : ["astyle"],
" allows ALE to try and fix the file after a save
let g:ale_fix_on_save = 1

" C style now moved to astylerc in $HOME
"let g:ale_cpp_astyle_project_options = '--style=allman --indent-classes --pad-oper --break-blocks --align-pointer=name --remove-braces'


"#################
"##AutoFormating##
"#################

let g:formatdef_rustfmt= '""'

"###############
"##Custom shit##
"###############

" setting the size of tab spaces to not be stupid long
set linebreak
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" automatic folding enabler for used languages
" sets the foldmethod to syntax over other alternatives
au FileType cpp,c,hpp,h,javascript,zsh,java,json,openscad,rust set foldmethod=syntax
au FileType python,html,xml,cmake,sh set foldmethod=indent
au FileType python set foldignore=

" Allow dictionary completion on certain file types
au FileType markdown,text let b:ncm2_look_enabled = 1
" ensures that opening a file will automatically detect folds and close the all
set foldlevelstart=1
set foldnestmax=50
" reformats all folds
au BufRead * normal <CTRL-l>
" closes all folds
au BufRead * normal zM

" not sure(?)
let javaScript_fold=1       "javascript
let vimsyn_folding='af'     "vim script
let ruby_fold=1             "Ruby
let r_syntax_folding=1      "R
let perl_fold=1             "perl
let xml_syntax_folding=1    "xml


" allows accidental holding shift whilst writing commands to still run commands
command Q q
command W w

command Wq wq
command WQ wq


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


" disable arrow keys
noremap <Left> :echo "No arrows for you"<CR>
noremap <Right> :echo "No arrows for you"<CR>
noremap <Up> :echo "No arrows for you"<CR>
noremap <Down> :echo "No arrows for you"<CR>

"#####################
"##Colour and Themes##
"#####################

" should let nvim use | cursor for insert mode
" doesn't throw errors but not working on arch
:set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" set the background to be dark so that nvim nows for certain and uses light
" colours
set background=dark

set guifont=Hack-Regular:h13:cDEFAULT

" enable pywal colour scheme
colorscheme wal
