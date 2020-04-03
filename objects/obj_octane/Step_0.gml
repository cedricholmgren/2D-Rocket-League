/// @description Insert description here
// You can write your code in this editor

image_angle += facing * 3 * gamepad_axis_value(gp_number, gp_axislv)
image_angle += -3 * gamepad_axis_value(gp_number, gp_axislh)
if (image_angle < -179) image_angle += 360
if (image_angle > 180) image_angle -= 360

if (gamepad_button_check(gp_number, gp_face2)) {
	//boost
	var boost_angle = image_angle
	if(facing == -1) boost_angle = image_angle + 180
	motion_add(boost_angle, 0.2)
	
	var smoke_angle = 150
	if (facing == -1) smoke_angle = 30
	var smoke_x = lengthdir_x(40, image_angle + smoke_angle)
	var smoke_y = lengthdir_y(40, image_angle + smoke_angle)
	
	effect_create_below(ef_smoke, x + smoke_x, y + smoke_y, 0.1, boost_color)
}

if (y > room_height - 6) {
	y = room_height - 6
	vspeed = 0
	if (hspeed < 0) hspeed += 0.05
	if (hspeed > 0) hspeed -= 0.05
	
	if (image_angle < 0) image_angle += 10
	if (image_angle > 0) image_angle -= 10
	if (image_angle > -9 &&  image_angle < 9) image_angle = 0
	
	if (image_angle > -20 && image_angle < 20) {
		if (gamepad_button_check(gp_number, gp_shoulderlb)) {
			hspeed -= 0.2 * facing
		} 
		if (gamepad_button_check(gp_number, gp_shoulderrb) ) {
			hspeed += 0.2 * facing
		} 

		jumps_available = 2

		if (gamepad_button_check_pressed(gp_number, gp_face1)) {
			jumps_available = jumps_available - 1
			vspeed = -4
			effect_create_below(ef_explosion, x, y, 1, c_gray)
		} 
	}
} else  {
	if (gamepad_button_check_pressed(gp_number, gp_face1) && jumps_available > 0) {
		// jumping
		jumps_available = jumps_available - 1
		motion_add(image_angle + 90, 4)
		effect_create_below(ef_explosion, x, y, 1, c_gray)
		
	}
}

// Ceiling
if (y < obj_ceiling.y + 25) {
	y = obj_ceiling.y + 25
	vspeed = 0
	
	if (image_angle < -160 || image_angle > 160) {
		jumps_available = 1
	}
}

// Left wall
if (x < obj_wallL.x + 25) {
	x = obj_wallL.x + 25
	hspeed = 0
	
	if (image_angle > -110 && image_angle < -70) {
		jumps_available = 1
	}
}

// Right wall
if (x > obj_wallR.x - 25) {
	x = obj_wallR.x - 25
	hspeed = 0
	if (image_angle > 70 && image_angle < 110) {
		jumps_available = 1
	}
}

if (speed > 8) speed = 8
