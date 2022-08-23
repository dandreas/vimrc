" n/VIM config file
" v20220822

" Table of Contents "
" 1. Vim plug installation          |vimrc_plugin_manager|
"   a. Plugins                      |vimrc_plugins|
"   b. Plugin settings              |vimrc_plugin_settings|
" 2. Basic settings                 |vimrc_basic_settings|
" 3. No plugin setup                |vimrc_noplug|
" 4. General editing settings       |vimrc_general|
" 5. Macros                         |vimrc_macros|
" 6. Mappings                       |vimrc_mappings|
" 7. Functions                      |vimrc_functions|
" 8. Local settings vimrc import    |vimrc_local_settings|

" Vim Plug Installation " *vimrc_plugin_manager*
" To install vim-plug:
" 1. Download plug.vim from github.com/junegunn/vim-plug, and place it in:
"   a. .vim/autoload (vim, linux/mac)
"   b. vimfiles/autoload (vim, win) 
"   c. appdata/local/nvim/autoload (nvim, win) 
"   d. .local/share/nvim/site/autoload (nvim, linux)
" 3. If on windows, download the latest win32yank from github and paste into
" the bin directory of nvim (Only do this if clipboard does not work)
" 4. Install node (make sure it is on path) (optional, highly recommended)
"   a. npm install -g neovim
"   b. You may want to install some language servers too:
" :CocInstall coc-highlight coc-emmet coc-marketplace coc-html coc-json coc-css coc-tsserver coc-sql coc-pyright
" 5. Open vim and run :PlugInstall

" Basic settings " *vimrc_basic_settings*
set nocompatible
filetype off

" Plugins "                         *vimrc_plugins*
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')
    " vim-plug Setup
    " To install a new plugin run :PlugInstall after putting it's info here
    " L9 library, dependency for other vim plugins
    Plug 'vim-scripts/L9'
    " Gotham workspace/color/airline theme
    Plug 'whatyouhide/vim-gotham'
    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Molokai text theme
    Plug 'tomasr/molokai'
    " Base16 airline theme
    Plug 'chriskempson/base16-vim'
    " NerdTree file sidebar (just hit C-h)
    Plug 'preservim/nerdtree'
    " NerdTree Git plugin
    Plug 'preservim/nerdtree' |
                \ Plug 'Xuyuanp/nerdtree-git-plugin'
    " Surround 
    Plug 'tpope/vim-surround'
    " Ctrl-P search utility
    Plug 'ctrlpvim/ctrlp.vim'
    " Wiki functionality activated with \ww
    Plug 'vimwiki/vimwiki'
    " Adds calendar functionality into vim?
    Plug 'itchyny/calendar.vim'
    " Shows the location of a mark in the line number bar
    Plug 'kshenoy/vim-signature'
    " XML qol improvements
    Plug 'othree/xml.vim'
    " HTML qol improvements
    Plug 'othree/html5.vim'
    " Rainbow parenthesis activated with :RainbowToggle
    Plug 'luochen1990/rainbow'
    " Multi cursor (C-n for word select, up/down is c-up or c-down)
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    " Manages ctags in vim better
    Plug 'ludovicchabant/vim-gutentags'
    " One day, this would be to use cscope
    " Plug 'skywind3000/gutentags_plus'
    " Snippets (idk where these landed)
    " Plug 'SirVer/ultisnips'
    " Plug 'honza/vim-snippets'
    " Autocomplete, uses language servers if node is installed
    " If node is not installed, uses a pure vimscript solution
    if system('node -v') =~# 'node'
        " Autocomplete, pure vimscript
        Plug 'ackyshake/VimCompletesMe'
    else 
        " Autocomplete, requires node
        " https://github.com/neoclide/coc.nvim
        " use :CocInstall <extension> to add language servers
        " Installed usually: coc-highlight coc-emmet coc-marketplace coc-html coc-json
        " coc-css coc-tsserver coc-sql coc-pyright
        " Must do npm install -g neovim
        " Node must also be on the PATH
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif
    call plug#end()
endif

filetype plugin indent on

" Check if plugin manager is used
if exists(":PlugInstall")
    " Plugin Settings " *vimrc_plugin_settings*
    " NERDTree settings
    map <silent> <C-h> :NERDTreeFocus<CR>
    map <silent> <C-m> :NERDTreeFind<CR>
    let NERDTreeAutoDeleteBuffer = 1
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
    " Closes NERDTree after opening a file
    let NERDTreeQuitOnOpen = 1

    " GutenTags Configuration
    " Major credit to:
    " https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
    " Enable gtags module
    let g:gutentags_modules = ['ctags']
    " Config project root markers.
    let g:gutentags_add_default_project_roots = 0
    let g:gutentags_project_root = ['.git', 'package.json', '.root']
    " Prevents ctags from cluttering up repos
    let g:gutentags_cache_dir = expand('~/.cache/ctags/')
    " Generate ctags automatically on changes
    let g:gutentags_generate_on_new = 1
    let g:gutentags_generate_on_missing = 1
    let g:gutentags_generate_on_write = 1
    let g:gutentags_generate_on_empty_buffer = 0
    " Lets gtags generate more info
    let g:gutentags_ctags_extra_args = [
          \ '--tag-relative=yes',
          \ '--fields=+ailmnS',
          \ ]
    " Exclude files to make gtags run quicker
    let g:gutentags_ctags_exclude = [
          \ '*.git', '*.svg', '*.hg',
          \ '*/tests/*',
          \ 'build',
          \ 'dist',
          \ '*sites/*/files/*',
          \ 'bin',
          \ 'node_modules',
          \ 'bower_components',
          \ 'cache',
          \ 'compiled',
          \ 'docs',
          \ 'example',
          \ 'bundle',
          \ 'vendor',
          \ '*.md',
          \ '*-lock.json',
          \ '*.lock',
          \ '*bundle*.js',
          \ '*build*.js',
          \ '.*rc*',
          \ '*.json',
          \ '*.min.*',
          \ '*.map',
          \ '*.bak',
          \ '*.zip',
          \ '*.pyc',
          \ '*.class',
          \ '*.sln',
          \ '*.Master',
          \ '*.csproj',
          \ '*.tmp',
          \ '*.csproj.user',
          \ '*.cache',
          \ '*.pdb',
          \ 'tags*',
          \ 'cscope.*',
          \ '*.css',
          \ '*.less',
          \ '*.scss',
          \ '*.exe', '*.dll',
          \ '*.mp3', '*.ogg', '*.flac',
          \ '*.swp', '*.swo',
          \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
          \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
          \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
          \ ]
    " Change focus to quickfix window after search (optional).
    let g:gutentags_plus_switch = 1

    " Autocomplete settings
    " set encoding=utf-8 " YouCompleteMe conf
    let g:python3_host_prog = 'python'
    " let g:deoplete#enable_at_startup = 1 " Deoplete conf
    set updatetime=300
    set signcolumn=yes
    " Handle tab to complete
    inoremap <silent><expr> <Tab> 
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
    function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    " Shift-tab to go in reverse order
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    " C-Space to start autocompleting
    inoremap <silent><expr> <c-space> coc#refresh()
    " Enter to confirm a completion
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " Old neoclide/coc config
    " inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Snippet settings
    " let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardtrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"

    " Airline settings
    set laststatus=2 " Allows the powerline to run whether there are tabs or not.
    if has('gui_running') || has('unix')
        set guifont=Source_Code_Pro:h10:cANSI:qDRAFT,Source\ Code\ Pro:h12,Consolas:h10:cANSI:qDRAFT,Monaco:h10:cANSI:qDRAFT
        " This only works with a Powerline font
        " If source code pro is not available, will need to set to 0
        let g:airline_powerline_fonts = 1 
    else
        let g:airline_powerline_fonts = 0
    endif

    " This line creates the bufferline up top, disable for nvim gui
    if has('nvim')
        let g:airline#extensions#tabline#enabled = 0
    else
        let g:airline#extensions#tabline#enabled = 1
    endif
    let g:airline#extensions#tabline#buffer_nr_show = 1 " Shows numbers in tabline
    let g:airline_theme='violet' " This is the theme for airline shortlist: raven, base16, violet
    " Set up parenthesis highlights
    let g:rainbow_active = 0
    " Set the theme
    colorscheme molokai
else 
    " Pure vim basic setup for when plugins are not installed " *vimrc_noplug*
    " Set the theme
    colorscheme murphy
    " Statusline settings
    set laststatus=2 " Allows the powerline to run whether there are tabs or not.
    set statusline=
    set statusline+=%(%{&buflisted?bufnr('%'):''}\ >\ %)
    set statusline+=%< " Truncate line here
    set statusline+=%f\  " File path, as typed or relative to current directory
    set statusline+=%{&modified?'+\ ':''}
    set statusline+=%{&readonly?'>\ ':''}
    set statusline+=%= " Separation point between left and right aligned items
    set statusline+=\ %{&filetype!=#''?&filetype:'none'}
    set statusline+=%(\ >%{(&bomb\|\|&fileencoding!~#'^$\\\|utf-8'?'\ '.&fileencoding.(&bomb?'-bom':''):'')
      \.(&fileformat!=#(has('win32')?'dos':'unix')?'\ '.&fileformat:'')}%)
    set statusline+=\ >
    set statusline+=%(\ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
    set statusline+=\ >
    set statusline+=\ %{printf('%2d,',line('.'))} " Line number
    set statusline+=%-2v " Virtual column number
    set statusline+=\ %2p%% " Percentage through file in lines as in |CTRL-G|
endif

" General editor settings " *vimrc_general*
" Tab settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
" Clipboard fix (can be very finnicky, so only tested OS' are listed)
if has('nvim')
    " Neovim always uses unnamedplus
    set clipboard+=unnamedplus
else 
    " elif doesn't work in neovim
    if has('macunix') || has('win32') || has('win32unix')
        " Mac, Windows, and MSYS use unnamed
        set clipboard+=unnamed
    else
        if has('unix')
            " Non-mac unix installs use unnamedplus
            set clipboard+=unnamedplus
        endif
    endif
endif
" Makes line numbers on by default
set number relativenumber
" Set up folding 
set foldmethod=indent
" Backspace fix
set backspace=2
" Turn on syntax highlighting
syntax on
" Neovim doesn't use termwinsize
if ! has('nvim')
    " Set terminal height to 10
    set termwinsize=10x0
endif
" Autosave and autoread
" au FocusLost,WinLeave * :silent! wa
" au FocusGained,BufEnter * :silent! !
" Color Settings
set t_Co=256 "Makes everything look better
set termguicolors

" Macros " *vimrc_macros*
" Copy all (like Ctrl-A Ctrl-C in anything else)
let @c = "ggVGy"
" Tab in and move down 1
let @t = "I	j"

" Mappings " *vimrc_mappings*
" Get rid of search highlights
map <silent> <C-;> :noh<cr>
" Map // to search for clipboard text
noremap // /<C-R>"<CR>
" Map <Space> to append a single character
noremap <Space> a_<Esc>r
" Map <Space> to insert a single character
noremap <S-Space> i_<Esc>r
" Map ' to function as `
map ' `
" Set terminal to open below splits
cabbrev ter bo term
cabbrev term bo term
" Map ctags keybinds to easier spots C-J = C-Enter
" Bind C-J and C-Enter to go to definition
noremap <C-J> <C-]>
" Bind C-K to return from definition
noremap <C-K> <C-T>
" Bind C-L to search for definitions of a function
noremap <C-L> :ts <C-R>"<CR>
" Bind Shift-L to peek a definition
noremap <S-L> <C-W> }

" Functions " *vimrc_functions*
" Adds a 'Word Processor' mode for taking notes.
func! WordProcessorMode()
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu
" Sets a call for the word processor mode
com! WP call WordProcessorMode()
" Folds all functions in a large text file
func! FoldAllFunctions()
    set foldmethod=syntax
endfu
com! F call FoldAllFunctions()
" Inserts the date
func! InsertDate()
    r!date "+\%Y-\%m-\%d"
endfu
com! D call InsertDate()

" Load install specific configuration " *vimrc_local_settings*
if ! empty(glob('~/.vim/local.vim'))
    source ~/.vim/local.vim
endif
