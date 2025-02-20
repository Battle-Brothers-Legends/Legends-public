this.camp_crafting_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Title = "Crafting",
		Description = "While encamped, craft all manner of useful items.",
		InventoryFilter = this.Const.Items.ItemFilter.All,
		CurrentPage = 0,
	},
	function create()
	{
		this.m.ID = "CampCraftingDialogModule";
		this.ui_module.create();
	}

	function getTent()
	{
		return this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Crafting);
	}

	function onShow()
	{
		this.m.CurrentPage = 0;
		this.getTent().onInit();
		return this.queryLoad();
	}

	function queryQueue()
	{
		local result = {
			Assets = this.assetsInformation(),
			Queue = this.getTent().getQueue()
		};
		return result;
	}

	function assetsInformation()
	{
		return {
			Time = this.getTent().getRequiredTime(),
			Brothers = this.getTent().getAssignedBros()
		};
	}

	function loadCraftList()
	{
		local result = this.queryQueue();
		this.m.JSHandle.asyncCall("loadFromData", result);
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function onSwap( _data )
	{
		this.getTent().onSwap(_data[0], _data[1]);
		this.loadCraftList();
	}

	function onRemove( _idx )
	{
		this.getTent().onRemove(_idx);
		this.loadCraftList();
	}

	function onAdd( _result )
	{
		this.getTent().onAdd(_result.ID);
		this.loadCraftList();
	}

	function onCraftForever (_result)
	{
		if (this.getTent().onCraftForever(_result.ID))
		{
			this.loadCraftList();
		}
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

	function onBrothersButtonPressed()
	{
		this.m.Parent.onCommanderButtonPressed();
	}

	function queryLoad()
	{
		local bps = ::World.Crafting.getQualifiedBlueprintsForUI(this.m.InventoryFilter);
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

	function loadBlueprints()
	{
		local bps = ::World.Crafting.getQualifiedBlueprintsForUI(this.m.InventoryFilter);
		local indexStart = this.m.CurrentPage * 4;
		local result = {
			Blueprints = bps.slice(indexStart, ::Math.min(indexStart + 4, bps.len())),
			CurrentPage = this.m.CurrentPage,
			Pages = ::Math.floor((bps.len() + 3) / 4)
		};
		this.m.JSHandle.asyncCall("loadFromData", result);
	}

	function onFilterAll()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.All)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.All;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	function onFilterWeapons()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Weapons)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Weapons;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	function onFilterArmor()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Armor)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Armor;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	function onFilterMisc()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Misc)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Misc;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	function onFilterUsable()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Usable)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Usable;
			this.m.CurrentPage = 0;
			this.loadBlueprints();
		}
	}

	function onPageChange(_result) {
		this.m.CurrentPage = _result.ID;
		this.loadBlueprints();
	}

});

