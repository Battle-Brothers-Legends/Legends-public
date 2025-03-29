
this.camp_healer_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Title = "Healing",
		Description = "Tend to wounded brothers"
	},

	function create()
	{
		this.m.ID = "CampHealerDialogModule";
		this.ui_module.create();
	}

	function getTent()
	{
		return this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Healer);
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
			Roster = this.getTent().getRoster(),
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
			Meds = this.World.Assets.getMedicine(),
			MedsMax  = this.World.Assets.getMaxMedicine(),
			MedsRequired = this.getTent().getRequiredMeds(),
			Time = this.getTent().getRequiredTime(),
			Brothers = this.getTent().getAssignedBros()
		};
	}

	function loadQueueList()
	{
		local result = this.queryQueue();
		this.m.JSHandle.asyncCall("loadFromData", result);
	}

	function onSwap ( _data )
	{
		this.getTent().onSwap( _data[0], _data[1] );
		this.loadQueueList();
	}

	function onRemove ( _idx)
	{
		local res = this.getTent().onRemove( _idx );
		local result = this.queryLoad();
		this.m.JSHandle.asyncCall("loadFromData", result);
	}

	function onAdd( _data )
	{
		local res = this.getTent().onAdd( _data[0], _data[1] );
		local result = this.queryLoad();
		this.m.JSHandle.asyncCall("loadFromData", result);
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
