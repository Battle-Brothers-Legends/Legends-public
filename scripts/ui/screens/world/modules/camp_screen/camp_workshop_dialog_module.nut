this.camp_workshop_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Title = "Workshop",
		Description = "Salvage equipment to produce tools in order left to right, top to bottom. Assign workers in the commanders tent.",
		InventoryFilter = this.Const.Items.ItemFilter.All
	},
	function create()
	{
		this.m.ID = "CampWorkshopDialogModule";
		this.ui_module.create();
	}

	function getTent()
	{
		return ::World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Workshop);
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function onShow()
	{
		this.getTent().onInit();
		return this.queryLoad();
	}

	function queryLoad()
	{
		local tent = this.getTent();
		local result = {
			Title = this.m.Title,
			SubTitle = this.m.Description,
			Assets = this.assetsInformation(),
			Stash = [],
			Repairs = [],
			Capacity = tent.getCapacity()
		}
		this.UIDataHelper.convertRepairItemsToUIData(tent.getRepairs(), result.Repairs, ::Const.UI.ItemOwner.Shop);
		this.UIDataHelper.convertRepairItemsToUIData(tent.getStash(), result.Stash, ::Const.UI.ItemOwner.Stash, this.m.InventoryFilter);
		return result;
	}

	function assetsInformation()
	{
		local tent = this.getTent();
		return {
			Supplies = this.World.Assets.getArmorParts(),
			SuppliesMax  = this.World.Assets.getMaxArmorParts(),
			SuppliesRequired = tent.getRequiredSupplies(),
			Time = tent.getRequiredTime(),
			Brothers = tent.getAssignedBros()
		}
	}

	function loadStashList()
	{
		local result = this.queryLoad();
		this.m.JSHandle.asyncCall("loadFromData", result);
	}

	function onSortButtonClicked()
	{
		if (this.Tactical.isActive())
		{
			this.getroottable().Stash.sort();
		}
		else
		{
			this.World.Assets.getStash().sort();
		}

		local tent = this.World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Workshop);
		tent.onInit();
		this.loadStashList();
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

	function onFilter(_filter) {
		if (this.m.InventoryFilter != ::Const.Items.ItemFilter[_filter]) {
			this.m.InventoryFilter = ::Const.Items.ItemFilter[_filter];
			this.loadStashList();
		}
	}

	function onAssignAll()
	{
		this.getTent().assignAll(this.m.InventoryFilter);
		this.loadStashList();
	}

	function onRemoveAll()
	{
		this.getTent().removeAll();
		this.loadStashList();
	}

	function onSwapItem( _data )
	{
		local sourceItemIdx = _data[0];
		local sourceItemOwner = _data[1];
		local targetItemIdx = _data[2];
		local targetItemOwner = _data[3];
		this.getTent().swapItems(sourceItemOwner, sourceItemIdx, targetItemOwner, targetItemIdx);
		return this.queryLoad();
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

	function onBrothersButtonPressed()
	{
		this.m.Parent.onCommanderButtonPressed();
	}
});
