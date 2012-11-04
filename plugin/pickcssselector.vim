function! pickCssSelector#pasteNextWindow()
	" 元のレジスタを保存
	let tmp = @@

	" 最後に選択したものをヤンク
	silent normal gvy

	" ヤンクした文字列を置換
	let str = @@
	let str = substitute(str, '^\(.\)', '{^}\1', '')
	let str = substitute(str, '\n', '{CR}\n{^}', 'g')
	let str = substitute(str, '{^}.\{-} class="', '{^}\.', 'g')
	let str = substitute(str, '".\{-}{CR}', ' {}{CR}', 'g')
	let str = substitute(str, '{^}<!--.\{-}-->', '{^}', 'g')
	let str = substitute(str, '{^}<\/.\{-}>{CR}', '', 'g')

	let str = substitute(str, '{^}', '', 'g')
	let str = substitute(str, '{CR}', '', 'g')
	let str = substitute(str, '\n\n', '', 'g')
	let str = substitute(str, '{}', '{\n}', 'g')

	" 置換した文字列をレジスタに格納
	let @@ = str

	" 格納したレジスタから隣のウィンドウにペースト
	execute 'wincmd w'
	execute 'normal ""p'

	" レジスタを元に戻す
	let @@ = tmp
endfunction

command! PickCssSelector call pickCssSelector#pasteNextWindow()

vnoremap <silent> <leader>css <ESC>:PickCssSelector<CR>
