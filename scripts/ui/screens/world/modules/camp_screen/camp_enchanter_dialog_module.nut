this.camp_enchanter_dialog_module <- this.inherit("scripts/ui/screens/world/modules/camp_screen/camp_item_creation_dialog_module", {
	m = {
		Title = "Enchanting",
		Description = "Craft powerful runes while encamped.",
	},

	function create() {
		this.m.ID = "CampEnchanterDialogModule";
		this.ui_module.create();
	}

	function getTent() {
		return ::World.Camp.getBuildingByID(::Const.World.CampBuildings.Enchanter);
	}
});
