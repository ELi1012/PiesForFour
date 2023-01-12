function mouse_over_button(_struct_id, mx, my) {
	var s = _struct_id;
	return point_in_rectangle(mx, my, s.x1, s.y1, s.x2, s.y2);
}