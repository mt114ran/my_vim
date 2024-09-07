" ===============================================
" If you write comments in Japanese, you need to set this at the beginning.
" ================================================
set encoding=utf-8
scriptencoding utf-8

" ================================================
" 文字コードの設定
" ================================================
" 保存時の文字コード
set fileencoding=utf-8
" 読み込み時の文字コードの自動判別、左側が優先
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 改行コードの自動判別、左側が優先される
set fileformats=unix,dos,mac
"  □や○文字が崩れる問題を解決
set ambiwidth=double

" ================================================
" タブ・インテンドの設定
" ================================================
" タブ入力を複数の空白入力に置き換える
set expandtab
" 画面上でタブ文字が占める幅
set tabstop=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅
set shiftwidth=4

" ================================================
" 文字列検索
" ================================================
" インクリメンタルサーチ、１文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト
set hlsearch

" ================================================
" カーソル
" ================================================
" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~
" 行番号を表示
set number
" カーソルラインをハイライト
set cursorline

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start

" ================================================
" カッコ・タグジャンプ
" ================================================
" 括弧の対応関係を一瞬表示する
set showmatch
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim

" ================================================
" コマンド補完
" ================================================
" コマンドモードの補完
set wildmenu
" 保存するコマンド履歴の数
set history=5000

" ================================================
" マウスの有効化
" ================================================
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" ================================================
" ペースト設定
" ================================================
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" ================================================
" vim-plugのインストール
" ================================================
" 初回起動時のみプラグインをインストール
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" ================================================
" プラグインの管理
" ================================================
call plug#begin('~/.vim/plugged')

" カラースキームmolokai
Plug 'tomasr/molokai'
" ステータスラインの表示内容強化
Plug 'itchyny/lightline.vim'
" 末尾の全角と半角の空白文字を赤くハイライト
Plug 'bronson/vim-trailing-whitespace'
" インデントの可視化
Plug 'Yggdroot/indentLine'

" CtrlPの拡張プラグイン
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'suy/vim-ctrlp-commandline'
Plug 'rking/ag.vim'

" 構文エラーチェック
Plug 'scrooloose/syntastic'
Plug 'pmsorhaindo/syntastic-local-eslint.vim'

call plug#end()

" ================================================
" molokaiの設定
" ================================================
colorscheme molokai

" ================================================
" ステータスラインの設定
" ================================================
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示

" ================================================
" vim-trailing-whitespace（全角と半角の空白文字を可視化）
" ================================================
set laststatus=2
set showmode
set showcmd
set ruler

" ================================================
" CtrlPの設定
" ================================================
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100'
let g:ctrlp_show_hidden = 1
let g:ctrlp_types = ['fil']
let g:ctrlp_extensions = ['funky', 'commandline']
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())
let g:ctrlp_funky_matchtype = 'path'

" ================================================
" ag.vimの設定
" ================================================
if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --hidden -g ""'
endif

" ================================================
" Syntasticの設定
" ================================================
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript'], 'passive_filetypes': [] }

" ================================================
" molokaiの色設定
" ================================================
colorscheme iceberg
set t_Co=256
syntax enable
