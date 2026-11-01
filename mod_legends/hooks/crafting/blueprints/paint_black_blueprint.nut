::mods_hookExactClass("crafting/blueprints/paint_black_blueprint", function (o) {
	o.isValid <- function () {
		return false; // Deactivates this vanilla recipe
	}
});
