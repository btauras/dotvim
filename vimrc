" vim: set et ai ts=2 sw=2 fdm=marker:

" pathogen does not support full vim backwards-compatibility
set nocompatible

" use pathogen as a bundle {{{
" https://riptutorial.com/vim/example/13780/pathogen
" http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
" }}}

"set t_Co=256
set background=dark
syntax enable
filetype plugin indent on
"let g:solarized_termcolors=256
"colorscheme desert
"colorscheme molokai
"colorscheme zenburn
colorscheme solarized
highlight ColorColumn ctermbg=10

set hlsearch
nmap <Space> :nohlsearch<Bar>:echo<CR>
set ignorecase
set smartcase

" can make underscore a word boundary for w/b commands
" set iskeyword-=_

" macro shortcut for adding timestamp in a file
let @t=':r! date'

" use built-in netrw instead of nerdtree {{{
" https://shapeshed.com/vim-netrw/
" https://github.com/tpope/vim-vinegar
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" use gh to toggle dotfiles
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}}
" automatically load netrw file browser {{{
" " or manually run :Vexplore, :Hexplore, :Sexplore, or :Explore
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" }}}

" content taken from https://github.com/graudeejs/dot.vim/blob/master/vimrc
" Trim() {{{
function! Trim()
  let cur_linenr = line('.')
  let cur_col = col('.')
  let _s=@/
  %s/\s\+$//e
  let @/=_s
  nohl
  call cursor(cur_linenr, cur_col)
endfunction
"}}}
" TrimRange() {{{
function! TrimRange() range
  exec a:firstline.",".a:lastline."substitute /\\v\\s+$//e"
endfunction
"}}}
" PromptRemoveTrainingWhitespace() {{{
function! PromptRemoveTrainingWhitespace()
  let has_trailing_spaces=!!search('\v\s+$', 'cwn')
  if has_trailing_spaces
    if ! exists("b:remove_trailing_whitespace")
      let has_trailing_spaces=!!search('\v\s+$', 'cwn')
      if has_trailing_spaces
        let choice = confirm("Remove trailing whitespace?", "&Yes\n&No")
        if choice == 1
          call Trim()
          let b:remove_trailing_whitespace = 1
        else
          let b:remove_trailing_whitespace = 0
        endif
      endif
    elseif b:remove_trailing_whitespace == 1
      call Trim()
    endif
  endif
endfunction
"}}}
autocmd BufWritePre * call PromptRemoveTrainingWhitespace()
" DiffOrig() {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif
"}}}

" Swap windows in vim {{{
" Credit to http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
" To use (assuming your mapleader is set to \) you would:
"     1. Move to the window to mark for the swap via ctrl-w movement
"     2. Type \mw
"     3. Move to the window you want to swap
"     4. Type \pw
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction
function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction
" }}}
nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" load words from system dictionaries {{{
if isdirectory('/usr/share/dict')
  for dictionary in ['words', 'web2a', 'propernames']
    if filereadable('/usr/share/dict/' . dictionary)
      execute "set dictionary+=/usr/share/dict/" . dictionary
    endif
  endfor
endif
" }}}

" better colors for vimdiff {{{
"if &diff
"  " windows git-bash 256 colors
"  "set t_Co=256
"  "set background=dark
"  colorscheme solarized8
"  "hi Comment ctermfg=cyan
"endif
" }}}

" disable syntax highlighting for files over 256KB {{{
" jump to previously edited file on buffer read
au BufReadPost *        if getfsize(bufname("%")) > 256*1024 |
\                         set syntax= |
\                       endif |
\                       if line("'\"") > 0 && line("'\"") <= line("$") |
\                         exe "normal! g`\"" |
\                       endif
" }}}

" disable terminal bells {{{
set vb t_vb=
augroup VIMrc
  au!
  " Use visual flashing instead of beeping & disable visualbells
  au GUIEnter * set vb t_vb=
augroup END
set novisualbell
" }}}
