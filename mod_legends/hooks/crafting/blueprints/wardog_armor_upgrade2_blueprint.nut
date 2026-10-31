// disabled because of the awkward naming, remade as legend_bone_platings_upgrade_blueprint
::mods_hookExactClass("crafting/blueprints/wardog_armor_upgrade2_blueprint", function (o) {
	o.isValid <- function () {
		return false;
	}
});
