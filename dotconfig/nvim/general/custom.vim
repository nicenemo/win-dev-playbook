scriptencoding utf-8

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function Zap() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

" <Leader>zz -- Zap trailing whitespace in the current buffer.
"
"        As this one is somewhat destructive and relatively close to the
"        oft-used <leader>a mapping, make this one a double key-stroke.
nnoremap <silent> <Leader>zz :call Zap()<CR>

" Function to toggle the status bar on and off with F4.
let s:hidden_all = 0
function! ToggleHiddenAll()
  if s:hidden_all  == 0
    let s:hidden_all = 1
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
    set nonumber
    set norelativenumber
  else
    let s:hidden_all = 0
    set showmode
    set ruler
    set laststatus=2
    set showcmd
    set relativenumber
    set number
  endif
endfunction

" Cycle through relativenumber + number, number (only), and no numbering.
function! CycleNumbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!
  endif
endfunction
nnoremap <silent> <LocalLeader>n :call CycleNumbering() <CR>

augroup highlightYankedText
    autocmd!
    autocmd TextYankPost * call FlashYankedText(deepcopy(v:event))
augroup END

function! s:DeleteTemporaryMatch(timerId)
    while !empty(s:yankedTextMatches)
        let match = remove(s:yankedTextMatches, 0)
        let windowID = match[0]
        let matchID = match[1]

        try
            call matchdelete(matchID)
        endtry
    endwhile
endfunction

function! FlashYankedText(event)
    " Don't highlight if the last command was not a yank
    if (a:event.operator != 'y')
        return
    endif

    if (!exists('s:yankedTextMatches'))
        let s:yankedTextMatches = []
    endif

    let window = winnr()

    " Handle case of visual block using one match by line
    if (len(a:event.regtype) > 0 && a:event.regtype[0] == "\<C-V>")
        let lineStart = line("'<")
        let lineStop = line("'>")
        let columnStart = col("'<")
        let columnStop = col("'>")

        " For each line in the block selection create aattern using the first
        " and last column
        "         " Theattern looks like this:
        "   \%Xl\%Yc.*\%Zc
        " Where X is the line, Y the first column and Z the last column
        for line in range(lineStart, lineStop)
            let matchId = matchadd(get(g:, 'FYT_highlight_group', 'IncSearch'), "\\%" . line . "l\\%" . columnStart . "c.*\\%" . columnStop . "c")
            call add(s:yankedTextMatches, [window, matchId])
        endfor
    else " Other visual types
        let matchId = matchadd(get(g:, 'FYT_highlight_group', 'IncSearch'), ".\\%>'\\[\\_.*\\%<']..")
        call add(s:yankedTextMatches, [window,matchId])
    endif

    call timer_start(get(g:, 'FYT_flash_time', 500), function('<SID>DeleteTemporaryMatch'))
endfunction


let s:hidden_command=0
function! ToggleCommand()
  if s:hidden_command == 0
    let s:hidden_command = 1
    set showcmd
  else
    let s:hidden_command = 0
    set noshowcmd
  endif
endfunction


nnoremap <silent><localleader>a :call ToggleHiddenAll()<CR>
nnoremap <silent><localleader>k :call ToggleCommand()<CR>
