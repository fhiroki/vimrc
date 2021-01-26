set t_Co=256
" 色づけを on にする
syntax on
" ターミナルの右端で文字を折り返さない
set nowrap
" tempファイルを作らない。
set noswapfile
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" 大文字小文字を区別しない(検索時)、大文字を含んでいた場合は例外。
set ignorecase
set smartcase
" ハイライトサーチ、インクリメンタルサーチを有効にする。
set hlsearch
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" カーソル位置が右下に表示される
set ruler
" 行番号を付ける
set number
" タブ文字の表示 ^I で表示される
" set list
" コマンドライン補完が強力になる
set wildmenu
" コマンドを画面の最下部に表示する
set showcmd
" クリップボードを共有する
set clipboard=unnamed
" 改行時にインデントを引き継いで改行する
set autoindent
" スマートインデントを使用
set smartindent
" インデントにつかわれる空白の数
set shiftwidth=4
" <Tab>押下時の空白数
set softtabstop=4
" <Tab>押下時に<Tab>ではなく、ホワイトスペースを挿入する
set expandtab
" <Tab>が対応する空白の数
set tabstop=4
" BackSpaceで削除できるものを指定
set backspace=indent,eol,start
" インクリメント、デクリメントを16進数にする(0x0とかにしなければ10進数です。007をインクリメントすると010になるのはデフォルト設定が8進数のため)
set nf=hex
" マウスを使用可能に
set mouse=a
" Kでhelp
set keywordprg=:help
" EncodigをUTF8に
set encoding=UTF-8
" terminalの設定
set splitbelow
set termwinsize=10x0
" insert時にVertical Bar
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

if has("autocmd")
    " 最後のカーソル位置を復元する
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

    " 拡張子によってインデントを変える。
    augroup fileTypeIndent
        autocmd!
        autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    augroup END
endif

" themeの設定
set background=dark
colorscheme onedark
hi DiffAdd cterm=bold ctermfg=8
hi DiffDelete cterm=bold ctermbg=9
hi DiffText cterm=bold ctermfg=8

