" Enable syntax highlighting
syntax on

" Set the tab width to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Show line numbers
set number
set relativenumber

" Enable mouse support
set mouse=a

" Set colorscheme
colorscheme desert

" Set the default file encoding to UTF-8
set encoding=utf-8

" Map Ctrl+d to move down half a screen and keep cursor centered
nnoremap <C-d> <C-d>zz

" Map Ctrl+s to move up half a screen and keep cursor centered
nnoremap <C-s> <C-u>zz

" Map 'jk' in insert mode to escape
inoremap jk <Esc>
nnoremap <Space>q :q<CR>
nnoremap <Space>s :w<CR>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Visual mode: Indent and re-select
vnoremap < <gv
vnoremap > >gv

" Move text
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Visual mode: Move to end/start of line
vnoremap <Space>d $
nnoremap <Space>d $
" Uncomment if needed:
" nnoremap <Space>d $
vnoremap <Space>a ^
nnoremap <Space>a ^

" Vertical split
nnoremap <Space>v :vsplit<CR>

" Horizontal split
nnoremap <Space>b :split<CR>

" Pane navigation
nnoremap <Space>h <C-w>h
nnoremap <Space>j <C-w>j
nnoremap <Space>k <C-w>k
nnoremap <Space>l <C-w>l

" Yank to system clipboard
vnoremap <leader>yy "+y

" Paste from system clipboard
vnoremap <leader>yp "+p
