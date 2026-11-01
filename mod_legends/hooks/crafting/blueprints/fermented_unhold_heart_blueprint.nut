::mods_hookExactClass("crafting/blueprints/fermented_unhold_heart_blueprint", function (o) {
	o.isValid <- function () {
		return false; // Deactivates this vanilla recipe as it was replaced by a legends recipe
	}
});
