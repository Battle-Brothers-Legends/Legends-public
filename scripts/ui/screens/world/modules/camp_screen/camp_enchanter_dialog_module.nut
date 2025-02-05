
this.camp_enchanter_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Title = "Enchanting",
		Description = "While encamped, the Vala can craft powerful runes"
	},
	function create()
	{
		this.m.ID = "CampEnchanterDialogModule";
		this.ui_module.create();
	}

	function getTent()
	{
		return this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Enchanter);
	}

	function onShow()
	{
		this.getTent().onInit();
		return this.queryLoad();
	}

	function queryLoad()
	{
		local result = {
			Title = this.m.Title,
			SubTitle = this.m.Description,
			Assets = this.assetsInformation(),
			Blueprints = this.World.Crafting.getQualifiedEnchanterBlueprintsForUI(),
			Queue = this.getTent().getQueue()
		};
		return result;
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

	function onSwap ( _data )
	{
		this.getTent().onSwap( _data[0], _data[1] );
		this.loadCraftList();
	}

	function onRemove ( _idx)
	{
		this.getTent().onRemove( _idx );
		this.loadCraftList();
	}

	function onAdd( _blueprintID )
	{
		this.getTent().onAdd( _blueprintID );
		this.loadCraftList();
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
