if (!already_loaded) {
	if (!saving_on) exit;
	already_loaded = true;
	
	load_data();	// function checks if filename exists
}