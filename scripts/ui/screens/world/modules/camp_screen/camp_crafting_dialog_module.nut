this.camp_crafting_dialog_module <- this.inherit("scripts/ui/screens/world/modules/camp_screen/camp_item_creation_dialog_module", {
	m = {
		Title = "Crafting",
		Description = "Craft trophies and equipment while encamped."
	},

	function create() {
		this.m.ID = "CampCraftingDialogModule";
		this.ui_module.create();
	}

	function getTent() {
		return ::World.Camp.getBuildingByID(::Const.World.CampBuildings.Crafting);
	}

	function onFilterAll() {
		this.onFilter("All");
	}

	function onFilterWeapons() {
		this.onFilter("Weapons");
	}

	function onFilterArmor() {
		this.onFilter("Armor");
	}

	function onFilterMisc() {
		this.onFilter("Misc");
	}

	function onFilterUsable() {
		this.onFilter("Usable");
	}

	function onFilter(_filter) {
		if (this.m.InventoryFilter != ::Const.Items.ItemFilter[_filter]) {
			this.m.InventoryFilter = ::Const.Items.ItemFilter[_filter];
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}
});
