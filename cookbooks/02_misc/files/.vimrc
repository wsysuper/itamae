syntax on           "コードの色分け
set number          "行番号表示
set title           "編集中ファイル名表示
set showmatch       "括弧入力時の対応する括弧を表示
set ttyfast         "高速ターミナル接続

set incsearch       "インクリメンタルサーチを有効にする
set ignorecase      "大文字/小文字の区別なく検索する
set smartcase       "検索文字列に大文字がある場合は区別して検索
set wrapscan        "検索時に最後まで行ったら最初に戻る

set tabstop=4       "インデントをスペース4つ分に設定
set shiftwidth=2
set autoindent      "自動インデント
set smartindent
set smarttab        "行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set expandtab

set autoread        "内容が変更されたら自動的に再読み込み
set updatetime=0    "Swapを作るまでの時間m秒
set wildchar=<C-Z>  "コマンドラインでTABで補完できるようにする

"行間をでシームレスに移動する
set whichwrap+=h,l,<,>,[,],b,s

"ペースト時の自動インデント無効化
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

"encoding
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

