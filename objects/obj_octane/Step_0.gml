/// @description Insert description here
// You can write your code in this editor


var kbd_boosting = gamepad_button_check(gp_number, gp_face2)
var kbd_turn = gamepad_axis_value(gp_number, gp_axislv)
var kbd_back = gamepad_button_check(gp_number, gp_shoulderlb)
var kbd_forward = gamepad_button_check(gp_number, gp_shoulderrb)
var kbd_jump = gamepad_button_check_pressed(gp_number, gp_face1)

if (facing == 1) {
	// if (keyboard_check(ord("Q"))) image_angle += 3
	// if (keyboard_check(ord("E"))) image_angle -= 3
	if (keyboard_check(ord("S"))) kbd_boosting = 1
	if (keyboard_check(ord("A"))) { kbd_back = 1; kbd_turn = -1 }
	if (keyboard_check(ord("D"))) { kbd_forward = 1; kbd_turn = 1 }
	if (keyboard_check_pressed(ord("W"))) kbd_jump = 1
} else {
	// if (keyboard_check(ord("U"))) image_angle += 3
	// if (keyboard_check(ord("O"))) image_angle -= 3
	if (keyboard_check(ord("K"))) kbd_boosting = 1
	if (keyboard_check(ord("L"))) { kbd_back = 1; kbd_turn = 1 }
	if (keyboard_check(ord("J"))) { kbd_forward = 1; kbd_turn = -1 }
	if (keyboard_check_pressed(ord("I"))) kbd_jump = 1
}

if (kbd_boosting || kbd_jump  || kbd_back  || kbd_forward || kbd_turn) {
	alarm_set(0, 200)
}

var on_ground = y >= room_height - 6

if (AI_on == true) {
	var is_behind_ball = (obj_ball.x - x) * facing > 0
	if (on_ground) {
		if (is_behind_ball) {
			if (abs(x - obj_ball.x) < 300) {
				kbd_jump = 1
			} else {
				kbd_forward = 1
			}
		} else {
			kbd_back = 1
		}
	} else {
		if (is_behind_ball) {
			var angle_to_ball = point_direction(x, y, obj_ball.x, obj_ball.y - 20)
			var real_angle = image_angle
			if (facing == -1) real_angle = image_angle + 180
			var dif = angle_difference(real_angle, angle_to_ball)
			if (dif < 0) {
				kbd_turn = facing
			} else {
				kbd_turn = -1 * facing
			}
			if (abs(dif) < 30 && obj_ball.y - y < 50) kbd_boosting = 1
		}
	}
}

// turning
image_angle += facing * 3 * kbd_turn

// keep it from going < -180 or > 180
if (image_angle < -179) image_angle += 360
if (image_angle > 180) image_angle -= 360

if (kbd_boosting) {
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

if (on_ground) {
	y = room_height - 6
	vspeed = 0
	if (hspeed < 0) hspeed += 0.05
	if (hspeed > 0) hspeed -= 0.05
	
	if (image_angle < 0) image_angle += 10
	if (image_angle > 0) image_angle -= 10
	if (image_angle > -9 &&  image_angle < 9) image_angle = 0
	
	if (image_angle > -20 && image_angle < 20) {
		if (kbd_back) hspeed -= 0.2 * facing
		if (kbd_forward) hspeed += 0.2 * facing

		jumps_available = 2

		if (kbd_jump) {
			jumps_available = jumps_available - 1
			vspeed = -4
			effect_create_below(ef_explosion, x, y, 1, c_gray)
		} 
	}
} else  {
	if (kbd_jump && jumps_available > 0) {
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


