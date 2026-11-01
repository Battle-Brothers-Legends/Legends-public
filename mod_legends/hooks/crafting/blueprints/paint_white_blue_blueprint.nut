::mods_hookExactClass("crafting/blueprints/paint_white_blue_blueprint", function (o) {
	o.isValid <- function () {
		return false; // Deactivates this vanilla recipe
	}
});
