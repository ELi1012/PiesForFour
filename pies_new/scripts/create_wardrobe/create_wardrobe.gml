function create_wardrobe(_ds_id, _sprite, _name, _description, _cost) {
	
	var _grid = _ds_id;

	var height = ds_grid_height(_grid);
	if (_grid[# 0, 0] != -1) {
		ds_grid_resize(_grid, ds_grid_width(_grid), height + 1);
		height += 1;
	}
	
	var yy = height - 1;
	_grid[# 0, yy] = _sprite;
	_grid[# 1, yy] = _name;
	_grid[# 2, yy] = _description;
	_grid[# 3, yy] = _cost;
	_grid[# 4, yy] = false;

}
