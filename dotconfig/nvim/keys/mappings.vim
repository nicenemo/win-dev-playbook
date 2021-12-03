scriptencoding utf-8

" Easy CAPS
inoremap <M-u> <ESC>viwUi
nnoremap <M-u> viwU<Esc>


" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

noremap <silent><Tab> :bn<CR>
noremap <silent><S-Tab> :bp<CR>
noremap <silent><Leader><Tab> :bd<CR>
noremap <silent><Leader><S-Tab> :bd!<CR>

nnoremap <silent><M-t> :tabnew<CR>
noremap <silent><C-t> :tabnew split<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Insert below indented
nnoremap <Leader>o o<Esc>^Da
" Insert above  indented
nnoremap <Leader>O O<Esc>^Da

" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>

" Yank to end of line.
noremap Y y$

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

" <LocalLeader>s -- Fix (most) syntax highlightingroblems in current buffer
" (mnemonic: syntax).
nnoremap <silent> <LocalLeader>s :syntax sync fromstart<CR>

" <LocalLeader>e -- Edit file, starting in same directory as current file.
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

if has('nvim')
  " Use alt + hjkl to resize windows.
  nnoremap <M-j>    :resize -2<CR>
  nnoremap <M-k>    :resize +2<CR>
  nnoremap <M-h>    :vertical resize -2<CR>
  nnoremap <M-l>    :vertical resize +2<CR>
  " Move between windows in Normal mode.
  nnoremap <C-h> <c-w>h
  nnoremap <C-j> <c-w>j
  nnoremap <C-k> <c-w>k
  nnoremap <C-l> <c-w>l
  " Move between windows in visual mode.
  xnoremap <C-h> <C-w>h
  xnoremap <C-j> <C-w>j
  xnoremap <C-k> <C-w>k
  xnoremap <C-l> <C-w>l
  " Open horizontal and vertical split with leader h and leader v.
  noremap <Leader>h :<C-u>split<CR>
  noremap <Leader>v :<C-u>vsplit<CR>
  " Terminal window navigation
"  tnoremap <C-h> <C-\><C-N><C-w>h
"  tnoremap <C-j> <C-\><C-N><C-w>j
"  tnoremap <C-k> <C-\><C-N><C-w>k
"  tnoremap <C-l> <C-\><C-N><C-w>l
"  inoremap <C-h> <C-\><C-N><C-w>h
"  inoremap <C-j> <C-\><C-N><C-w>j
"  inoremap <C-k> <C-\><C-N><C-w>k
"  inoremap <C-l> <C-\><C-N><C-w>l
"  tnoremap <Esc> <C-\><C-n>
  " Make all views about the same size
  nnoremap <Leader>= <C-w>=
endif

" Toggle paste mode from normal mode.
nnoremap <silent><LocalLeader>p :set paste!<CR>
" Toggle cursor column
nnoremap <silent><LocalLeader>c :set cursorcolumn!<CR>
" Clean highlights with <LEADER>/
nnoremap <silent><leader>/ :noh<cr>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Abbreviations for common casing mistakes.
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vim alternatively you can run :source $MYVIMRC

" You can't stop me. Write a file owned by root by using w!!
cmap w!! w !sudo tee %
