" #############
" ## Plugins ##
" #############

" Requested by polyglot
set nocompatible

"vim-plug to manage plugins for nvim
call plug#begin()
    Plug 'nvim-treesitter/nvim-treesitter'  " Adds more complex syntax highlighting to nvim (unstable?) (run :TSUpdate to fix some stuff)
    Plug 'dense-analysis/ale'               " A collection of linters in one plugin
	Plug 'roxma/nvim-yarp'                  " a remote plugin framework
    " Plug 'sheerun/vim-polyglot'           " language highlighting
    Plug 'scrooloose/nerdcommenter'         " Easy commenting
    Plug 'tpope/vim-surround'               " use cs<><> to replace brackets, quotation marks and more
    Plug 'ryanoasis/vim-devicons'           " allows for nerd fonts (icon fonts)
    Plug 'luochen1990/rainbow'              " rainbow parenthesis to make code more readable
    Plug 'dylanaraps/wal.vim'               " Uses pywal to get colour scheme

    Plug 'preservim/nerdtree'               " file system explorer
    Plug 'Xuyuanp/nerdtree-git-plugin'      " Added git flags to nerdtree
    Plug 'ryanoasis/vim-devicons'           " Adds file Icons to nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/vim-sensible'               " Some basic starters for vim
    Plug 'sirtaj/vim-openscad'              " OpenScad support
    Plug 'isobit/vim-caddyfile'             " Caddyfile support
    Plug 'pedrohdz/vim-yaml-folds'          " yml folding
    Plug 'NoahTheDuke/vim-just'             " Justfile colours
    Plug 'christoomey/vim-tmux-navigator'   " Adds ability to jump between tmux panes using vim split commands
    Plug 'JuliaEditorSupport/julia-vim'     " Adds unicode transformation for julia files
    Plug 'numirias/semshi'                  " Semantic highligher (try setting up for easy reading)
    Plug 'chrisbra/csv.vim'                 " CSV tabler

    Plug 'neovim/nvim-lspconfig'            " Neovim config for LSP

    " Autocomplete
    Plug 'ncm2/ncm2'                        " Completion manager
	Plug 'ncm2/ncm2-bufword'                " Adds words in current buffer to autocomplete
	Plug 'ncm2/ncm2-path'                   " Path autocompletion for relative and global autocompletion
    Plug 'ncm2/ncm2-tmux'                   " Allows for autocompletion between mutliple tmux frames
    Plug 'filipekiss/ncm2-look.vim'         " Adds dictionary completion using built in word lists
    " Plug 'svermeulen/ncm2-yoink'           " Yank history (throws error over missing function)

    Plug 'ncm2/ncm2-cssomni'                " css
    Plug 'ncm2/ncm2-html-subscope'          " html subscopes
    Plug 'ncm2/ncm2-tern'                   " javascript
    Plug 'mhartington/nvim-typescript'      " typescript
    Plug 'ncm2/ncm2-jedi'                   " python
    Plug 'artur-shaik/vim-javacomplete2'    " java & jsp
    Plug 'ncm2/ncm2-pyclang'                " c/c++
    Plug 'ncm2/ncm2-vim'                    " vimscript
    Plug 'Shougo/neco-vim'                  " Requirement for vimscript
    Plug 'ncm2/ncm2-markdown-subscope'      " Markdown subscopes
    Plug 'ncm2/ncm2-racer'                  " Rust
    Plug 'eagletmt/neco-ghc'                " Haskel
    Plug 'ncm2/ncm2-go'                     " Go
	Plug 'aklt/plantuml-syntax'				" Syntax complete for plantuml
    "Plug 'Shougo/deoplete.nvim'            " A completion framework (not sure how complete the sources are)(trying ncm2 for now)

    " Building
    Plug 'lervag/vimtex'                    "LaTex
    Plug 'ncm2/ncm2-vim'                    "vimscript
    Plug 'ObserverOfTime/ncm2-jc2'          "Java
    Plug 'gaalcaras/ncm-R'                  "R

    " To Setup/Fix
    "Plug 'vim-airline/vim-airline'         "A nice status line at the bottom of the window
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
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" for pyclang (c++ completor)
" path to directory where libclang.so can be found (used a symlink to get
" around issues using both debian and arch but requires sudo)
let g:ncm2_pyclang#library_path = '/usr/lib/libclang.so'

" Enables latex to unicode to be evaluated in real time
let g:latex_to_unicode_auto = 1

" Auto CSV formatting
let g:csv_autocmd_arrange	   = 1
let g:csv_autocmd_arrange_size = 1024*1024

" #############
" ## Linting ##
" #############

" Linting currently done via ALE

" consider adding pylint to python
let g:ale_linters = {
    \ 'sh': ['shellcheck', 'shfmt'],
    \ 'c': ['cc', 'flawfinder', 'ccls'],
    \ 'cpp' : ['cc', 'flawfinder', 'cclang', 'ccls', 'cppcheck'],
    \ 'h': ['gcc', 'cc', 'flawfinder', 'ccls'],
    \ 'hpp': ['gcc', 'cc', 'flawfinder', 'cclang', 'ccls'],
    \ 'rs' : ['cargo', 'rls'],
    \ 'python': ['flake8', "pylint"],
    \ 'haskell': [],
    \ 'json': ['jq'],
    \ 'rust': ['rls'],
    \ 'markdown': ['markdownlint', 'mdl', 'remark-lint'],
    \ 'julia': ['languageserver'],
    \ 'typescript': ['deno', 'cspell', 'eslint', 'tslint', 'tsserver', 'typecheck'],
    \ 'javascript': ['deno', 'cspell', 'jshint', 'esling', 'tsserver'],
    \ }

" enable linting after a save event
let g:ale_lint_on_save = 1
" Shut up python linting errors
let g:ale_python_flake8_options = "--ignore=E501,E226,E251,VNE001"

let g:ale_julia_executable = "~/.julia/packages/LanguageServer/NWirc/src/LanguageServer.jl"


" ###############
" ## Formating ##
" ###############

" Formatting mostly done via ALE
" Encountered errors with formatting, using another plugin to do that instead

" Use a couple of preferred fixers/formatters for each lang
" Then cull whitespace
" Don't use for whitespace languages

let g:ale_fixers = {
    \ "*": ["trim_whitespace", "remove_trailing_lines"],
    \ "c": ["astyle"],
    \ "cpp": ["astyle"],
    \ "cuda": ["astyle"],
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
    \ "typescript": ['dprint', 'eslint', 'deno'],
    \ "javascript": ['dprint', 'eslint', 'importjs'],
    \ }

" allows ALE to try and fix the file after a save
let g:ale_fix_on_save = 1

" C/C++ style options is done via .astylerc in $HOME

" TODO: sort out rustfmt options to make it nice
let g:formatdef_rustfmt= '""'

" #################
" ## Custom shit ##
" #################

" Enable line numbering
set number


" Allow dictionary completion on certain file types
au FileType markdown,text let b:ncm2_look_enabled = 1

" setting the size of tab spaces to not be stupid long
set linebreak
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" automatic folding enabler for used languages
" sets the foldmethod to syntax over other alternatives
au FileType cpp,c,hpp,h,cuda,javascript,zsh,java,json,openscad,rust,html,proto set foldmethod=syntax
au FileType python,xml,cmake,sh,vim set foldmethod=indent

" ensures that opening a file will automatically detect folds and close the all
set foldlevelstart=3
set foldnestmax=50
" reformats all folds
au BufRead * normal <CTRL-l>
" closes all folds
" au BufRead * normal zM

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

" nvim-treesitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = true,
  ensure_installed = {
      "cpp", "c", "python", "java", "javascript", "cmake", "cuda", "css", "html", "dockerfile", "foam", "json", "latex", "make", "llvm", "regex", "rust", "typescript", "vim", "yaml", "markdown"
    },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
EOF

syntax on

" spell checking and toggling it
set spelllang=en
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>


" disable arrow keys
noremap <Left> :echo "No arrows for you"<CR>
noremap <Right> :echo "No arrows for you"<CR>
noremap <Up> :echo "No arrows for you"<CR>
noremap <Down> :echo "No arrows for you"<CR>

" Allow vim panel navigation with control-arrows
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

nnoremap <silent> <C-H> <c-w>

" set iskeyword-=_

nnoremap <C-t> :NERDTreeToggle<CR>


" ###################
" ## GUI & Colour ###
" ###################

" TODO: add abbreviated file path before filename
" TODO: highlighting of important information with colours
" set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
" Show filename and filetype
set statusline=%F\ >%Y
" readonly flags and the like
set statusline+=\ %h%w%m%r
"
set statusline+=\ %=%([%l,%c%V]\ %=\ %P%)
" should let nvim use | cursor for insert mode
" doesn't throw errors but not working on arch
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" set the background to be dark so that nvim nows for certain and uses light
" colours
set background=dark

set guifont=Hack-Regular:h13:cDEFAULT

" enable pywal colour scheme
colorscheme wal
