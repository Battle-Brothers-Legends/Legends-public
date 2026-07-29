this.camp_kitchen_dialog_module <- this.inherit("scripts/ui/screens/world/modules/camp_screen/camp_item_creation_dialog_module", {
	m = {
		Title = "Cooking",
		Description = "Cook food while encamped.",
	},

	function create() {
		this.m.ID = "CampKitchenDialogModule";
		this.ui_module.create();
	}

	function getTent() {
		return ::World.Camp.getBuildingByID(::Const.World.CampBuildings.Kitchen);
	}
});
