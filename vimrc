" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Background
"set background=dark

" Searching
set hlsearch		" hlsearch
"set ignorecase		" Do case insensitive matching

" Mouse Integration
set mouse=a		" Enable mouse usage

" Display
set showmatch		" Show matching brackets
set number		" show line numbers
set cursorline		" Highlight current line
set wildmenu		" visual autocomplete for command menu

" Movements
set whichwrap+=<,>,h,l,[,] " left/right wrap movement

" Tabs
set tabstop=8          " how many columns a tab counts for
set softtabstop=0       " tabulation=0spaces
set expandtab           " Replace tab by spaces
set shiftwidth=4        " nb columns text is indented with << and >>
set smarttab            " active smart-tabs (better auto-indentation)
set smartindent         " active smart-indent (better auto-indent of paste)

" Netrw (default filebrowser in vim)
let g:netrw_banner = 0          " Removing the banner
let g:netrw_winsize = 25        " Windows width
" let g:netrw_browse_split = 1  " Changing how files are opened
                                " (1:hsplit/2:vsplit/3:tab/4:previousWindows)
" let g:netrw_altv = 1
" let g:netrw_hide = 1

" Ctrl-arrays D/G
map ^[[D <C-Left>
map ^[[C <C-Right>
map! ^[[D <C-Left>
map! ^[[C <C-Right>

" ---column limit (80)
" --simple way
" set colorcolumn=80 ctermbg=magenta
" background warning one char
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" --mark all char overlength
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"automatic folding
" use zo to open a fold
" use zc to close it
" use zf to manually fold a selection
set foldmethod=syntax

"see 8 lines above a below the current one
set scrolloff=8

"auto reindent all file using <F7>
map <F7> mzgg=G`z


""" Shift-F12 to remove automatically all useless spaces/tab """
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>
