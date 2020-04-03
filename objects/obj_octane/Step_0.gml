/// @description Insert description here
// You can write your code in this editor
gravity = .1


image_angle += 3 * gamepad_axis_value(0, gp_axislv)

if (gamepad_button_check(0, gp_face2)) {
	//boost
	motion_add(image_angle, 0.2)
	effect_create_below(ef_smoke, x, y, 0.1, c_blue)
}

if (y < 160) {
	y = 160
	vspeed = 0
	jumps_available = 1
}


if (y > room_height - 6) {
	y = room_height - 6
	vspeed = 0
	if (hspeed < 0) hspeed += 0.05
	if (hspeed > 0) hspeed -= 0.05
	
	if (image_angle < 0) image_angle += 3
	if (image_angle > 0) image_angle -= 3
	if (image_angle > -2 &&  image_angle < 2) image_angle = 0
	
	if (image_angle > -10 && image_angle < 10) {
		if (gamepad_button_check(0, gp_shoulderlb)) {
			hspeed -= 0.1
		} 
		if (gamepad_button_check(0, gp_shoulderrb) ) {
			hspeed += 0.1
		} 

		jumps_available = 2

		if (gamepad_button_check_pressed(0, gp_face1)) {
			jumps_available = jumps_available - 1
			vspeed = -4
			effect_create_below(ef_explosion, x, y, 1, c_gray)
		} 
	}
} else  {
	if (gamepad_button_check_pressed(0, gp_face1) && jumps_available > 0) {
		jumps_available = jumps_available - 1
		motion_add(image_angle + 90, 4)
		effect_create_below(ef_explosion, x, y, 1, c_gray)
		//jumping
	}
}

if (x < obj_wallL.x + 45) {
	x = obj_wallL.x + 45
	hspeed = 0
	jumps_available = 1
}
if (x > obj_wallR.x) {
	x = obj_wallR.x
	hspeed = 0
	jumps_available = 1
}