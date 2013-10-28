set nu
set t_Co=256
set cscopequickfix=s-,c-,d-,i-,t-,e-

"nmap <C-\>s :cs find s <C-R>=expand("<cword>" )<CR><CR>
"nmap <C-\>g :cs find g <C-R>=expand("<cword>" )<CR><CR>
"nmap <C-\>c :cs find c <C-R>=expand("<cword>" )<CR><CR>
"nmap <C-\>t :cs find t <C-R>=expand("<cword>" )<CR><CR>
"nmap <C-\>e :cs find e <C-R>=expand("<cword>" )<CR><CR>
"nmap <C-\>f :cs find f <C-R>=expand("<cfile>" )<CR><CR>
"nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>" )<CR>$<CR>
"nmap <C-\>d :cs find d <C-R>=expand("<cword>" )<CR><CR>
"
"let Tlis_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的  
"let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim  
"let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口  
"set tags+=/home/charles/flvplay/tags
":cs add /home/charles/flvplay/cscope.out
"set tags+=/home/charles/UDS/charles_eginx/tags
":cs add /home/charles/UDS/charles_eginx/cscope.out
"
nmap <F9>      :Tlist<CR>
imap <F9> <C-O>:Tlist<CR>

"quick 
nmap <F11> :cn<CR>
nmap <F12> :cp<CR>

"function! RemoveTrailingSpace()
"    if $VIM_HATE_SPACE_ERRORS != '0' &&
"                \(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'vim')
"        normal m`
"        silent! :%s/\s\+$//e
"        normal ``
"    endif
"endfunction

"" Highlight space errors in C/C++ source files (Vim tip #935)
if $VIM_HATE_SPACE_ERRORS != '0'
    let c_space_errors=1
endif

" File type related autosetting
au FileType c,cpp setlocal cinoptions=:0,g0,(0,w1 shiftwidth=4 tabstop=4
au FileType diff  setlocal shiftwidth=4 tabstop=4
au FileType html  setlocal autoindent indentexpr=
au FileType changelog setlocal textwidth=76


"--ctags setting--
" 按下F5重新生成tag文件，并更新taglist
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags
set tags+=./tags "add current directory's generated tags file
set tags+=~/arm/linux-2.6.24.7/tags "add new tags file(刚刚生成tags的路径，在ctags -R 生成tags文件后，不要将tags移动到别的目录，否则ctrl+］时，会提示找不到源码文件)


let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

