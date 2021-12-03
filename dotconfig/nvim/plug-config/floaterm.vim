scriptencoding utf-8
" let g:floaterm_wintype='normal'
" let g:floaterm_height=6

let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1



nnoremap <silent><localleader>; :FloatermNew --wintype=popup --height=6<CR>
nnoremap <silent><localleader>f :FloatermNew fzf<CR>
nnoremap <silent><localleader>g :FloatermNew lazygit<CR>
nnoremap <silent><localleader>d :FloatermNew lazydocker<CR>
nnoremap <silent><localleader>n :FloatermNew node<CR>
nnoremap <silent><localleader>N :FloatermNew nnn<CR>
nnoremap <silent><localleader>p :FloatermNew python<CR>
nnoremap <silent><localleader>r :FloatermNew ranger<CR>
nnoremap <silent><localleader>t :FloatermToggle<CR>
nnoremap <silent><localleader>y :FloatermNew htop<CR>
nnoremap <silent><localleader>s :FloatermNew ncdu<CR>
