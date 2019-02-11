" usability
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
set clipboard=unnamed,autoselect
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
" insert時にVertical Bar
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" MoveToNewTab
nnoremap <silent> tm :<C-u>call <SID>MoveToNewTab()<CR>
function! s:MoveToNewTab()
    tab split
    tabprevious

    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif

    tabnext
endfunction
" 検索のハイライト終了
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <C-g> :nohlsearch<Cr><Esc>
" Space-wで保存、Space-qで保存終了"
nnoremap <Space>w :<C-u>wq<Cr>
nnoremap <Space>q :<C-u>q!<Cr>
nnoremap <Space>s :<C-u>w<Cr>
nnoremap <Space>f :FixWhitespace<Cr>
" 全コピー、全削除
nnoremap <Space>y ggVGy<C-o><C-o>
nnoremap <Space>d :bd<Cr>
" Space-Enterで空行挿入
nnoremap <silent> <Space><Cr> o<ESC>
" <C-w>でsplitウィンドウ間移動
nnoremap <C-w> <C-w><C-w>
" インサートモードの時に C-j でノーマルモードに戻る
imap <C-g> <esc>
" [ って打ったら [] って入力されてしかも括弧の中にいる(以下同様)
imap [ []<left>
imap ( ()<left>
imap { {}<left>
" 自動で空行削除
autocmd BufWritePre * :%s/\s\+$//ge



""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" ファイルオープンを便利に
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-B> :Unite buffer<Cr>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<Cr>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<Cr>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<Cr>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<Cr>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<Cr>
""""""""""""""""""""""""""""""

if has('lua')
    " コードの自動補完
    Plug 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    Plug 'Shougo/neosnippet'
    " スニペット集
    Plug 'Shougo/neosnippet-snippets'

"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " 独自のスニペットディレクトリ作成
    let g:neosnippet#snippets_directory = '~/.vim/plugged/neosnippet-snippets/neosnippets/snippets/'

    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
    imap <expr><Cr> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<Cr>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

" Pythonの自動補完プラグイン
Plug 'davidhalter/jedi-vim'
autocmd FileType python setlocal completeopt-=preview

" Pythonの規約チェック
Plug 'nvie/vim-flake8'

" ファイルをtree表示してくれる
Plug 'scrooloose/nerdtree'
noremap <C-T> :NERDTree<Cr>

" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'

" ログファイルを色づけしてくれる
Plug 'vim-scripts/AnsiEsc.vim'

" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'

" マルチカーソルをサポート
Plug 'terryma/vim-multiple-cursors'

" AtomのOnedarkを再現するためのカラースキーマ
Plug 'joshdick/onedark.vim'

" ステータスバーのカスタマイズ
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ファイル検索
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<Nop>'
let g:ctrlp_open_new_file = 1
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
nnoremap s <Nop>
nnoremap sa :<C-u>CtrlP<Cr>
nnoremap sb :<C-u>CtrlPBuffer<Cr>
nnoremap sd :<C-u>CtrlPDir<Cr>
nnoremap sl :<C-u>CtrlPLine<Cr>
nnoremap sm :<C-u>CtrlPMRUFiles<Cr>
nnoremap sq :<C-u>CtrlPQuickfix<Cr>
nnoremap ss :<C-u>CtrlPMixed<Cr>
nnoremap st :<C-u>CtrlPTag<Cr>

" Powerline系フォントを利用する
let g:airline_powerline_fonts = 1

" タブバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1

" タブバーの右領域を非表示にする
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

" インデントを視覚化
" Plug 'Yggdroot/indentLine'

call plug#end()
"""""""""""""""""""""""""""""

set background=dark
colorscheme onedark
