this.camp_healer_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Title = "Healing",
		Description = "Mend wounds and tend injuries."
	},

	function create() {
		this.m.ID = "CampHealerDialogModule";
		this.ui_module.create();
	}

	function getTent() {
		return this.World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Healer);
	}

	function onShow() {
		this.getTent().onInit();
		return this.queryLoad();
	}

	function queryLoad() {
		local result = {
			Title = this.m.Title,
			SubTitle = this.m.Description,
			Assets = this.assetsInformation(),
			Roster = this.getTent().getRoster(),
			Queue = this.getTent().getQueue(),
			IsUpgraded = this.getTent().getUpgraded()
		};
		return result;
	}

	function queryQueue() {
		local result = {
			Assets = this.assetsInformation(),
			Queue = this.getTent().getQueue()
		};
		return result;
	}

	function assetsInformation() {
		return {
			Meds = this.World.Assets.getMedicine(),
			MedsMax = this.World.Assets.getMaxMedicine(),
			MedsRequired = this.getTent().getRequiredMeds(),
			Time = this.getTent().getRequiredTime(),
			Brothers = this.getTent().getAssignedBros()
		};
	}

	function loadQueueList() {
		this.m.JSHandle.asyncCall("loadFromData", this.queryQueue());
	}

	function onSwap(_data) {
		this.getTent().onSwap(_data[0], _data[1]);
		this.loadQueueList();
	}

	function onRemove(_idx) {
		this.getTent().onRemove(_idx);
		this.m.JSHandle.asyncCall("loadFromData", this.queryLoad());
	}

	function onAdd(_data) {
		this.getTent().onAdd(_data[0], _data[1]);
		this.m.JSHandle.asyncCall("loadFromData", this.queryLoad());
	}

	function onLeaveButtonPressed() {
		this.m.Parent.onModuleClosed();
	}

	function onBrothersButtonPressed() {
		this.m.Parent.onCommanderButtonPressed();
	}

	function onToggleIntensiveCare( _broID ) {
		local flags = ::Tactical.getEntityByID(_broID).getFlags();
		flags.set("CampIntensiveCare", !flags.get("CampIntensiveCare"));
    
		this.m.JSHandle.asyncCall("loadFromData", this.queryLoad());
	}
});
