/// @description Insert description here
// You can write your code in this editor

var midpoint = room_width / 2
var drawX = midpoint - 200 * facing

draw_text(drawX, 80, "GOALS: " + string(goals));
draw_text(drawX, 100, "SHOTS: " + string(shots));
draw_text(drawX, 120, "SAVES: " + string(saves));
