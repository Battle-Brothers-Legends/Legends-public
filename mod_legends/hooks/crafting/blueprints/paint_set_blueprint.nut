::mods_hookExactClass("crafting/blueprints/paint_set_blueprint", function (o) {
	o.isValid <- function () {
		return false; // Deactivates this vanilla recipe
	}
});
