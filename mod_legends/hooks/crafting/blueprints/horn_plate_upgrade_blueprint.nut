::mods_hookExactClass("crafting/blueprints/horn_plate_upgrade_blueprint", function (o) {
	o.isValid <- function () {
		return false; // Deactivates this vanilla recipe as it was replaced by a legends recipe
	}
});
