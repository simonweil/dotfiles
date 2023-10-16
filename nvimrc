
call plug#begin('~/.vim/plugged')

" Better Settings
Plug 'https://github.com/tpope/vim-sensible.git'
Plug 'https://github.com/jeffkreeftmeijer/vim-numbertoggle.git' " smart setting of number and relative number

" Completion
Plug 'https://github.com/neovim/nvim-lspconfig.git' " TODO: check in wiki for many more improvements
" More: https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources
Plug 'https://github.com/Shougo/deoplete.nvim.git'
Plug 'https://github.com/Shougo/neco-vim.git'               " vim source for Vim script
Plug 'https://github.com/Shougo/neoinclude.vim.git'         " include and file/include sources
Plug 'https://github.com/Shougo/neco-syntax.git'            " syntax source
Plug 'https://github.com/deoplete-plugins/deoplete-jedi'    " pythom source
"Plug 'https://github.com/kristijanhusak/vim-dadbod-completion' " SQL
Plug 'https://github.com/deoplete-plugins/deoplete-lsp.git'
Plug 'https://github.com/deoplete-plugins/deoplete-docker.git'

Plug 'https://github.com/ervandew/supertab.git'
let g:SuperTabDefaultCompletionType = "<c-n>" " Make the tabing on completion menu go from top to bottom
let g:SuperTabClosePreviewOnPopupClose = 1 " Close the preview when completion ends

" Snippets
Plug 'https://github.com/sirver/ultisnips.git'
" Don't map any tabs, I'll do it later
let g:UltiSnipsExpandTrigger = '<NOP>'
let g:UltiSnipsJumpForwardTrigger = '<NOP>'
let g:UltiSnipsJumpBackwardTrigger = '<NOP>'
let g:SuperTabMappingBackward = '<NOP>'
" Don't unmap my mappings
let g:UltiSnipsMappingsToIgnore = [ "SmartTab", "SmartShiftTab" ]

" Make <CR> smart
let g:ulti_expand_res = 0
function! Ulti_ExpandOrEnter()
  " First try to expand a snippet
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res
    " if successful, just return
    return ''
  elseif pumvisible()
    " if in completion menu - just close it and leave the cursor at the
    " end of the completion
    return deoplete#close_popup()
  else
    " otherwise, just do an "enter"
    return "\<return>"
  endif
endfunction
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>

" Enable tabbing and shift-tabbing through list of results
function! g:SmartTab()
  if pumvisible()
    return SuperTab("n")
  else
    call UltiSnips#JumpForwards()
    if g:ulti_jump_forwards_res == 0
      return SuperTab("n")
    endif
    return ''
  endif
endfunction
inoremap <silent> <tab> <C-R>=g:SmartTab()<cr>
snoremap <silent> <tab> <Esc>:call g:SmartTab()<cr>

function! g:SmartShiftTab()
  if pumvisible()
    return SuperTab("p")
  else
    call UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
      return SuperTab("p")
    endif
    return ''
  endif
endfunction
inoremap <silent> <s-tab> <C-R>=g:SmartShiftTab()<cr>
snoremap <silent> <s-tab> <Esc>:call g:SmartShiftTab()<cr>

Plug 'https://github.com/honza/vim-snippets.git'

" Static Analysis
Plug 'https://github.com/neomake/neomake.git'

" Apperance
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
"Plug 'https://github.com/bling/vim-bufferline.git' -
Plug 'https://github.com/lukas-reineke/indent-blankline.nvim.git'
Plug 'ryanoasis/vim-devicons' " add nice icons to the status line, tabline, etc.

" Movement & Search
Plug 'https://github.com/haya14busa/incsearch.vim.git'
Plug 'https://github.com/haya14busa/incsearch-fuzzy.vim.git'
Plug 'https://github.com/justinmk/vim-sneak.git'
Plug 'https://github.com/tpope/vim-unimpaired.git' " pairs of handy bracket mappings - use: [ with q,a,b,<space>,x,u,y,f,n
Plug 'https://github.com/mhinz/vim-grepper.git', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
let g:grepper = {}
let g:grepper.dir = 'repo,file'
let g:grepper.tools = ['rg', 'ag', 'git', 'grep']
autocmd! User vim-grepper let g:grepper.git.grepprg .= ' --no-color'
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
nnoremap <leader>* :Grepper -tool rg -open -switch -cword -noprompt<cr>
command! Todo Grepper -noprompt -tool git -query -E '(TODO|FIXME|XXX):'


"""""""""""
" Editing "
"""""""""""
Plug 'https://github.com/numToStr/Comment.nvim.git' " Better commenting of code
Plug 'https://github.com/tpope/vim-surround.git' " TODO: learn to use
Plug 'https://github.com/jiangmiao/auto-pairs.git' " Use <a-e> to toggle autopairs
Plug 'https://github.com/tpope/vim-speeddating.git' " use CTRL-A/CTRL-X to increment dates, times, and more - TODO: learn to use
                                                    " Use SpeedDatingFormat! for help defining new formats
                                                    " http://www.thegeekstuff.com/2009/10/vim-editor-how-to-increase-or-decrease-date-time-roman-number-and-ordinals/
"Plug 'https://github.com/mjbrownie/swapit.git' " increment/swap different types like true/false TODO: test
"Plug 'https://github.com/mattn/emmet-vim.git' " TODO: learn to use
Plug 'https://github.com/tpope/vim-characterize.git'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:show_spaces_that_precede_tabs=1
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

"Plug 'https://github.com/mg979/vim-visual-multi.git' " TODO: learn to use
"" disable deoplate when using multiplae cursors (see: https://github.com/Shougo/deoplete.nvim/blob/master/doc/deoplete.txt#L1070)
"function g:Multiple_cursors_before()
"  let g:deoplete#disable_auto_complete = 1
"endfunction
"function g:Multiple_cursors_after()
"  let g:deoplete#disable_auto_complete = 0
"endfunction

" Text objects
Plug 'https://github.com/kana/vim-textobj-user.git'           " Needed to define custom text objects
Plug 'https://github.com/michaeljsmith/vim-indent-object.git' " Indentation level text object (i & I)
Plug 'https://github.com/rhysd/vim-textobj-anyblock'          " Use b to for the closest of '', \"\", (), {}, [] and <>

Plug 'https://github.com/Chiel92/vim-autoformat.git'          " Reformat files
"checkout https://github.com/sbdchd/neoformat instead of previous...
"Plug 'https://github.com/foosoft/vim-argwrap.git' " TODO: learn to use and define mapping

Plug 'https://github.com/dhruvasagar/vim-table-mode.git' " For working with tables, Lazy load when using TableModeToggle - TODO: learn to use

" Help
Plug 'https://github.com/rizzatti/dash.vim' " TODO: learn to use

"
" Git
"
Plug 'https://github.com/tpope/vim-git.git'
Plug 'https://github.com/tpope/vim-fugitive.git'      " Git integration - TODO: learn to use
Plug 'https://github.com/tpope/vim-rhubarb.git'       " Github integration for fugitive
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/rhysd/committia.vim.git'     " Better commiting messageing
Plug 'https://github.com/APZelos/blamer.nvim.git'
let g:blamer_enabled = 1

Plug 'https://github.com/rhysd/git-messenger.vim.git', {'on': ['GitMessenger', '<Plug>(git-messenger']}

" Commita config
let g:committia_open_only_vim_starting = 1
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
  " Additional settings
  setlocal spell

  " If no commit message, start with insert mode
  if a:info.vcs ==# 'git' && getline(1) ==# ''
    startinsert
  end

  " Scroll the diff window from insert mode
  " Map <C-n> and <C-p>
  imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
  imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" General improvements
Plug 'https://github.com/tpope/vim-repeat.git'        " Better .
Plug 'https://github.com/svermeulen/vim-easyclip.git' " Better clipboard - TODO: learn to use
Plug 'https://github.com/kopischke/vim-fetch.git'     " Open file on line and character
"Plug 'https://github.com/junegunn/vim-peekaboo.git'   " Register helper - TODO: learn to use - perhaps remove as whichkey gives the functionality
Plug 'https://github.com/majutsushi/tagbar.git'       " Display tags in a window - TODO: learn to use
Plug 'https://github.com/jeetsukumaran/vim-buffergator.git' " List, select and switch between buffers - TODO: learn to use
Plug 'https://github.com/amiorin/vim-project.git'     " TODO: learn to use
Plug 'https://github.com/tpope/vim-eunuch.git'        " helpers commands for UNIX - TODO: learn to use
"Plug 'https://github.com/tpope/vim-sleuth.git' - TODO: test and learn

" Plugin creating helpers
Plug 'https://github.com/vim-jp/vital.vim.git'
":Vitalize --name=cheatsheet /Users/simonweil/mine/projects/cheatsheet.vim Web.JSON
"https://github.com/mattn/webapi-vim
"https://github.com/google/vim-maktaba
"https://github.com/google/vim-glaive

""""""""""""""""
" Fuzzy Things "
""""""""""""""""
Plug '/usr/local/opt/fzf'
Plug 'https://github.com/junegunn/fzf.vim.git'
let g:fzf_commits_log_options = '--color=always --pretty=format:"%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset" --abbrev-commit --date=relative'

Plug 'https://github.com/voldikss/vim-floaterm.git'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_opener = 'edit'
let g:floaterm_keymap_new    = '<F5>'
let g:floaterm_keymap_toggle = '<F6>'

" Install plugin dependencies
Plug 'https://github.com/kyazdani42/nvim-web-devicons.git'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter.git', {'do': ':TSUpdate'}
Plug 'https://github.com/nvim-lua/popup.nvim.git'
Plug 'https://github.com/nvim-lua/plenary.nvim.git'
"
" Install Telescope
Plug 'https://github.com/nvim-telescope/telescope.nvim.git'
Plug 'https://github.com/nvim-telescope/telescope-fzf-native.nvim.git', { 'do': 'make' }
Plug 'https://github.com/xiyaowong/telescope-emoji.nvim.git'
Plug 'https://github.com/ANGkeith/telescope-terraform-doc.nvim.git'

" Navigation and work assistance
Plug 'https://github.com/kyazdani42/nvim-tree.lua.git'
Plug 'https://github.com/sudormrfbin/cheatsheet.nvim.git'
Plug 'https://github.com/folke/which-key.nvim.git'

""""""""""""""""""""
" External plugins "
""""""""""""""""""""
" Plug 'https://github.com/glacambre/firenvim.git', { 'do': function('firenvim#install') }
"
" " Exclude from intercom chats and google docs
" let g:firenvim_config = {
"     \ 'localSettings': {
"         \ '.*': {
"             \ 'selector': '*:not(.intercom-composer) > textarea',
"             \ 'priority': 0,
"         \ },
"         \ 'docs\.google\.com': {
"             \ 'selector': '',
"             \ 'priority': 1,
"         \ },
"         \ '.*\.atlassian.net': {
"             \ 'selector': '',
"             \ 'priority': 1,
"         \ },
"     \ }
" \ }
"
" if exists('g:started_by_firenvim')
"   " Make github textareas be with markdown syntax
"   au BufEnter github.com_*.txt set filetype=markdown
"
"   " Allow moving focus back to the page with double esc
"   nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
"
"   " Write the buffer contents back to the page all the time automaticly
"   au TextChanged * ++nested write
"   au TextChangedI * ++nested write
" endif



""""""""""""""""""""
" Languge Specific "
""""""""""""""""""""
" language pack, look here to find language plugins
Plug 'https://github.com/sheerun/vim-polyglot.git'
"https://github.com/vim-python/python-syntax - TODO: check that settings are good for me
let g:polyglot_disabled = ['ruby', 'puppet']

" Set filetype in by context in of the file (e.g. javascript tag in an html file)
"Plug 'https://github.com/Shougo/context_filetype.vim.git' - TODO: test!

" SQL
"Plug 'https://github.com/tpope/vim-dadbod'
"Plug 'https://github.com/kristijanhusak/vim-dadbod-ui'

" Ruby
Plug 'https://github.com/vim-ruby/vim-ruby.git', {'for': 'ruby'}
Plug 'https://github.com/tpope/vim-endwise.git', {'for': 'ruby'}
Plug 'https://github.com/tpope/vim-rails.git', {'for': 'ruby'}
Plug 'https://github.com/tpope/vim-bundler.git', {'for': 'ruby'}
Plug 'https://github.com/depuracao/vim-rdoc.git', {'for': 'ruby'}
"Plug 'https://github.com/skwp/vim-rspec.git'
"Plug 'https://github.com/sunaku/vim-ruby-minitest.git'
"Plug 'https://github.com/skalnik/vim-vroom.git'
"Plug 'https://github.com/slim-template/vim-slim.git'
"Plug 'https://github.com/tpope/vim-haml.git'
"Plug 'https://github.com/tpope/vim-cucumber.git'
"Plug 'https://github.com/noprompt/vim-yardoc.git'

" Python
Plug 'https://github.com/mjbrownie/django-template-textobjects.git' " TODO: learn to use

" JavaScript
Plug 'https://github.com/pangloss/vim-javascript.git' " TODO: keep? or use polyglot
Plug 'https://github.com/maksimr/vim-jsbeautify.git'
Plug 'https://github.com/mmalecki/vim-node.js.git' " TODO: keep? or use polyglot
Plug 'https://github.com/mxw/vim-jsx.git' " TODO: keep? or use polyglot
"Plug 'https://github.com/marijnh/tern_for_vim.git'
"Plug 'https://github.com/kchmck/vim-coffee-script.git'

" Markdown
Plug 'https://github.com/tpope/vim-markdown.git' " TODO: test
Plug 'https://github.com/shime/vim-livedown.git' " TODO: test

" SCSS / CSS
Plug 'https://github.com/ap/vim-css-color.git'
Plug 'https://github.com/JulesWang/css.vim.git' " TODO: keep? or use polyglot
Plug 'https://github.com/cakebaker/scss-syntax.vim.git' " TODO: keep? or use polyglot

" CSV
Plug 'https://github.com/chrisbra/csv.vim.git'

" PHP
"Plug 'https://github.com/StanAngeloff/php.vim.git'
"https://github.com/phpvim/phpcd.vim

" Configuration files
Plug 'https://github.com/rodjek/vim-puppet.git', {'for': 'puppet'}


"Check and add

"https://github.com/raghur/vim-ghost
"https://github.com/jalvesaq/vimcmdline
"https://github.com/hardenedapple/vsh
"https://github.com/lucc/nvimpager
"https://github.com/cyansprite/Extract
"https://github.com/krisajenkins/vim-projectlocal
"https://github.com/Vigemus/nvimux
"https://gitlab.com/HiPhish/repl.nvim
"https://github.com/neoclide/coc.nvim - LSP support
"https://github.com/brooth/far.vim - better find/replace
"https://github.com/jsfaint/gen_tags.vim
"https://github.com/kassio/neoterm - better terminal
"https://github.com/brettanomyces/nvim-editcommand
"https://github.com/numirias/semshi
"https://github.com/tek/proteome
"https://github.com/teto/nvim-palette
"https://github.com/bfredl/nvim-miniyank
"https://github.com/bfredl/nvim-ipy
"https://github.com/brettanomyces/nvim-terminus
"https://github.com/sheerun/vim-polyglot
"https://github.com/Shougo/denite.nvim
"Plug 'https://github.com/xolox/vim-easytags.git'
"Plug 'https://github.com/scrooloose/nerdcommenter.git'
"Plug 'https://github.com/itspriddle/ZoomWin.git'
"Plug 'https://github.com/mileszs/ack.vim.git'
"https://github.com/mbbill/undotree.git
"Plug 'https://github.com/scrooloose/nerdtree.git'
"Plug 'https://github.com/mattn/webapi-vim.git' - plugin development
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
"Plugin 'mmozuras/vim-github-comment'
"Plugin 'perl-support.vim'
"Plugin 'syngan/vim-vimlint'
"https://github.com/dbakker/vim-lint
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
"https://github.com/vim-ctrlspace/vim-ctrlspace
"https://github.com/edkolev/promptline.vim

" Use patience algorithm for vim diff
set diffopt+=internal,algorithm:patience

call plug#end()


" = Vimscript file settings = {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker keywordprg=:help
  autocmd Filetype vim setlocal softtabstop=2 shiftwidth=2 smarttab
augroup END
" }}}


" = Better settings = {{{
" Set leader key
let mapleader="`"
let maplocalleader="'"

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
highlight ColorColumn ctermbg=12 guibg=Red
au FileType help,qf,netrw,location,git setlocal colorcolumn=

" highlight search results
set hlsearch

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

" Spelling
if !&readonly
  augroup spellcheck
    autocmd!
    autocmd FileType markdown setlocal spell complete+=kspell
  augroup END
endif
let &spellfile = $HOME . "/.dotfiles/vim/dictionary.en.add"

" Turn on true colors
set termguicolors

" Turn on live substitute
set inccommand=split

" Python executables
"let g:python_host_prog = $HOME . '/work/virtualenvs/neovim/bin/python'
let g:python3_host_prog = $HOME . '/work/virtualenvs/neovim3/bin/python'

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

" Underline the current line with any char or a specific rule in specific filetypes
function! UnderlineCurrentLine(...) abort
  let line = getline('.')

  " For markdown files, underline headers of tables specially
  if &filetype ==? "markdown" && line[0] == '|' && line[len(line)-1] == '|'
    execute "normal! :t.\<CR>:s/[^|]/-/g\<CR>"
    return
  endif

  let _c = getchar()
  let c = type(_c) == type(0) ? nr2char(_c) : _c
  if c ==# "\<Esc>" || c == "\<C-c>"
    return
  endif

  execute "normal! :t.\<CR>Vr" . c

  " In insert mode end on the next line back in insert mode
  if a:0 == 1 && a:1 ==? "i"
    normal! o
    startinsert
  endif
endfunction
nmap <silent> <leader>ul :call UnderlineCurrentLine()<CR>
imap <silent> <leader>ul <ESC>:call UnderlineCurrentLine("i")<CR>

" }}}


" Use a special color scheme for MacVim GUI
colorscheme gruvbox
set background=dark


" search google with the word under the cursor
nmap <LocalLeader>g :call Google()<CR>
fun! Google()
  let keyword = expand("<cword>")
  let url = "http://www.google.com/search?q=" . keyword
  let path = ""
  exec 'silent !"' . path . 'open" ' . url
endfun

" = Plugins setup = {{{
" =====================
lua << EOF
  require('nvim-web-devicons').setup()
  require('telescope').setup()
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('emoji')
  require('telescope').load_extension('terraform_doc')
  require('nvim-tree').setup()
  require("which-key").setup()

  -- Config: https://github.com/numToStr/Comment.nvim#configuration-optional
  require('Comment').setup()
EOF

" Keymaps
nnoremap gtf :Telescope terraform_doc full_name=hashicorp/aws version=3.74.3<cr>
nnoremap gof :Telescope oldfiles<cr>
nnoremap gob :FloatermNew broot<cr>
"nnoremap <F1> :Telescope project<cr>
nnoremap <F2> :Telescope git_files<cr>
nnoremap <F3> :Telescope commands<cr>
nnoremap <F4> :Telescope buffers<cr>
nnoremap <F9> :NvimTreeToggle<CR>

" Telescope
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

"""""""""""""""""""""""""
" Vim Plug Improvements "
"""""""""""""""""""""""""
function! s:plug_doc()
  let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
  if has_key(g:plugs, name)
    for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
      execute 'tabe' doc
    endfor
  endif
endfunction

function! s:plug_gx()
  let line = getline('.')
  let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
  let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                      \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let uri  = get(get(g:plugs, name, {}), 'uri', '')
  if uri !~ 'github.com'
    return
  endif
  let repo = matchstr(uri, '[^:/]*/'.name)
  let url  = empty(sha) ? 'https://github.com/'.repo
                      \ : printf('https://github.com/%s/commit/%s', repo, sha)
  call netrw#BrowseX(url, 0)
endfunction

augroup PlugGx
  autocmd!
  autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
  autocmd FileType vim-plug nnoremap <buffer> <silent> H :call <sid>plug_doc()<cr>
augroup END

" }}}

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
  "tnoremap <c-w> <C-\><C-n><c-w> - disabled as this prevents terminal <c-w> which deletes a word

  augroup terminal_vim
    autocmd!
    autocmd WinEnter term://* startinsert
  augroup END
  " }}}


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

  " = Lua stuff = {{{
  " =================
  augroup LuaHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
  augroup END
  " }}}
endif
" }}}


" vimrc helpers
nnoremap <localleader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <localleader>eva :vsplit ~/.config/nvim/init.vim<cr>

" Deoplate
let deoplete#sources#jedi#show_docstring = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#lsp#use_icons_for_candidates = v:true
call deoplete#custom#option({
\ 'smart_case': v:true,
\ 'num_processes': 0,
\ })

" Setup LSP servers
" Configurations: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
" Possible: SQL, CSS, HTML
lua << EOF
  local lspconfig = require 'lspconfig'
  local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  end

  local servers = { 'bashls', 'dockerls', 'jsonls', 'vimls', 'jedi_language_server', 'terraformls' }
  -- removed 'terraformls',  as it makes the editor slow
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()

" Indent Settings
let g:indent_blankline_filetype_exclude = ['help', 'nerdtree', 'git', 'vim-plug', 'man', 'lspinfo', 'packer', 'checkhealth', 'NvimTree']
let g:indent_blankline_use_treesitter_scope = v:true

" Number Toggle
let g:NumberToggleTrigger="<localleader>n"


" Multiple Cursors
let g:multi_cursor_next_key='<A-S-n>'
let g:multi_cursor_prev_key='<A-S-p>'
let g:multi_cursor_skip_key='<A-S-x>'
"let g:multi_cursor_quit_key='<Esc>'

" Airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#grepper#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'

" remove the buffer list from the command line
let g:bufferline_echo = 0

" Tagbar
nmap <F8> :TagbarToggle<CR>

" = neomake = {{{
" ===============
" You can then navigate them using the built-in methods like :lwindow / :lopen (to view the list) and :lprev / :lnext to go back and forth.
call neomake#configure#automake('nrwi', 200)
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
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

if has('dontdoathis') " TODO: do I need this?

" ----------------------------------------------------------
" setup the projects: https://github.com/amiorin/vim-project
" ----------------------------------------------------------

" Set my starting path
call project#rc("~/work/")

" My projects
Project '~/mine/dev/Community' , 'Community'
Project '~/.dotfiles'          , 'My DotFiles :)'
endif
