let g:foolish_move#config = get(g:, 'foolish_move#config', {})
let g:foolish_move#config.fps = get(g:foolish_move#config, 'fps', 1000.0 / 16)
let g:foolish_move#config.drag = get(g:foolish_move#config, 'drag', 1)
let g:foolish_move#config.speed = get(g:foolish_move#config, 'speed', 2)

let s:state = {
			\   'timer_id': -1,
			\   'tick_count': 0,
			\   'v_x': 0,
			\   'v_y': 0
      \ }

function! foolish_move#flick(direction)
	if a:direction ==# 'up'
		let s:state.v_y -= g:foolish_move#config.speed
	elseif a:direction ==# 'down'
		let s:state.v_y += g:foolish_move#config.speed
	elseif a:direction ==# 'left'
		let s:state.v_x -= g:foolish_move#config.speed
	elseif a:direction ==# 'right'
		let s:state.v_x += g:foolish_move#config.speed
	endif
	call s:start_timer()
endfunction

function! foolish_move#stop()
	call s:stop_timer()
endfunction

function! s:start_timer()
	if s:state.timer_id == -1
		let s:state.timer_id = timer_start(float2nr(g:foolish_move#config.fps), function('s:tick'), { 'repeat': -1 })
	endif
endfunction

function! s:stop_timer()
	function! Stop(timer_id)
		call timer_stop(s:state.timer_id)
		let s:state.timer_id = -1
		let s:state.v_x = 0
		let s:state.v_y = 0
	endfunction
	call timer_start(0, function('Stop'), { 'repeat': 1 })
endfunction

function! s:tick(timer_id)
	let pos = s:pos()
	let lnum = max([1, min([line('$'), float2nr(pos[0] + s:state.v_y)])])
	let col = max([1, float2nr(pos[1] + s:state.v_x * 2)])
	call cursor([lnum, col])

	if abs(s:state.v_x) == 0 && abs(s:state.v_y) == 0
		call s:stop_timer()
	endif
endfunction

function! s:pos()
	let [bufnum, lnum, col, off] = getpos('.')
	return [lnum, col + off]
endfunction

