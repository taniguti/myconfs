set nocompatible

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
set shiftwidth=4
set tabstop=4

"タブの代わりに空白文字を指定する
set expandtab

"新しい行を作った時に高度な自動インデントを行う
"set smarttab

" 改行時に前の行のインデントを継続する
" set autoindent

" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する 
" set smartindent

" カーソル行の背景色を変える
set cursorline

"インクリメンタルサーチを行う
set incsearch

"検索時に最後まで行ったら最初に戻る
set wrapscan

" 行番号を表示
set number

set encoding=utf8
set fileencodings=utf8,iso-2022-jp,sjis,euc-jp
set fileformats=unix,dos
autocmd FileType * setlocal formatoptions-=ro

" 自動的に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge
