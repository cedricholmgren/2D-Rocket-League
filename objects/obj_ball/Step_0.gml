/// @description Insert description here
// You can write your code in this editor

var dampening = 0.7
var goal_top = 464
var goal_bottom = 564

var bluecar = instance_find(obj_octane, 0)
var redcar = instance_find(obj_octane, 1)


// ground
if (y > room_height - 36) {
	y = room_height - 36
	vspeed = dampening * abs(vspeed) * -1
}


// Ceiling
if (y < obj_ceiling.y + 36) {
	y = obj_ceiling.y + 36
	vspeed = dampening * abs(vspeed)
}

// Left wall
if (x < obj_wall_left.x + 36) {
	// Check goal
	if (y > goal_top && y < goal_bottom) {
		// let it through		
		
		// if close to top, force it down. same for bottom, up
		if (y < goal_top + 20) vspeed = abs(vspeed)
		if (y > goal_bottom - 20) vspeed = -1 * abs(vspeed)
		
		if (x < obj_wall_left.x - 36) {
			// effect_create_above(ef_explosion, x, y, 100, c_red)
			x = room_width / 2
			y = obj_ceiling.y + 100
			speed = 0
			redcar.goals += 1
			
			audio_play_sound(snd_explosion, 0, false)
			
			redcar.x = redcar.resetX
			redcar.y = redcar.resetY
			redcar.speed = 0
			redcar.image_angle = 0
			bluecar.x = bluecar.resetX
			bluecar.y = bluecar.resetY
			bluecar.speed = 0
			bluecar.image_angle = 0
			possible_save = 0
			last_touched_by = 0
			goal_countdown = 200
		}
	} else {
		x = obj_wall_left.x + 36
		hspeed = dampening * abs(hspeed)
	}
}

// Right wall
if (x > obj_wall_right.x - 36) {
	// Check goal
	if (y > goal_top && y < goal_bottom) {
		// let it through
		
		// if close to top, force it down. same for bottom, up
		if (y < goal_top + 20) vspeed = abs(vspeed)
		if (y > goal_bottom - 20) vspeed = -1 * abs(vspeed)

		if (x > obj_wall_right.x + 36) {
			// effect_create_above(ef_explosion, x, y, 100, c_blue)
			x = room_width / 2
			y = obj_ceiling.y + 100
			speed = 0
			
			var bluecar = instance_find(obj_octane, 0)
			
			audio_play_sound(snd_explosion, 0, false)
			
			bluecar.goals += 1
			redcar.x = redcar.resetX
			redcar.y = redcar.resetY
			redcar.speed = 0
			redcar.image_angle = 0
			bluecar.x = bluecar.resetX
			bluecar.y = bluecar.resetY
			bluecar.speed = 0
			bluecar.image_angle = 0
			possible_save = 0
			last_touched_by = 0
			goal_countdown = 200
		}
	} else {
		x = obj_wall_right.x - 36
		hspeed = dampening * abs(hspeed) * -1
	}
}

if (possible_save != 0) {
	var right_goal_x = obj_wall_right.x
	var left_goal_x = obj_wall_left.x
	var goal_y = 514

	if (possible_save == 1) {
		var dist_to_my_goal = point_distance(x, y, left_goal_x, goal_y)
		if (dist_to_my_goal > goal_save_radius) {
			// save!
			possible_save = 0
			bluecar.saves += 1
			audio_play_sound(What_a_save, 0, false)
			save_countdown = 100
		}
	} else {
		var dist_to_my_goal = point_distance(x, y, right_goal_x, goal_y)
		if (dist_to_my_goal > goal_save_radius) {
			// save!
			possible_save = 0
			redcar.saves += 1
			audio_play_sound(What_a_save, 0, false)
			save_countdown = 100
		}
	}
}

if (last_touched_by != 0) {
	var right_goal_x = obj_wall_right.x
	var left_goal_x = obj_wall_left.x
	var goalY = 514

	if (last_touched_by == 1) {
		var dist_to_goal = point_distance(x, y, right_goal_x, goalY)
		if (dist_to_goal < 100) {
			// shot!
			last_touched_by = 0
			bluecar.shots += 1
		}
	} else {
		var dist_to_goal = point_distance(x, y, left_goal_x, goalY)
		if (dist_to_goal < 100) {
			// shot!
			last_touched_by = 0
			redcar.shots += 1
		}
	}
}


if (speed > 12) speed = 12

if (bounce_cooldown > 0) bounce_cooldown -= 1



