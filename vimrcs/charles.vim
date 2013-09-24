set nu
set t_Co=256
nmap <F9>      :Tlist<CR>
imap <F9> <C-O>:Tlist<CR>

" quick 
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
" ����F5��������tag�ļ���������taglist
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags
set tags+=./tags "add current directory's generated tags file
set tags+=~/arm/linux-2.6.24.7/tags "add new tags file(�ո�����tags��·������ctags -R ����tags�ļ��󣬲�Ҫ��tags�ƶ������Ŀ¼������ctrl+��ʱ������ʾ�Ҳ���Դ���ļ�)