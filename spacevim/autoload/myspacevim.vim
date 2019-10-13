function! myspacevim#before() abort
  set wrap
endfunction

function! myspacevim#after() abort
	let mapleader=','
	let g:mapleader=','
	let maplocalleader=';'
	set t_Co=256
	set mouse = a
	set ruler
	set wildmenu
	set cursorline
	set clipboard=unmaned
	set laststatus=2
	set background=dark
  let &colorcolumn=join(range(81,999),",")
endfunction
