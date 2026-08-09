this.camp_screen <- {
	m = {
		JSHandle = null,
		Visible = null,
		Animating = false,
		LastActiveModule = null,
		returnModule = null,

		Modules = {}
		ModuleConfig = {
			[::Legends.Camp.CampBuildings.Commander] = { name = "Commander", dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Barber]    = { name = "Barber",    dataFn = "queryRosterInformation" },
			[::Legends.Camp.CampBuildings.Crafting]  = { name = "Crafting",  dataFn = "onShow" },
			[::Legends.Camp.CampBuildings.Enchanter] = { name = "Enchanter", dataFn = "onShow" },
			[::Legends.Camp.CampBuildings.Fletcher]  = { name = "Fletcher",  dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Gatherer] = { name = "Gatherer", dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Healer] = { name = "Healer", dataFn = "onShow" },
			//[::Legends.Camp.CampBuildings.Hunter]  = { name = "Hunter",  dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Kitchen] = { name = "Kitchen", dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Painter]  = { name = "Painter",  dataFn = "queryRosterInformation" },
			[::Legends.Camp.CampBuildings.Repair] = { name = "Repair", dataFn = "onShow" },
			[::Legends.Camp.CampBuildings.Rest]  = { name = "Rest",  dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Scout] = { name = "Scout", dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Training]  = { name = "Training",  dataFn = "queryLoad" },
			[::Legends.Camp.CampBuildings.Workshop] = { name = "Workshop", dataFn = "onShow" },
    	}

		Listeners = {
			OnConnected = null,
			OnDisconnected = null,
			OnBrothersButtonPressed = null,
			OnCommanderButtonPressed = null,
			OnTentButtonPressed = null,
			OnModuleClosed = null,
			OnCamp = null
		}
	},

	function isVisible() {
		return this.m.Visible == true;
	}

	function isAnimating() {
		return this.m.Animating == true || this.m.Modules.Main.isAnimating() || this.m.Modules[::Legends.Camp.CampBuildings.Commander].isAnimating();
	}

	function getDialogModule(_dialog) {
		return this.m.DialogModule[_dialog];
	}

	function setListener(_name, _listener) {
		this.m.Listeners[_name] = _listener;
	}

	function clearEventListener() {
		this.m.Listeners = {};
	}

	function create() {
		this.m.Visible = false;
		this.m.Animating = false;
		this.m.JSHandle = this.UI.connect("CampScreen", this);

		this.m.Modules["Main"] <- this.new("scripts/ui/screens/world/modules/camp_screen/camp_main_dialog_module");
        this.m.Modules["Main"].setParent(this);
        this.m.Modules["Main"].connectUI(this.m.JSHandle);

		foreach (id, config in this.m.ModuleConfig) {
            this.m.Modules[id] <- this.new("scripts/ui/screens/world/modules/camp_screen/camp_" + config.name.tolower() + "_dialog_module");
            this.m.Modules[id].setParent(this);
            this.m.Modules[id].connectUI(this.m.JSHandle);
        }
	}

	function destroy() {
		this.clearEventListener();
		foreach (module in this.m.Modules) {
            module.destroy();
        }
		this.m.Modules = {};
		this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
	}

	function clear() {
		foreach (module in this.m.Modules) {
            module.clear();
        }
	}

	function show() {
		::World.Camp.onEnter();
		if (this.m.JSHandle != null) {
			this.m.LastActiveModule = null;
			::Tooltip.hide();
			this.m.JSHandle.asyncCall("show", this.queryCampInformation());
		}
	}

	function hide()	{
		if (this.m.JSHandle != null) {
			this.m.LastActiveModule = null;
			this.m.JSHandle.asyncCall("hide", null);
			::Tooltip.hide();
		}
	}

	function hideAllDialogs() {
		if (this.m.JSHandle != null) {
			::Tooltip.hide();
			this.m.JSHandle.asyncCall("hideAllDialogs", null);
		}
	}

	function refresh() {
		if (this.m.JSHandle != null) {
			this.m.LastActiveModule = null;
			::Tooltip.hide();
			this.m.JSHandle.asyncCall("refresh", this.queryCampInformation());
		}
	}

	function showLastReturnDialog() {
		this.m.LastActiveModule = this.m.returnModule;
		this.m.returnModule = null;
		this.showLastActiveDialog();
	}

	function showLastActiveDialog()	{
		if (this.m.LastActiveModule != null && this.m.LastActiveModule in this.m.Modules) {
            this.showCampBuildingDialog(this.m.LastActiveModule);
        } else {
            this.showMainDialog();
        }
	}

	function showMainDialog() {
		if (this.m.JSHandle != null && this.isVisible()) {
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showMainDialog", this.queryAssetsInformation());
		}
	}

	function showCampBuildingDialog( _id ) {
		if (this.m.JSHandle != null && this.isVisible()) {

            local module = this.m.Modules[_id];
            local config = this.m.ModuleConfig[_id];
            
            this.m.LastActiveModule = _id;
            this.Tooltip.hide();
            
            local data = null;
            if (config.dataFn == "queryLoad") data = module.queryLoad();
            else if (config.dataFn == "onShow") data = module.onShow();
            else if (config.dataFn == "queryRosterInformation") data = module.queryRosterInformation();


            this.m.JSHandle.asyncCall("show" + config.name + "Dialog", data);
        }
	}

	function updateContracts() {
		this.m.JSHandle.asyncCall("updateContracts", ::World.Camp.getUIContractInformation());
	}

	function updateAssets() {
		this.m.JSHandle.asyncCall("loadAssetData", this.queryAssetsInformation());
	}

	function onScreenConnected() {
		if (this.m.Listeners.OnConnected != null)	{
			this.m.Listeners.OnConnected();
		}
	}

	function onScreenDisconnected() {
		if (this.m.Listeners.OnDisconnected != null) {
			this.m.Listeners.OnDisconnected();
		}
	}

	function onScreenShown() {
		this.m.Visible = true;
		this.m.Animating = false;
	}

	function onScreenHidden() {
		this.m.Visible = false;
		this.m.Animating = false;
	}

	function onScreenAnimating() {
		this.m.Animating = true;
	}

	function onBrothersButtonPressed() {
		if (this.m.Listeners.OnBrothersButtonPressed != null)	{
			this.m.Listeners.OnBrothersButtonPressed();
		}
	}

	function onCommanderButtonPressed()	{
		if (this.m.returnModule != null) {
			return false;
		}

		if (this.m.Listeners.OnCommanderButtonPressed == null) {
			return false;
		}

		this.m.returnModule = this.m.LastActiveModule;
		this.m.Listeners.OnCommanderButtonPressed();
		return true;
	}

	function onShowTentBuilding( _id ) {
		if (this.m.returnModule != null) {
			return false;
		}

		if (this.m.Listeners.OnTentButtonPressed == null)	{
			return false;
		}

		this.m.returnModule = this.m.LastActiveModule;
		this.m.Listeners.OnTentButtonPressed(_id);
		return true;
	}

	function onEncounterClicked (_data) {
		if (this.isAnimating())
			return;
		::World.Camp.onEncounterClicked(_data, this);
	}

	function onModuleClosed() {
		if (this.m.Listeners.OnModuleClosed != null) {
			this.m.Listeners.OnModuleClosed();
		}
	}

	function onCampClosed() {
		if (this.m.Listeners.OnCamp != null)	{
			this.m.Listeners.OnCamp();
		}
	}

	function onContractClicked( _data ) {
		if (this.isAnimating())
			return;
		::World.Contracts.showContractByID(_data);
	}

	function onSlotClicked( _data ) {
		if (this.isAnimating())	{
			return;
		}

		local building = ::World.Camp.getBuildingByID(_data);

		if (building == null) {
			return;
		}

		building.onClicked(this);
	}

	function onSlotRightClicked(_data) {
		if (this.isAnimating() || !::World.Camp.getBuildingByID(_data).inCommanderTent()) {
			return;
		}

		local building = ::World.Camp.getBuildingByID(_data);

		if (building == null) {
			return;
		}

		this.m.Modules[::Legends.Camp.CampBuildings.Commander].m.RightClickedTent = _data;
		::World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Commander).onClicked(this);
	}

	function getTimeRequired() {
		return "No camp tasks have been scheduled...";
	}

	function getUITerrain() {
		return ::World.Camp.getUITerrain();
	}

	function queryCampInformation()	{
		return this.getUIInformation();
	}

	function queryAssetsInformation() {
		return ::UIDataHelper.convertAssetsInformationToUIData();
	}

	function getUIInformation()	{
		local result = ::World.Camp.getUIInformation();
		result.Assets <- this.queryAssetsInformation();
		return result;
	}

};

