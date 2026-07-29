this.camp_crafting_dialog_module <- this.inherit("scripts/ui/screens/world/modules/camp_screen/camp_item_creation_dialog_module", {
	m = {
		Title = "Crafting",
		Description = "Craft trophies and equipment while encamped.",
		InventoryFilter = ::Const.Items.ItemFilter.All,
	},

	function create() {
		this.m.ID = "CampCraftingDialogModule";
		this.ui_module.create();
	}

	function getTent() {
		return ::World.Camp.getBuildingByID(::Const.World.CampBuildings.Crafting);
	}

	function queryLoad() {
		local bps = ::World.Crafting.getQualifiedBlueprintsForUI(this.m.InventoryFilter, this.m.Title);
		local indexStart = this.m.CurrentPage * 4;
		local result = {
			Title = this.m.Title,
			SubTitle = this.m.Description,
			Assets = this.assetsInformation(),
			Blueprints = bps.slice(indexStart, ::Math.min(indexStart + 4, bps.len())),
			Queue = this.getTent().getQueue(),
			CurrentPage = this.m.CurrentPage,
			Pages = ::Math.floor((bps.len() + 3) / 4)
		};
		return result;
	}

	function loadBlueprints() {
		local bps = ::World.Crafting.getQualifiedBlueprintsForUI(this.m.InventoryFilter, this.m.Title);
		local indexStart = this.m.CurrentPage * 4;
		local result = {
			Blueprints = bps.slice(indexStart, ::Math.min(indexStart + 4, bps.len())),
			CurrentPage = this.m.CurrentPage,
			Pages = ::Math.floor((bps.len() + 3) / 4)
		};
		this.m.JSHandle.asyncCall("loadFromData", result);
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

	function onPageChange(_result) {
		this.m.CurrentPage = _result.ID;
		this.loadBlueprints();
	}
});
