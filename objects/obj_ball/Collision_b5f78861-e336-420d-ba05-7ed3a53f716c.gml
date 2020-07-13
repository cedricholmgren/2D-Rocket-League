/// @description Insert description here
// You can write your code in this editor

var dir_to_octane = point_direction(x, y, other.x, other.y)
var dir_to_ball = point_direction(other.x, other.y, x, y)

var angle_diff = abs(angle_difference(dir_to_ball, other.image_angle))

var force_ratio = 0.05
var force_from_octane = abs(angle_diff - 90) * force_ratio

// var original_direction = direction
// var original_speed = speed

motion_add(dir_to_ball, force_from_octane)

if (bounce_cooldown <= 0) {
	audio_play_sound(snd_bounce, 10, false)
	bounce_cooldown = 20;
}

with (other) {
	motion_add(dir_to_octane, 0.5)
}

var goal_x = obj_wall_right.x
var my_goal_x = obj_wall_left.x
if (other.facing == -1) {
	goal_x = obj_wall_left.x
	my_goal_x = obj_wall_right.x
}
var goal_y = 511

// var dir_to_goal = point_direction(x, y, goal_x, goal_y)
// var original_goal_angle_diff = abs(angle_difference(original_direction, dir_to_goal))
// var new_goal_angle_diff = abs(angle_difference(direction, dir_to_goal))

if (last_touched_by != other.facing) {
	last_touched_by = 0
	
	var dist_to_my_goal = point_distance(x, y, my_goal_x, goal_y)
	if (dist_to_my_goal < goal_save_radius) {
		possible_save = other.facing
	}
	var dist_to_other_goal = point_distance(x, y, goal_x, goal_y)
	if (dist_to_other_goal > 100) {
		last_touched_by = other.facing
	}
}
