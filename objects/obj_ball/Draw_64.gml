/// @description Insert description here
// You can write your code in this editor

save_countdown -= 1
if (save_countdown > 0) {
	var midX = room_width / 2
	var midY = room_height / 2
	draw_set_halign(fa_middle)
	draw_text_ext_transformed_color(midX, midY, "WHAT A SAVE!", 20, 200, 3, 3, 0, c_white, c_white, c_white, c_white, save_countdown / 100)
}

if (goal_countdown > 0) {
	goal_countdown -= 1

}
