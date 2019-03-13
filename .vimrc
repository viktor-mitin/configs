autocmd!
autocmd FileType c,cpp,php,python,bash set expandtab

let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
set noexpandtab
endif


autocmd FileType vim noremap <buffer> <C-k> 0i"<esc>j

noremap <C-k> 0^i//<esc>j
noremap <C-l> 0i#<esc>j


"auto reload vimrc
autocmd! bufwritepost .vimrc source %
    

"autocmd BufNewFile,BufRead *.py set textwidth=155

set showcmd

"enable spellcheck
"set spell spelllang=en_us
"set spellcapcheck=
"set nospell
"enable spell check for *.md files and git commits only
"use zg to add new word to the dictionary
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell


"remove all trail whitespaces from the end of line
"autocmd BufWritePre *.c :%s/\s\+$//e " ???
"autocmd FileType c,cpp,php,python,bash autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Auto read if file is changed outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search tag file
let spath=getcwd()

let &tags=''
while spath != $HOME && spath != ""
        if filereadable(spath."/tags")
        let spath=spath."/tags"
                let &tags=&tags.",".spath
                break
        endif
        let spath=substitute(spath,"/[^/]*$","","")
endwhile
unlet spath

let &tags=$HOME."/code/tags"

map <C-]>  <Esc>:w <CR>:execute "tj ".expand("<cword>")<CR>

map ;a <Esc>:w <CR>:execute "!time BUILD_ONLY=some_code ~/work/bld_some_code_sim_and_run.sh <cword>" SuitNamePreview() <CR>
map ;A <Esc>:w <CR>:execute "!rm -rf ~/tmp/objs/some_code/some_code; ~/work/bld_some_code_sim_and_run.sh <cword>" SuitNamePreview() <CR>

map ;r <Esc>:w <CR>:execute "!rm -rf ~/tmp/objs/some_code/* && time ~/work/bld_some_code_sim_and_run.sh <cword>" SuitNamePreview() <CR>
map ;R <Esc>:w <CR>:execute "!time ~/work/bld_some_code_sim_and_run.sh <cword>" SuitNamePreview() <CR>

map ;t <Esc>:w <CR>:execute "!time ~/work/bld_some_code_sim_and_run.sh <cword>" SuitNamePreview() <CR>

map ;q <Esc>:w <CR>:execute "!time ~/work/run_some_code.sh <cword>" SuitNamePreview()<CR> 


"debug wrappers
"map ;d <Esc>:w <CR>:execute "!time ~/work/start_gdb_br.sh <cword>" FuncToWrap()<CR> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
",v brings up my .vimrc
"",V reloads it -- making all changes active (have to save first)

map ,v :sp ~/.vimrc<CR><C-W>_
map ,V :silent source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"unmap Ctrl-r to allow work 'Redo' command on some OS
if mapcheck('<C-r>', 'n') != ''
    unmap <C-r>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-s> <Esc>:w<CR>
nmap <C-s> <Esc>:w<CR>
vmap <C-s> <Esc>:w<CR>

"vimgrep through code
command! -nargs=+ Grep execute 'silent grep! -I -r -n . -e "\<<args>\>"' | copen | execute 'silent /\<<args>\>'

nmap ,a <Esc>:Grep <c-r>=expand("<cword>")<cr><cr>

nmap ,, <Esc>:let temp=expand("<cword>")<CR>:tabe .<CR>:execute "vimgrep /".temp."/ ./**/*"<CR>
"nmap ,a <Esc>/<C-R><C-W><CR>:let temp=expand("<cword>")<CR>:tabe .<CR>:execute "grep -r /".temp."/ ."<CR><CR>

nmap ,s <Esc>:let temp=expand("<cword>")<CR>:tabe .<CR>:execute "vimgrep /".temp."/ ~/some_code/**/*.c"<CR>
nmap ,h <Esc>:let temp=expand("<cword>")<CR>:tabe .<CR>:execute "vimgrep /".temp."/ ~/some_code/**/*.h"<CR>

nmap ,e <Esc>:e .<CR>

nmap ;h <Esc>I/*<Esc>A*/<Esc>j

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F1> <Esc>:previous<CR>
nmap <F2> <Esc>:next<CR>gg
nmap <F3> [[
nmap <F4> ]]

"nmap <F5> <Esc>I#if 0<Esc>
"nmap <F6> <Esc>I#endif<Esc>

nmap <F5> ]s
nmap <F6> zg]s

nmap <F7> <Esc>:cp<CR>
nmap <F8> <Esc>:cn<CR>

nmap <F11> <Esc>:e!<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <CR> :!read<CR> 
nmap ' `
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start whichwrap+=<,>,[,] " allow to use backspace instead of "x"

syntax on
set tabstop=4
set shiftwidth=4
set textwidth=250
set softtabstop=4
set smarttab
set background=dark
set ignorecase
set smartcase
set hlsearch
set incsearch
set listchars+=precedes:<,extends:>
set sidescroll=5
set sidescrolloff=5
set showmatch
set history=700
set ttyfast
set ruler
set scrolloff=15

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
"All swap files will be stored in ~/.vim/swp
"set dir=~/.vim/swp

"set wrap by words (not by chars)
set wrap 
"set linebreak
au FileType * setl fo-=cro

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ShortTabLine()
  let ret = ''
  for i in range(tabpagenr('$'))
    " select the color group for highlighting active tab
      if i + 1 == tabpagenr()
     
      let ret .= '%#errorMsg#'
    else
     let ret .= '%#TabLine#'
                
    endif
    " find the buffername for the tablabel
    let buflist = tabpagebuflist(i+1)
    let winnr = tabpagewinnr(i+1)
    let buffername = bufname(buflist[winnr - 1])
    let filename = fnamemodify(buffername,':p:~')
    " check if there is no name
    if filename == ''
      let filename = 'noname'
    endif

    " only show the first X letters of the name and
    " .. if the filename is more than 8 letters long
    if strlen(filename) <=15
         let ret .= '     ['.filename.']     '
    elseif strlen(filename) >=45
         let filename = fnamemodify(buffername,':t')
         let ret .= '...['.filename.']'
    else
          let ret .= '['.filename.']'
    endif

endfor
" after the last tab fill with TabLineFill and reset tab page #
  let ret .= '%#TabLineFill#%T'
  return ret
endfunction
set tabline=%!ShortTabLine()

map ,t :tabedit .<CR>
                          
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function declaration preview (double-backslash with default <Leader>)
function! FuncPreview()
  let opening = search("^\\S.*)\\s*\\\(\\n\\\)\\={","bn")
  let closing = search("^}","bn")
  if opening > closing
    echo getline(opening)
  else
    echo ""
  endif
endfunction
nmap ,f :cal FuncPreview()<CR>


"""""""""  diff options  """""""""""""""""""""""""""""""""""""""""""""""""""""
"keys for vimdiff
map  <m-Right> dp
map  <m-Left> do
map  <m-Up> [c
map  <m-Down> ]c

"ignore whitespace in vimdiff
"set diffopt+=iwhite

"get all changes from other buffer
"nmap \ea :1,$+1diffget<CR>:w<CR>:qa!<CR>
"

if &diff
    colorscheme pablo
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


nmap x <Esc>:mksession! ~/w/vim_temp.vim<CR>:qa<CR>
"nmap \ex <Esc>:qa!<CR>  


set path+=** "add file names autocompletion in current directory
set wildmenu "enable printing menu for autocompletion items


""""""   netrw settings     """""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 1 "disable netrw banner
let g:netrw_liststyle=3 "enable netrw browser detailed view by default
let g:netrw_preview=1 "open preview window with vertical split on top right (use p key)
let g:netrw_altv=1 "open vertical window with vertical split on top right (use v key)
let g:netrw_winsize=35 "set netrw winsize to take 40% of the window width

