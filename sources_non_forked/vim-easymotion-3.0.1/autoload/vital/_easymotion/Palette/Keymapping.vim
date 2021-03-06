scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:modep = "[nvoicsxl]"


function! s:_vital_loaded(V)
	let s:V = a:V
	let s:Capture  = s:V.import("Palette.Capture")
endfunction


function! s:_vital_depends()
	return [
\		"Palette.Capture",
\	]
endfunction


function! s:_capture(mode)
	let cmd = "map"
	if a:mode ==# "!"
		let cmd = cmd . "!"
	elseif a:mode =~# "[nvoicsxl]"
		let cmd = a:mode . cmd
	endif
	return s:Capture.command(cmd)
endfunction


function! s:capture(...)
	let mode = get(a:, 1, "")
	let modes = split(mode, '\zs')
	return join(map(modes, "s:_capture(v:val)"), "\n")
endfunction


function! s:_keymapping(str)
	return a:str =~ '^[!nvoicsxl]\s'
endfunction


function! s:capture_list(...)
	let mode = get(a:, 1, "")
	return filter(split(s:capture(mode), "\n"), "s:_keymapping(v:val)")
endfunction


function! s:escape_special_key(key)
	" Workaround : <C-?> https://github.com/osyo-manga/vital-palette/issues/5
	if a:key ==# "<^?>"
		return "\<C-?>"
	endif
	execute 'let result = "' . substitute(escape(a:key, '\"'), '\(<.\{-}>\)', '\\\1', 'g') . '"'
	return result
endfunction


function! s:parse_lhs(text, ...)
	let mode = get(a:, 1, '[!nvoicsxl]')
	" NOTE: :map! Surpport : https://github.com/osyo-manga/vital-palette/issues/4
	if get(a:, 1, "") =~# '[!ci]'
		let mode = '[!ci]'
	endif
	return matchstr(a:text, mode . '\{1,3\}\s*\zs\S\{-}\ze\s\+')
endfunction


function! s:parse_lhs_list(...)
	let mode = get(a:, 1, "")
	return map(s:capture_list(mode), "s:parse_lhs(v:val, mode)")
endfunction


function! s:lhs_key_list(...)
	let mode = get(a:, 1, "")
	return map(s:parse_lhs_list(mode), "s:escape_special_key(v:val)")
endfunction


function! s:_maparg(name, mode, abbr, dict)
	" Workaround : <C-?> https://github.com/osyo-manga/vital-palette/issues/5
	if a:name ==# "<^?>"
		return maparg("\<C-?>", a:mode, a:abbr, a:dict)
	endif
	return maparg(a:name, a:mode, a:abbr, a:dict)
endfunction


function! s:rhs_key_list(...)
	let mode = get(a:, 1, "")
	let abbr = get(a:, 2, 0)
	let dict = get(a:, 3, 0)
	
	let result = []
	for m in split(mode, '\zs')
		let result += map(s:parse_lhs_list(m), "s:_maparg(v:val, m, abbr, dict)")
	endfor
	return filter(result, "empty(v:val) == 0")
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
