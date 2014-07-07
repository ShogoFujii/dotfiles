setlocal tabstop=4
setlocal shiftwidth=4
syntax on

" --setting for NeoBundle
set nocompatible               " be iMproved
filetype off
set backspace=start,eol,indent

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" add plugins
filetype plugin on
NeoBundleCheck

" plugin list
NeoBundle "tyru/caw.vim"
NeoBundle "t9md/vim-quickhl"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/unite-outline"
NeoBundle "Shougo/neocomplete.vim"
NeoBundle "Shougo/neosnippet.vim"
NeoBundle "osyo-manga/vim-marching"
NeoBundle "thinca/vim-quickrun"
"NeoBundle "rhysd/wandbox-vim"
NeoBundle "jceb/vim-hier"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "osyo-manga/shabadou.vim"

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

"config
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)

nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
nnoremap <Space>ns :execute "tabnew\|:NeoSnippetEdit ".&filetype<CR>

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#skip_auto_completion_time = ""

let g:marching_backend = "sync_clang_command"
let g:marching_clang_command_option="-std=c++1y"
let g:marching_enable_neocomplete = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neosnippet#snippets_directory = "~/.neosnippet"

let g:quickrun_config = {
\   "_" : {
\       "outputter" : "error",
\       "outputter/error/success" : "buffer",
\       "outputter/error/error"   : "quickfix",
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/quickfix/open_cmd" : "copen",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 500,
\   },
\   "cpp" : {
\       "cmdopt" : "-std=c++0x",
\       "hook/time/enable" : 1
\   },
\   "cpp/watchdogs_checker" : {
\       "type" : "watchdogs_checker/clang++",
\   },
\
\   "watchdogs_checker/g++" : {
\       "cmdopt" : "-Wall",
\   },
\}

let s:hook = {
\   "name" : "clear_quickfix",
\   "kind" : "hook",
\}

"function
function! s:cpp()
    setlocal path+=/usr/lib/gcc/x86_64-linux-gnu/4.8
	setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal noexpandtab

    setlocal matchpairs+=<:>
    nnoremap <buffer><silent> <Space>ii :execute "?".&include<CR> :noh<CR> o
    syntax match boost_pp /BOOST_PP_[A-z0-9_]*/
    highlight link boost_pp cppStatement
endfunction

augroup vimrc-cpp
    autocmd!
    autocmd FileType cpp call s:cpp()
augroup END

function! s:hook.on_normalized(session, context)
    call setqflist([])
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
