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
		return ::World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Crafting);
	}

	function onFilterAll() {
		this.onFilter("All");
	}

	function onFilterTailoring() {
		this.onFilter(::Legends.Profession.LegendTailoring);
	}

	function onFilterLeatherworking() {
		this.onFilter(::Legends.Profession.LegendLeatherworking);
	}

	function onFilterMetalworking() {
		this.onFilter(::Legends.Profession.LegendMetalworking);
	}

	function onFilterWoodworking() {
		this.onFilter(::Legends.Profession.LegendWoodworking);
	}

	function onFilterTrophyCarving() {
		this.onFilter(::Legends.Profession.LegendTrophyCarving);
	}

	function onFilterAlchemy() {
		this.onFilter(::Legends.Profession.LegendAlchemy);
	}

	function onFilterHerbcraft() {
		this.onFilter(::Legends.Profession.LegendHerbcraft);
	}

	function onFilterCharlatan() {
		this.onFilter(::Legends.Profession.LegendCharlatan);
	}

	function onFilterOther() {
		this.onFilter("Other");
	}

	function onFilter(_filter) {
		if (this.m.InventoryFilter != _filter) {
			this.m.InventoryFilter = _filter;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}
});
