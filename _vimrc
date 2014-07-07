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

