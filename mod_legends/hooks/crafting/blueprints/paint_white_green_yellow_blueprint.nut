::mods_hookExactClass("crafting/blueprints/paint_white_green_yellow_blueprint", function (o) {
	o.isValid <- function () {
		return false; // Deactivates this vanilla recipe
	}
});
