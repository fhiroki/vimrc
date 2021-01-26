" <Leader>の設定
let g:mapleader = "\<Space>"

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
nmap <Esc><Esc> :nohlsearch<Cr><Esc>
nmap <C-g> :nohlsearch<Cr><Esc>
nnoremap <C-h> :<C-u>bprevious<Cr>
nnoremap <C-l> :<C-u>bnext<Cr>
nnoremap <Leader>q :<C-u>q!<Cr>
nnoremap <Leader>s :<C-u>w<Cr>
nnoremap <Leader>t :FixWhitespace<Cr>
" 全コピー、全削除
nnoremap <Leader>y ggVGy<C-o><C-o>
" Atcoderのtest
nnoremap <Leader>a :!acc-test<Cr>
" https://qiita.com/shingargle/items/dd1b5510a0685837504a
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
" inoremap [ []<Left>
" inoremap [<Enter> []<Left><CR><ESC><S-o>
" inoremap ( ()<ESC>i
" inoremap (<Enter> ()<Left><CR><ESC><S-o>
" 自動で空行削除
autocmd BufWritePre * :%s/\s\+$//ge
" コロンとセミコロンを入れ替え
noremap ; :
" pasteした際にyankされないようにする
vnoremap p "_dP

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
call submode#enter_with('vscroll', 'n', '', 'zl', 'zl')
call submode#enter_with('vscroll', 'n', '', 'zh', 'zh')
call submode#map('vscroll', 'n', '', 'l', 'zl')
call submode#map('vscroll', 'n', '', 'h', 'zh')

