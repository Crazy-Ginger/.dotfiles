"###########
"##Plugins##
"###########

"vim-plug to manage plugins for nvim
call plug#begin()
    Plug 'w0rp/ale'
	Plug 'roxma/nvim-yarp'              "a remote plugin framework
    Plug 'sheerun/vim-polyglot'
    Plug 'scrooloose/nerdcommenter'
"    Plug 'vim-airline/vim-airline'     "removed as it broke
    "Plug 'numirias/semshi'              "a python highlighter and static tester (possibly didn't set up correctly)
    "Plug 'lambdalisue/suda.vim'         "allows for saving file when not opened with sudo, doesn't work

    "autocomplete
    Plug 'ncm2/ncm2'
	Plug 'ncm2/ncm2-bufword'
	Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-tmux'
    Plug 'Shougo/neco-vim'
    Plug 'yuki-ycino/ncm2-dictionary'       "dictionary completion
    Plug 'ncm2/ncm2-cssomni'                "css
    Plug 'ncm2/ncm2-tern'                   "javascript
    Plug 'ncm2/ncm2-jedi'                   "python
    Plug 'ncm2/ncm2-racer'                  "rust
    "Plug 'ncm2/ncm2-pyclang'               "c++, uses clang which requires
    "building
    Plug 'lervag/vimtex'                    "LaTex
    Plug 'ncm2/ncm2-vim'                "vimscript
    Plug 'ObserverOfTime/ncm2-jc2'      "Java
    Plug 'gaalcaras/ncm-R'              "R
    Plug 'artur-shaik/vim-javacomplete2'    "java & jsp
call plug#end()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

"NOTE: you need to install completion sources to get completions. Check
"our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki

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


"###############
"##Custom shit##
"###############

" Laura told me to put this here so F5 executes python commands (I don't know
" if this works still)
autocmd FileType python nnoremap <buffer> <F5> :exec '!python3' shellescape(@%, 1)<cr> 

" setting the size of tab spaces to not be stupid long
set linebreak
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" automates the saving and loading of folds in vim (this generated loads of
" local files that stored the folds so this method was dropped for the method
" below)
" au BufWinLeave ?* mkview 1
" au BufWinEnter ?* silent loadview 1

" automatic folding enabler for used languages
" sets the foldmethod to syntax over other alternatives
au FileType cpp,c,hpp,h,javascript,zsh,java set foldmethod=syntax
au FileType python,html,xml,cmake set foldmethod=indent

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

" allows spell check for text files
au FileType text set spell spelllang=en_gb spell spellfile="$~/.vim/spell/en.utf-8.add"

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

"#####################
"##Colour and Themes##
"#####################

" allows true colours to be used in the terminal
" broke xrvt terminal
"set termguicolors

" set the background to be dark so that nvim nows for certain and uses light
" colours
set background=dark

