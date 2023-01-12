//update rating
with (obj_stats) {
	rating += day_rating;
	day_rating = 0;
	rating = clamp(rating, 0, tiermaster.max_rating);
}

if (saver.saving_on and saver.already_loaded) {
	//with (saver) save_to_file_old();
	//with (obj_stats) {
	//	new_notif = true;
	//	notif_string = "Game saved";
	//}
}