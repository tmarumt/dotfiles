" color theme
" set background=dark
colorscheme OceanicNext

" position and size of window
winpos 5 5
set lines=60
set columns=120

" font and rendering
if has('win32') || has('win64')
  set guifont=Ricty_Diminished:h10:cSHIFTJIS,Consolas:h10:cSHIFTJIS
  set guifontwide=MS_Gothic:h10:cSHIFTJIS
else
  set guifont=Ricty\ Diminished\ 10
endif
set renderoptions=type:directx,geom:1,renmode:5

" tool-bar and scroll-bar
set guioptions=gea

