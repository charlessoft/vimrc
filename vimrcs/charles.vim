set nu
set t_Co=256
set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <C-\>s :cs find s <C-R>=expand("<cword>" )<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>" )<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>" )<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>" )<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>" )<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>" )<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>" )<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>" )<CR><CR>

if has("cscope")
    set csprg=/usr/local/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"
"let Tlis_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的  
"let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim  
"let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口  
"set tags+=/home/charles/flvplay/tags
":cs add /home/charles/flvplay/cscope.out
"set tags+=/home/charles/UDS/charles_eginx/tags
":cs add /home/charles/UDS/charles_eginx/cscope.out
"

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
"let g:ycm_global_ycm_extra_conf = '~/.vim_runtime/sources_non_forked/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
"let g:ycm_collect_identifiers_from_tag_files = 1  
let g:ycm_collect_identifiers_from_tag_files = 1
"禁止每次加载提示
let g:ycm_confirm_extra_conf=0



"nmap <C-\>s :cs find s <C-R>=expand("<cword>" )<CR><CR>
nmap <F10>      :ConqueTermSplit 
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

"解决YcmCompleter 和UltiSnips 冲突
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
nmap <F6> :YcmDiags<CR>

"切换头文件
nnoremap <F4> :A<CR>
nmap <silent> <Leader>sw :A<cr>
nmap <silent> <Leader>swv :AV<cr>
nmap <silent> <Leader>sws :AS<cr>

nmap <F9>      :TagbarToggle<CR>
imap <F9> <C-O>:TagbarToggle<CR>
let g:ConqueTerm_TERM ='xterm'
nmap <Leader>sh :ConqueTerm bash<CR>
nmap <Leader>shs :ConqueTermSplit bash<CR>
nmap <Leader>shv :ConqueTermVSplit bash<CR>
nmap <Leader>sht :ConqueTermTab bash<CR>
"nmap <Leader>tb :TagbarToggle<CR>
"let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=30
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"set splitright
"set makeprg=gcc\ -Wall\ -o\ %<\ %	" 设置make命令
"copen 5					" 自动打开QuickFix列表并设置高为5行
"map <F5> <esc>:w<cr><esc>:make<cr>:cw<cr><c-w>j
