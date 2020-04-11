/// @description Insert description here
// You can write your code in this editor
if (keyboard_check_pressed(vk_down)) {
	cur_index ++
}

if (keyboard_check_pressed(vk_up)) {
	cur_index --
}

if (cur_index == 0 && keyboard_check_pressed(vk_enter)) {
		room_goto_next()
}

if (cur_index == 1 && keyboard_check_pressed(vk_enter)) {
		game_end()
}

cur_index = clamp(cur_index, 0, array_length_1d(menu) - 1)
