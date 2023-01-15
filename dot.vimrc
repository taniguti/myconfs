set nocompatible
filetype on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://qiita.com/fl04t/items/57ebb0fe8009d00c8499
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"編集中のファイル名を表示
set title

"閉括弧が入力された時、対応する括弧を強調する
set showmatch

"コードの色分け
syntax on

"インデントをスペース4つ分に設定
" https://yu8mada.com/2018/08/26/i-ll-explain-vim-s-5-tab-and-space-related-somewhat-complicated-options-as-simply-as-possible/
set shiftwidth=4
set tabstop=4
autocmd FileType yaml   setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby   setlocal shiftwidth=2 tabstop=2
autocmd FileType json   setlocal shiftwidth=2 tabstop=2

"タブの代わりに空白文字を指定する
set expandtab
"以下はtabを使う。
autocmd FileType make setlocal noexpandtab
autocmd FileType go   setlocal noexpandtab

" status line
" ファイル名表示
set statusline=%F
" FileType
set statusline+=[%Y]
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[%{&fileencoding}]
" 現在行数/全行数
set statusline+=[%l/%c]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

"新しい行を作った時に高度な自動インデントを行う
"set smarttab

" 改行時に前の行のインデントを継続する
" set autoindent

" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
" set smartindent

" Colorscheme (colo)
" :colorscheme: 現在設定表示
" :colorscheme tab name: colorschemeを設定
" :colorscheme <ctrl-d>: 候補一覧表示
colorscheme murphy

"インクリメンタルサーチを行う
set incsearch

"検索時に最後まで行ったら最初に戻る
set wrapscan

" 行番号を表示
set number

set encoding=utf8
set fileencodings=utf8,iso-2022-jp,sjis,euc-jp
set fileformats=unix,dos

" https://nanasi.jp/articles/howto/file/modeline.html
set modeline
set modelines=5

autocmd FileType * setlocal formatoptions-=ro

" 自動的に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

" https://thinca.hatenablog.com/entry/20090530/1243615055
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END
