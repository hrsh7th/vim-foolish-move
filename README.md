# foolish_move

## Usage

```VimL
nnoremap h :<C-u>call move#stop()<CR>h
nnoremap j :<C-u>call move#stop()<CR>j
nnoremap k :<C-u>call move#stop()<CR>k
nnoremap l :<C-u>call move#stop()<CR>l
nnoremap H :<C-u>call move#flick('left')<CR>
nnoremap J :<C-u>call move#flick('down')<CR>
nnoremap K :<C-u>call move#flick('up')<CR>
nnoremap L :<C-u>call move#flick('right')<CR>
```

