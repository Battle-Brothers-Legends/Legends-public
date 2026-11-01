::mods_hookExactClass("crafting/blueprints/paint_red_blueprint", function (o) {
	o.isValid <- function () {
		return false; // Deactivates this vanilla recipe
	}
});
