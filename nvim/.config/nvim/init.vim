" Allow project-specific nvimrc

" exrc allows loading local executing local rc files.
set exrc
" secure disallows the use of :autocmd, shell and write commands in local .vimrc files.
set secure


" #############
" ## Plugins ##
" #############

" Requested by polyglot
set nocompatible


"vim-plug to manage plugins for nvim
call plug#begin()
	Plug 'roxma/nvim-yarp'                  " Plugin manager

    Plug 'nvim-treesitter/nvim-treesitter'  " Adds more complex syntax highlighting via treesitter (TS) (run :TSUpdate to fix some stuff)
    Plug 'p00f/nvim-ts-rainbow'             " Adds rainbow support TS
    Plug 'bollian/tree-sitter-openscad'     " Adds openscad grammar to TS

    Plug 'dense-analysis/ale'               " A collection of linters in one plugin (requires a lot of setup)

    Plug 'scrooloose/nerdcommenter'         " Easy commenting

    Plug 'tpope/vim-surround'               " use cs<><> to replace brackets, quotation marks and more

    Plug 'ryanoasis/vim-devicons'           " allows for nerd fonts (icon fonts)
    Plug 'dylanaraps/wal.vim'               " Uses pywal to get colour scheme

    Plug 'preservim/nerdtree'               " file system explorer
    Plug 'Xuyuanp/nerdtree-git-plugin'      " Added git flags to nerdtree
    Plug 'ryanoasis/vim-devicons'           " Adds file Icons to nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " Add highlighting to some file types in nerdtree

    Plug 'tpope/vim-sensible'               " Some basic starters for vim

    " Plug 'sirtaj/vim-openscad'              " OpenScad support
    Plug 'isobit/vim-caddyfile'             " Caddyfile support

    Plug 'pedrohdz/vim-yaml-folds'          " yml folding
    Plug 'NoahTheDuke/vim-just'             " Justfile colours
    Plug 'christoomey/vim-tmux-navigator'   " Adds ability to jump between tmux panes using vim split commands
    Plug 'JuliaEditorSupport/julia-vim'     " Adds unicode transformation for julia files
    Plug 'numirias/semshi'                  " Semantic highligher (try setting up for easy reading)
    Plug 'chrisbra/csv.vim'                 " CSV tabler
    " Plug 'universal-ctags/ctags'          " Ctags program which enables finding definitions
    Plug 'ludovicchabant/vim-gutentags'     " Ctags generator

    Plug 'neovim/nvim-lspconfig'            " Neovim config for LSP

    Plug 'simrat39/rust-tools.nvim'         " Rust tooling? addes debugging, autocomplete and too much extra shit

	Plug 'aklt/plantuml-syntax'				" Syntax complete for plantuml
    "Plug 'Shougo/deoplete.nvim'            " A completion framework (not sure how complete the sources are)(trying ncm2 for now)

    " Building
    Plug 'lervag/vimtex'                    "LaTex
    Plug 'ObserverOfTime/ncm2-jc2'          "Java
    Plug 'gaalcaras/ncm-R'                  "R

    " To Setup/Fix
    "Plug 'vim-airline/vim-airline'         "A nice status line at the bottom of the window
call plug#end()

" to shut up vimtex
let g:tex_flavor = "latex"


" ### NERDCommenter ###

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" ##################
" ## Autocomplete ##
" ##################

" Enable ALE autocomplete
let g:ale_completion_enabled=1
let g:ale_completion_autoimport=1

let g:ale_hover_cursor=1
let g:ale_hover_to_preview=1
" Enables latex to unicode to be evaluated in real time
let g:latex_to_unicode_auto = 1

" ## Rust-Tools ##
lua << EOF
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

EOF

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
    \ 'c': ['cc', 'flawfinder', 'ccls', 'cppcheck'],
    \ 'cpp' : ['cc', 'flawfinder', 'cclang', 'ccls', 'cppcheck'],
    \ 'h': ['gcc', 'cc', 'flawfinder', 'ccls'],
    \ 'hpp': ['gcc', 'cc', 'flawfinder', 'cclang', 'ccls'],
    \ 'rust' : ['analyzer'],
    \ 'python': ['flake8', "pylint"],
    \ 'haskell': [],
    \ 'json': ['jq'],
    \ 'markdown': ['markdownlint', 'mdl', 'remark-lint'],
    \ 'julia': ['languageserver'],
    \ 'typescript': ['deno', 'cspell', 'eslint', 'tslint', 'tsserver', 'typecheck'],
    \ 'javascript': ['deno', 'cspell', 'jshint', 'esling', 'tsserver'],
    \ }

" enable linting after a save event
let g:ale_lint_on_save = 1

" Shut up python linting errors
let g:ale_python_flake8_options = "--ignore=E501,E226,E251,VNE001"

" Enable local c/c++
let g:ale_c_cc_options="-Wall"
let g:ale_cpp_cc_options="-std=c++17 -Wall"

" Julia LanguageServer
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
    \ "rust": ["rustfmt"],
    \ "h": ["astyle"],
    \ "hpp": ["astyle"],
    \ "python": ["isort", "yapf"],
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

" Fix stupid rust formatting
let g:ale_rust_rustfmt_options = "--config brace_style=AlwaysNextLin,blank_lines_upper_bound=2,color=Always,control_brace_style=AlwaysNextLine,empty_item_single_line=false,fn_args_layout=Compressed,imports_granularity=Module,normalize_comments=true,group_imports=StdExternalCrate,trailing_comma=Never"

" #################
" ## Custom shit ##
" #################

" Enable line numbering
set number

" Allow dictionary completion on certain file types
" au FileType markdown,text let b:ncm2_look_enabled = 1

" setting the size of tab spaces to not be stupid long
set linebreak
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab



" allows accidental holding shift whilst writing commands to still run commands
command Q q
command W w

command Wq wq
command WQ wq

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

" Toggle NerdTree explorer with ctrl + T
nnoremap <C-t> :NERDTreeToggle<CR>

" ################
" ## TreeSitter ##
" ################

" TODO: move into seperate lua file

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
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int

  }
}

EOF

" ## Folding ##

" uses treesitter to generate folds based on grammars
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Doesn't allow for folding in openscad

" ensures that opening a file will automatically detect folds and close inner most
set foldlevelstart=3
set foldnestmax=50
" reformats all folds
au BufRead * normal <CTRL-l>
" closes all folds
" au BufRead * normal zM

" not sure(?)
" let javaScript_fold=1       "javascript
" let vimsyn_folding='af'     "vim script
" let ruby_fold=1             "Ruby
" let r_syntax_folding=1      "R
" let perl_fold=1             "perl
" let xml_syntax_folding=1    "xml

" syntax on

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

set statusline+=\ %=%([%l,%c%V]\ %=\ %P%)
" let nvim use | cursor for insert mode
set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20

" set the background to be dark so that nvim nows for certain and uses light colours
set background=dark

set guifont=Hack-Regular:h13:cDEFAULT

" enable pywal colour scheme
colorscheme wal
