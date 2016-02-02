

call plug#begin('~/.vim/plugged')

" Better Settings
Plug 'https://github.com/tpope/vim-sensible.git'
Plug 'https://github.com/jeffkreeftmeijer/vim-numbertoggle.git' " smart setting of number and relative number

" Completion
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do': './install.py' }

"Plug 'https://github.com/Shougo/deoplete.nvim.git'
"Plug 'https://github.com/Shougo/deoplete-neoinclude.vim.git'
"Plug 'https://github.com/Shougo/deoplete-neco-syntax.git'
"Plug 'https://github.com/Shougo/deoplete-neco-vim.git'

" Snippets
Plug 'https://github.com/sirver/ultisnips.git'
Plug 'https://github.com/honza/vim-snippets.git'
" Alternative:
"Plug 'https://github.com/garbas/vim-snipmate.git'
"Plug 'https://github.com/tomtom/tlib_vim.git'
"Plug 'https://github.com/MarcWeber/vim-addon-mw-utils.git'

" Static Analysis
Plug 'https://github.com/scrooloose/syntastic.git'

" Apperance
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/bling/vim-bufferline.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'

" Movement & Search
Plug 'https://github.com/edsono/vim-matchit.git'
Plug 'https://github.com/haya14busa/incsearch.vim.git'
Plug 'https://github.com/haya14busa/incsearch-fuzzy.vim.git'
Plug 'https://github.com/justinmk/vim-sneak.git'
Plug 'https://github.com/tpope/vim-unimpaired.git' " pairs of handy bracket mappings
Plug 'https://github.com/nazo/pt.vim.git'

" Editing
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/tpope/vim-speeddating.git' " use CTRL-A/CTRL-X to increment dates, times, and more
                                                    " Use SpeedDatingFormat! for help defining new formats
                                                    " http://www.thegeekstuff.com/2009/10/vim-editor-how-to-increase-or-decrease-date-time-roman-number-and-ordinals/
"Plug 'https://github.com/mattn/emmet-vim.git'
Plug 'https://github.com/tpope/vim-characterize.git'
Plug 'https://github.com/bronson/vim-trailing-whitespace.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git' " Indentation level text object (i & I)
Plug 'https://github.com/Chiel92/vim-autoformat.git' " Reformat files

" Help
Plug 'https://github.com/rizzatti/dash.vim'

" Git
Plug 'https://github.com/tpope/vim-git.git'
Plug 'https://github.com/tpope/vim-fugitive.git'      " Git integration
Plug 'https://github.com/airblade/vim-gitgutter.git'

" General improvements
Plug 'https://github.com/tpope/vim-repeat.git'        " Better . (dot)
Plug 'https://github.com/svermeulen/vim-easyclip.git' " Better clipboard
Plug 'https://github.com/kopischke/vim-fetch.git'     " Open file on line and character
Plug 'https://github.com/junegunn/vim-peekaboo.git'   " Register helper
Plug 'https://github.com/majutsushi/tagbar.git'       " Display tags in a window
Plug 'https://github.com/jeetsukumaran/vim-buffergator.git' " List, select and switch between buffers
Plug 'https://github.com/amiorin/vim-project.git'
Plug 'https://github.com/tpope/vim-eunuch.git'        " helpers commands for UNIX
"Plug 'https://github.com/tpope/vim-sleuth.git'

" Plugin creating helpers
Plug 'https://github.com/vim-jp/vital.vim.git'
":Vitalize --name=cheatsheet /Users/simonweil/mine/projects/cheatsheet.vim Web.JSON
"https://github.com/mattn/webapi-vim
"https://github.com/google/vim-maktaba
"https://github.com/google/vim-glaive

"""""""""""
" NyaoVim "
"""""""""""
Plug 'https://github.com/rhysd/nyaovim-popup-tooltip.git'
Plug 'https://github.com/rhysd/nyaovim-markdown-preview.git'
"Plug '~/mine/projects/nyaovim-markdown-preview'
let g:markdown_preview_auto = 1
let g:markdown_preview_eager = 1
"Plug 'https://github.com/rhysd/nyaovim-mini-browser.git'
Plug '~/mine/projects/cheatsheet.vim'



""""""""""""""""""""
" Languge Specific "
""""""""""""""""""""
" language pack, look here to find language plugins
" https://github.com/sheerun/vim-polyglot

" Ruby
Plug 'https://github.com/vim-ruby/vim-ruby.git'
Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/tpope/vim-rails.git'
Plug 'https://github.com/tpope/vim-bundler.git'
Plug 'https://github.com/depuracao/vim-rdoc.git'
"Plug 'https://github.com/skwp/vim-rspec.git'
"Plug 'https://github.com/sunaku/vim-ruby-minitest.git'
"Plug 'https://github.com/skalnik/vim-vroom.git'
"Plug 'https://github.com/slim-template/vim-slim.git'
"Plug 'https://github.com/tpope/vim-haml.git'
"Plug 'https://github.com/tpope/vim-cucumber.git'
"Plug 'https://github.com/noprompt/vim-yardoc.git'

" Python
Plug 'https://github.com/mitsuhiko/vim-python-combined.git'

" Ember
Plug 'https://github.com/heartsentwined/vim-emblem.git'
"Plug 'https://github.com/heartsentwined/vim-ember-script.git'

" JavaScript
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/maksimr/vim-jsbeautify.git'
Plug 'https://github.com/mmalecki/vim-node.js.git'
Plug 'https://github.com/mxw/vim-jsx.git'
"Plug 'https://github.com/marijnh/tern_for_vim.git'
"Plug 'https://github.com/kchmck/vim-coffee-script.git'

" HTML
Plug 'https://github.com/othree/html5.vim.git'

" Markdown
Plug 'https://github.com/tpope/vim-markdown.git'
Plug 'https://github.com/shime/vim-livedown.git'

" SCSS / CSS
Plug 'https://github.com/ap/vim-css-color.git'
Plug 'https://github.com/JulesWang/css.vim.git'
Plug 'https://github.com/cakebaker/scss-syntax.vim.git'

" JSON
Plug 'https://github.com/elzr/vim-json.git'

" CSV
Plug 'https://github.com/chrisbra/csv.vim.git'

" PHP
"Plug 'https://github.com/StanAngeloff/php.vim.git'
"https://github.com/phpvim/phpcd.vim

" Configuration files
Plug 'https://github.com/tejr/vim-tmux.git'
Plug 'https://github.com/kurayama/systemd-vim-syntax.git'
Plug 'https://github.com/rodjek/vim-puppet.git'
Plug 'https://github.com/blueyed/nginx.vim.git'
Plug 'https://github.com/honza/dockerfile.vim.git'


"Check and add

"""Plug 'https://github.com/xolox/vim-easytags.git'
"""Plug 'https://github.com/scrooloose/nerdcommenter.git'
"""Plug 'https://github.com/itspriddle/ZoomWin.git'
"Plug 'https://github.com/mileszs/ack.vim.git'
"""Plug 'https://github.com/sjl/gundo.vim.git'
"Plug 'https://github.com/scrooloose/nerdtree.git'
"Plug 'https://github.com/mattn/webapi-vim.git'
"Plug 'https://github.com/mattn/gist-vim.git'
"Plug 'https://github.com/vim-scripts/vimwiki.git'
"""Plug 'https://github.com/chrisbra/NrrwRgn.git'
"Plug 'https://github.com/rgarver/Kwbd.vim.git'
"Plug 'https://github.com/kien/ctrlp.vim.git'
"Plug 'https://github.com/thinca/vim-visualstar.git'

"Plugin 'jalcine/snipmate-nodejs'
"Plugin 'gorodinskiy/vim-coloresque'
"Plugin 'dbakker/vim-lint'
"Plugin 'editorconfig/editorconfig-vim'
"Plugin 'gmarik/github-search.vim'
"Plugin 'godlygeek/tabular'
"Plugin 'int3/vim-extradite'
"Plugin 'jaxbot/github-issues.vim'
"Plugin 'brettof86/vim-swigjs'
"Plugin 'junegunn/vim-github-dashboard'
"Plugin 'kshenoy/vim-signature'
"Plugin 'majutsushi/tagbar'
"Plugin 'mattn/gist-vim'
"Plugin 'mattn/webapi-vim'
"Plugin 'mmozuras/vim-github-comment'
"Plugin 'perl-support.vim'
"Plugin 'syngan/vim-vimlint'
"Plugin 'tfnico/vim-gradle'
"Plugin 'thinca/vim-localrc'
"Plugin 'vim-perl/vim-perl'
"Plugin 'xolox/vim-easytags'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-notes'
"Plugin 'xolox/vim-publish'
"Plugin 'xolox/vim-session'
"Plugin 'rayburgemeestre/phpfolding.vim'
"Plugin 'shawncplus/phpcomplete.vim'
"Plugin 'heavenshell/vim-slack'
"Plugin 'tpope/vim-rsi'
"Plugin 'Chiel92/vim-autoformat'
"Plugin 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'jszakmeister/vim-togglecursor'
"Plugin 'TagHighlight'
"Plugin 'taglist.vim'
"Plugin 'tpope/vim-rbenv'
"Plugin 'chase/vim-ansible-yaml'
"Plugin 'vim-ruby/vim-ruby'
"Plugin 'guns/xterm-color-table.vim'
"Plugin 'marijnh/tern_for_vim'
"Plugin 'flazz/vim-colorschemes'
"Plugin 'tmatilai/vim-monit'
"Plugin 'SyntaxRange'
"Plugin 'farseer90718/vim-taskwarrior'
"Plugin 'KabbAmine/vCoolor.vim'
"Plugin 'fatih/vim-go'

call plug#end()


" = Vimscript file settings = {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}


" = Better settings = {{{
" Set leader key
let mapleader=" "
let maplocalleader="`"

" Highlight the screen line of the cursor
set cursorline

" Allow moving the mouse on the whole screen
set virtualedit=all

" Allow tabbed menu for completion in command mode (:)
set wildmenu

" Make y, p and d work with the clipboard
set clipboard=unnamed

" Show numbers by default
set number

" Show a 120 column width indicator
set colorcolumn=120
highlight ColorColumn ctermbg=red
au FileType help,qf,netrw,location setlocal colorcolumn=

" highlight search results
set hlsearch

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab
" }}}


" = Mappings = {{{
" ================
" Pressing kj to avoid esc for quiting insert mode
inoremap kj <Esc>l

" Make Y work like D, M, C
nnoremap Y y$

" Set marks with <localleader>m as m is used by easyclip for move (cut)
nnoremap <LocalLeader>m m

" Jump to marks with <localleader>` as ` is the localleader
nnoremap <LocalLeader>` `

" allow j and k to go up or down by visual lines rether than actual lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" display all lines with keyword under cursor
" and ask which one to jump to
nmap <LocalLeader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" find git merge conflict markers
nnoremap <LocalLeader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" }}}


" Use a special color scheme for MacVim GUI
if has("gui_running")
  colorscheme Tomorrow-Night-Bright
else
  colorscheme gruvbox
  set background=dark
endif


" search google with the word under the cursor
nmap <LocalLeader>g :call Google()<CR>
fun! Google()
  let keyword = expand("<cword>")
  let url = "http://www.google.com/search?q=" . keyword
  let path = ""
  exec 'silent !"' . path . 'open" ' . url
endfun


" = NeoVim Specific Settings = {{{
" ================================
if has('nvim')
  " = Terminal specific settings = {{{
  " ==================================
  " allow terminal buffer size to be very large
  let g:terminal_scrollback_buffer_size = 100000

  " map esc to exit to normal mode in terminal too
  tnoremap <Esc><Esc> <C-\><C-n>

  " make window commads work in the terminal from the insert mode
  tnoremap <c-w> <C-\><C-n><c-w>

  augroup terminal_vim
    autocmd!
    "autocmd BufEnter term://* normal! :QuickfixsignsDisable
    autocmd WinEnter term://* startinsert
  augroup END
  " }}}

  " Have thin cursor shap in insert mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  " enable true color support
  "let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " = Terminal and Splits movment and creation = {{{
  " ================================================
  " Move between splits
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  tnoremap <A-c> <C-\><C-n><C-w>c
  nnoremap <A-h> <C-w>h
  nnoremap <A-j> <C-w>j
  nnoremap <A-k> <C-w>k
  nnoremap <A-l> <C-w>l
  nnoremap <A-c> <C-w>c

  " New split creation
  tnoremap <A-d>    <C-\><C-n>:vsp<bar>enew<CR>
  tnoremap <A-s-d>  <C-\><C-n>:sp<bar>enew<CR>
  inoremap <A-d>    <ESC>:vsp<bar>enew<CR>
  inoremap <A-s-d>  <ESC>:sp<bar>enew<CR>
  nnoremap <A-d>    :vsp<bar>enew<CR>
  nnoremap <A-s-d>  :sp<bar>enew<CR>

  " New terminal creation
  tnoremap <A-t>    <C-\><C-n>:vsp<bar>enew<bar>call termopen("bash -l")<CR>
  tnoremap <A-s-t>  <C-\><C-n>:sp<bar>enew<bar>call termopen("bash -l")<CR>
  inoremap <A-t>    <ESC>:vsp<bar>enew<bar>call termopen("bash -l")<CR>
  inoremap <A-s-t>  <ESC>:sp<bar>enew<bar>call termopen("bash -l")<CR>
  nnoremap <A-t>    :vsp<bar>enew<bar>call termopen("bash -l")<CR>
  nnoremap <A-s-t>  :sp<bar>enew<bar>call termopen("bash -l")<CR>
  " }}}
endif
" }}}


" vimrc helpers
nnoremap <localleader>sv :source ~/.nvimrc<cr>
nnoremap <localleader>eva :vsplit ~/.nvimrc<cr>
nnoremap <localleader>evb :vsplit ~/.nvimrc<cr>


" Indent Guides Settings
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 15
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']


" Number Toggle
let g:NumberToggleTrigger="<localleader>n"


" Multiple Cursors
let g:multi_cursor_next_key='<A-S-n>'
let g:multi_cursor_prev_key='<A-S-p>'
let g:multi_cursor_skip_key='<A-S-x>'
"let g:multi_cursor_quit_key='<Esc>'

" Airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'

" remove the buffer list from the command line
let g:bufferline_echo = 0

" Tagbar
nmap <F8> :TagbarToggle<CR>

" UltiSnip
let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-Tab>'

let g:UltiSnipsExpandTrigger       = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Enable tabbing through list of results
function! g:UltiSnips_Complete()
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res == 0
		if pumvisible()
			return "\<C-n>"
		else
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				return "\<TAB>"
			endif
		endif
	endif
	return ""
endfunction

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" Expand snippet or return
let g:ulti_expand_res = 0
function! Ulti_ExpandOrEnter()
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res
		return ''
	else
		return "\<return>"
	endif
endfunction

" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>


" = Syntastic = {{{
" =================
" maybe relace with: https://github.com/benekastah/neomake
" ---------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1 " Run all checkers
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_enable_signs = 1

" https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
let g:syntastic_python_checkers = ['pylama']
" }}}


" = incsearch = {{{
" ========================
" TODO: Maybe switch to https://github.com/junegunn/vim-oblique
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Turn off high lighting automaticly
" :h g:incsearch#auto_nohlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Fuzzy Searching
function! s:config_fuzzyall(...) abort
  return extend(copy({
  \   'converters': [
  \     incsearch#config#fuzzy#converter(),
  \     incsearch#config#fuzzyspell#converter()
  \   ],
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))
" }}}


" = Fugitive = {{{
" ========================
nmap <localleader>gb :Gblame<CR>
nmap <localleader>gs :Gstatus<CR>
nmap <localleader>gd :Gdiff<CR>
nmap <localleader>gl :Glog<CR>
nmap <localleader>gc :Gcommit<CR>
" }}}


" Mappings for the Dash.app
nmap <silent> <localleader>d <Plug>DashSearch

" Mapping to open Markdown preview (vim-livedown)
nmap gm :LivedownToggle<CR>

" Setting tab witdh by file type
autocmd Filetype html setlocal tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab

if has('dontdoathis')
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
inoremap <expr><Tab> deoplete#mappings#close_popup()
inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"
"deoplete#mappings#manual_complete()
"set shortmess+=c
"set completeopt+=noinsert





" ----------------------------------------------------------
" setup the projects: https://github.com/amiorin/vim-project
" ----------------------------------------------------------
" Enable Nerd treee
let g:project_use_nerdtree = 1

" Set my starting path
call project#rc("~/work/")

" My projects
Project '~/mine/dev/Community' , 'Community'
Project '~/.dotfiles'          , 'My DotFiles :)'
endif
