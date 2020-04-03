/// @description Insert description here
// You can write your code in this editor


var dir_to_octane = point_direction(x, y, other.x, other.y)
var dir_to_ball = point_direction(other.x, other.y, x, y)

motion_add(dir_to_ball, 0.5)

with (other) {
	motion_add(dir_to_octane, 0.5)
}
