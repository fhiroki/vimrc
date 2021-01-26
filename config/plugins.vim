let g:mapleader = "\<Space>"

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""
" Unit.vim
""""""""""""""""""""""""""""""
" ファイルオープンを便利に
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html

" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<Cr>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-L> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-L> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<Cr>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<Cr>
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" CtrlP.vim
""""""""""""""""""""""""""""""
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_open_new_file = 1
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
" let g:ctrlp_map = '<Nop>'
" nnoremap s <Nop>
" nnoremap sa :<C-u>CtrlP<Cr>
" nnoremap sb :<C-u>CtrlPBuffer<Cr>
" nnoremap sd :<C-u>CtrlPDir<Cr>
" nnoremap sl :<C-u>CtrlPLine<Cr>
" nnoremap sm :<C-u>CtrlPMRUFiles<Cr>
" nnoremap sq :<C-u>CtrlPQuickfix<Cr>
" nnoremap ss :<C-u>CtrlPMixed<Cr>
" nnoremap st :<C-u>CtrlPTag<Cr>
""""""""""""""""""""""""""""""

"----------------------------------------------------------
" neocomplete・neosnippet
"----------------------------------------------------------
if has('lua')
    " コードの自動補完
    Plug 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    Plug 'Shougo/neosnippet'
    " スニペット集
    Plug 'Shougo/neosnippet-snippets'
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

" 非同期のLintツール
Plug 'w0rp/ale'
let g:ale_cpp_clang_executable = ''
let g:ale_cpp_gcc_executable = 'g++'
let g:ale_cpp_gcc_options = '-std=c++14 -Wall'

" Pythonの自動補完
Plug 'davidhalter/jedi-vim'
autocmd FileType python setlocal completeopt-=preview
let g:jedi#goto_stubs_command = ""

" Pythonの規約チェック
Plug 'nvie/vim-flake8'

" Cの自動補完
Plug 'justmao945/vim-clang'
let g:clang_gcc_exec = 'g++'
let g:clang_cpp_options = '-std=c++14'
let g:clang_include_sysheaders_from_gcc = 1
let g:clang_diagsopt = ''
let g:clang_format_style = 'Google'
noremap <C-F> :ClangFormat<Cr>

" Rustの自動補完(not work)
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'pbcopy'
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" ファイルをtree表示してくれる
Plug 'scrooloose/nerdtree'
noremap <C-T> :NERDTree<Cr>
let g:NERDTreeWinPos = 'left'

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
" Powerline系フォントを利用する
let g:airline_powerline_fonts = 1
" タブバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1
" タブバーの右領域を非表示にする
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'previm/previm'
let g:previm_open_cmd='open -a Google\ Chrome'
map <C-M> :PrevimOpen<Cr>

" インデントを視覚化
Plug 'Yggdroot/indentLine'
let g:indentLine_leadingSpaceChar = '.'
let g:indentLine_leadingSpaceEnabled = 1
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" easymotion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>e <Plug>(easymotion-overwin-f2)
vmap <Leader>e <Plug>(easymotion-bd-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Git関連
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
nnoremap [fugitive]  <Nop>
nmap <Leader>g [fugitive]
nnoremap <silent> [fugitive]s :Gstatus<CR>
nnoremap <silent> [fugitive]a :Gwrite<CR>
nnoremap <silent> [fugitive]c :Gcommit<CR>
nnoremap <silent> [fugitive]b :Gblame<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>

" カッコやクオート操作を便利に
Plug 'tpope/vim-surround'

" Iconを表示
Plug 'ryanoasis/vim-devicons'

" submode
Plug 'kana/vim-submode'

" tabpagebuffer
Plug 'Shougo/tabpagebuffer.vim'

call plug#end()
"""""""""""""""""""""""""""""

