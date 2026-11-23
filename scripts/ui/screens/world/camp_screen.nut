this.camp_screen <- {
	m = {
		JSHandle = null,
		MainDialogModule = null,
		CommanderDialogModule = null,
		BarberDialogModule = null,
		CraftingDialogModule = null,
		EnchanterDialogModule = null,
		FletcherDialogModule = null,
		HealerDialogModule = null,
		HunterDialogModule = null,
		PainterDialogModule = null,
		RepairDialogModule = null,
		RestDialogModule = null,
		ScoutDialogModule = null,
		TrainingDialogModule = null,
		GathererDialogModule = null,
		WorkshopDialogModule = null,
		Visible = null,
		Animating = false,
		LastActiveModule = null,
		returnModule = null,
		OnConnectedListener = null,
		OnDisconnectedListener = null,
		OnBrothersButtonPressedListener = null,
		OnCommanderButtonPressedListener = null,
		OnTentButtonPressedListener = null,
		OnModuleClosedListener = null,
		OnCampListener = null
	},
	function isVisible()
	{
		return this.m.Visible != null && this.m.Visible == true;
	}

	function isAnimating()
	{
		return this.m.Animating == true || this.m.MainDialogModule.isAnimating() || this.m.CommanderDialogModule.isAnimating();
	}

	function getMainDialogModule()
	{
		return this.m.MainDialogModule;
	}

	function getBarberDialogModule()
	{
		return this.m.BarberDialogModule;
	}

	function getCommanderDialogModule()
	{
		return this.m.CommanderDialogModule;
	}

	function getCraftingDialogModule()
	{
		return this.m.CraftingDialogModule;
	}

	function getEnchanterDialogModule()
	{
		return this.m.EnchanterDialogModule;
	}

	function getFletcherDialogModule()
	{
		return this.m.FletcherDialogModule;
	}

	function getHealerDialogModule()
	{
		return this.m.HealerDialogModule;
	}

	function getHunterDialogModule()
	{
		return this.m.HunterDialogModule;
	}

	function getPainterDialogModule()
	{
		return this.m.PainterDialogModule;
	}

	function getRepairDialogModule()
	{
		return this.m.RepairDialogModule;
	}

	function getRestDialogModule()
	{
		return this.m.RestDialogModule;
	}

	function getScoutDialogModule()
	{
		return this.m.ScoutDialogModule;
	}

	function getTrainingDialogModule()
	{
		return this.m.TrainingDialogModule;
	}

	function getGathererDialogModule()
	{
		return this.m.GathererDialogModule;
	}

	function getWorkshopDialogModule()
	{
		return this.m.WorkshopDialogModule;
	}

	function setOnConnectedListener( _listener )
	{
		this.m.OnConnectedListener = _listener;
	}

	function setOnDisconnectedListener( _listener )
	{
		this.m.OnDisconnectedListener = _listener;
	}

	function setOnBrothersPressedListener( _listener )
	{
		this.m.OnBrothersButtonPressedListener = _listener;
	}

	function setOnCommanderPressedListener( _listener )
	{
		this.m.OnCommanderButtonPressedListener = _listener;
	}

	function setOnTentPressedListener( _listener )
	{
		this.m.OnTentButtonPressedListener = _listener;
	}

	function setOnModuleClosedListener( _listener )
	{
		this.m.OnModuleClosedListener = _listener;
	}

	function setOnCampListener( _listener )
	{
		this.m.OnCampListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnConnectedListener = null;
		this.m.OnDisconnectedListener = null;
		this.m.OnBrothersButtonPressedListener = null;
		this.m.OnCommanderButtonPressedListener = null;
		this.m.OnTentButtonPressedListener = null;
		this.m.OnModuleClosedListener = null;
		this.m.OnCampListener = null;
	}

	function create()
	{
		this.m.Visible = false;
		this.m.Animating = false;
		this.m.JSHandle = this.UI.connect("CampScreen", this);
		this.m.MainDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_main_dialog_module");
		this.m.MainDialogModule.setParent(this);
		this.m.MainDialogModule.connectUI(this.m.JSHandle);
		this.m.CommanderDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_commander_dialog_module");
		this.m.CommanderDialogModule.setParent(this);
		this.m.CommanderDialogModule.connectUI(this.m.JSHandle);
		this.m.BarberDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_barber_dialog_module");
		this.m.BarberDialogModule.setParent(this);
		this.m.BarberDialogModule.connectUI(this.m.JSHandle);
		this.m.CraftingDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_crafting_dialog_module");
		this.m.CraftingDialogModule.setParent(this);
		this.m.CraftingDialogModule.connectUI(this.m.JSHandle);
		this.m.EnchanterDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_enchanter_dialog_module");
		this.m.EnchanterDialogModule.setParent(this);
		this.m.EnchanterDialogModule.connectUI(this.m.JSHandle);
		this.m.FletcherDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_fletcher_dialog_module");
		this.m.FletcherDialogModule.setParent(this);
		this.m.FletcherDialogModule.connectUI(this.m.JSHandle);
		this.m.HealerDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_healer_dialog_module");
		this.m.HealerDialogModule.setParent(this);
		this.m.HealerDialogModule.connectUI(this.m.JSHandle);
		this.m.HunterDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_hunter_dialog_module");
		this.m.HunterDialogModule.setParent(this);
		this.m.HunterDialogModule.connectUI(this.m.JSHandle);
		this.m.PainterDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_painter_dialog_module");
		this.m.PainterDialogModule.setParent(this);
		this.m.PainterDialogModule.connectUI(this.m.JSHandle);
		this.m.RepairDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_repair_dialog_module");
		this.m.RepairDialogModule.setParent(this);
		this.m.RepairDialogModule.connectUI(this.m.JSHandle);
		this.m.RestDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_rest_dialog_module");
		this.m.RestDialogModule.setParent(this);
		this.m.RestDialogModule.connectUI(this.m.JSHandle);
		this.m.ScoutDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_scout_dialog_module");
		this.m.ScoutDialogModule.setParent(this);
		this.m.ScoutDialogModule.connectUI(this.m.JSHandle);
		this.m.TrainingDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_training_dialog_module");
		this.m.TrainingDialogModule.setParent(this);
		this.m.TrainingDialogModule.connectUI(this.m.JSHandle);
		this.m.GathererDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_gatherer_dialog_module");
		this.m.GathererDialogModule.setParent(this);
		this.m.GathererDialogModule.connectUI(this.m.JSHandle);
		this.m.WorkshopDialogModule = this.new("scripts/ui/screens/world/modules/camp_screen/camp_workshop_dialog_module");
		this.m.WorkshopDialogModule.setParent(this);
		this.m.WorkshopDialogModule.connectUI(this.m.JSHandle);
	}

	function destroy()
	{
		this.clearEventListener();
		this.m.MainDialogModule.destroy();
		this.m.MainDialogModule = null;
		this.m.CommanderDialogModule.destroy();
		this.m.BarberDialogModule.destroy();
		this.m.CraftingDialogModule.destroy();
		this.m.EnchanterDialogModule.destroy();
		this.m.FletcherDialogModule.destroy();
		this.m.HealerDialogModule.destroy();
		this.m.HunterDialogModule.destroy();
		this.m.PainterDialogModule.destroy();
		this.m.RepairDialogModule.destroy();
		this.m.RestDialogModule.destroy();
		this.m.ScoutDialogModule.destroy();
		this.m.TrainingDialogModule.destroy();
		this.m.GathererDialogModule.destroy();
		this.m.WorkshopDialogModule.destroy();
		this.m.CommanderDialogModule = null;
		this.m.BarberDialogModule = null;
		this.m.CraftingDialogModule = null;
		this.m.EnchanterDialogModule = null;
		this.m.FletcherDialogModule = null;
		this.m.HealerDialogModule = null;
		this.m.HunterDialogModule = null;
		this.m.PainterDialogModule = null;
		this.m.RepairDialogModule = null;
		this.m.RestDialogModule = null;
		this.m.ScoutDialogModule = null;
		this.m.TrainingDialogModule = null;
		this.m.GathererDialogModule = null;
		this.m.WorkshopDialogModule = null;
		this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
	}

	function clear()
	{
		this.m.MainDialogModule.clear();
		this.m.CommanderDialogModule.clear();
		this.m.BarberDialogModule.clear();
		this.m.CraftingDialogModule.clear();
		this.m.EnchanterDialogModule.clear();
		this.m.FletcherDialogModule.clear();
		this.m.HealerDialogModule.clear();
		this.m.HunterDialogModule.clear();
		this.m.PainterDialogModule.clear();
		this.m.RepairDialogModule.clear();
		this.m.RestDialogModule.clear();
		this.m.ScoutDialogModule.clear();
		this.m.TrainingDialogModule.clear();
		this.m.GathererDialogModule.clear();
		this.m.WorkshopDialogModule.clear();
	}

	function show()
	{
		this.World.Camp.onEnter();
		if (this.m.JSHandle != null)
		{
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("show", this.queryCampInformation());
		}
	}

	function hide()
	{
		if (this.m.JSHandle != null)
		{
			this.m.LastActiveModule = null;
			this.m.JSHandle.asyncCall("hide", null);
			this.Tooltip.hide();
		}
	}

	function hideAllDialogs()
	{
		if (this.m.JSHandle != null)
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hideAllDialogs", null);
		}
	}

	function refresh()
	{
		if (this.m.JSHandle != null)
		{
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("refresh", this.queryCampInformation());
		}
	}

	function showLastReturnDialog()
	{
		this.m.LastActiveModule = this.m.returnModule;
		this.m.returnModule = null;
		this.showLastActiveDialog();
	}

	function showLastActiveDialog()
	{
		if (this.m.LastActiveModule == this.m.CommanderDialogModule)
		{
			this.showCommanderDialog();
		}
		else if (this.m.LastActiveModule == this.m.BarberDialogModule)
		{
			this.showBarberDialog();
		}
		else if (this.m.LastActiveModule == this.m.CraftingDialogModule)
		{
			this.showCraftingDialog();
		}
		else if (this.m.LastActiveModule == this.m.EnchanterDialogModule)
		{
			this.showEnchanterDialog();
		}
		else if (this.m.LastActiveModule == this.m.FletcherDialogModule)
		{
			this.showFletcherDialog();
		}
		else if (this.m.LastActiveModule == this.m.HealerDialogModule)
		{
			this.showHealerDialog();
		}
		else if (this.m.LastActiveModule == this.m.HunterDialogModule)
		{
			this.showHunterDialog();
		}
		else if (this.m.LastActiveModule == this.m.PainterDialogModule)
		{
			this.showPainterDialog();
		}
		else if (this.m.LastActiveModule == this.m.RepairDialogModule)
		{
			this.showRepairDialog();
		}
		else if (this.m.LastActiveModule == this.m.RestDialogModule)
		{
			this.showRestDialog();
		}
		else if (this.m.LastActiveModule == this.m.GathererDialogModule)
		{
			this.showGathererDialog();
		}
		else if (this.m.LastActiveModule == this.m.ScoutDialogModule)
		{
			this.showScoutDialog();
		}
		else if (this.m.LastActiveModule == this.m.TrainingDialogModule)
		{
			this.showTrainingDialog();
		}
		else if (this.m.LastActiveModule == this.m.WorkshopDialogModule)
		{
			this.showWorkshopDialog();
		}
		else
		{
			this.showMainDialog();
		}
	}

	function showMainDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showMainDialog", this.queryAssetsInformation());
		}
	}

	function showTentBuildingDialog( _id )
	{
		switch(_id)
		{
		case this.Const.World.CampBuildings.Commander:
			this.showCommanderDialog();
			break;

		case this.Const.World.CampBuildings.Barber:
			this.showBarberDialog();
			break;

		case this.Const.World.CampBuildings.Crafting:
			this.showCraftingDialog();
			break;

		case this.Const.World.CampBuildings.Enchanter:
			this.showEnchanterDialog();
			break;

		case this.Const.World.CampBuildings.Fletcher:
			this.showFletcherDialog();
			break;

		case this.Const.World.CampBuildings.Gatherer:
			this.showGathererDialog();
			break;

		case this.Const.World.CampBuildings.Healer:
			this.showHealerDialog();
			break;

		case this.Const.World.CampBuildings.Hunter:
			this.showHunterDialog();
			break;

		case this.Const.World.CampBuildings.Painter:
			this.showPainterDialog();
			break;

		case this.Const.World.CampBuildings.Repair:
			this.showRepairDialog();
			break;

		case this.Const.World.CampBuildings.Rest:
			this.showRestDialog();
			break;

		case this.Const.World.CampBuildings.Scout:
			this.showScoutDialog();
			break;

		case this.Const.World.CampBuildings.Training:
			this.showTrainingDialog();
			break;

		case this.Const.World.CampBuildings.Workshop:
			this.showWorkshopDialog();
			break;

		}
	}

	function showCommanderDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.CommanderDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showCommanderDialog", this.m.CommanderDialogModule.queryLoad());
		}
	}

	function showBarberDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.BarberDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showBarberDialog", this.m.BarberDialogModule.queryRosterInformation());
		}
	}

	function showCraftingDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.CraftingDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showCraftingDialog", this.m.CraftingDialogModule.onShow());
		}
	}

	function showEnchanterDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.EnchanterDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showEnchanterDialog", this.m.EnchanterDialogModule.onShow());
		}
	}

	function showFletcherDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.FletcherDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showFletcherDialog", this.m.FletcherDialogModule.queryLoad());
		}
	}

	function showHealerDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.HealerDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showHealerDialog", this.m.HealerDialogModule.onShow());
		}
	}

	function showHunterDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.HunterDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showHunterDialog", this.m.HunterDialogModule.queryLoad());
		}
	}

	function showPainterDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.PainterDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showPainterDialog", this.m.PainterDialogModule.queryRosterInformation());
		}
	}

	function showRepairDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.RepairDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showRepairDialog", this.m.RepairDialogModule.onShow());
		}
	}

	function showRestDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.RestDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showRestDialog", this.m.RestDialogModule.queryLoad());
		}
	}

	function showScoutDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.ScoutDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showScoutDialog", this.m.ScoutDialogModule.queryLoad());
		}
	}

	function showTrainingDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.TrainingDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showTrainingDialog", this.m.TrainingDialogModule.queryLoad());
		}
	}

	function showGathererDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.GathererDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showGathererDialog", this.m.GathererDialogModule.queryLoad());
		}
	}

	function showWorkshopDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.WorkshopDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showWorkshopDialog", this.m.WorkshopDialogModule.onShow());
		}
	}

	function updateContracts()
	{
		this.m.JSHandle.asyncCall("updateContracts", ::World.Camp.getUIContractInformation());
	}

	function updateAssets()
	{
		this.m.JSHandle.asyncCall("loadAssetData", this.queryAssetsInformation());
	}

	function onScreenConnected()
	{
		if (this.m.OnConnectedListener != null)
		{
			this.m.OnConnectedListener();
		}
	}

	function onScreenDisconnected()
	{
		if (this.m.OnDisconnectedListener != null)
		{
			this.m.OnDisconnectedListener();
		}
	}

	function onScreenShown()
	{
		this.m.Visible = true;
		this.m.Animating = false;
	}

	function onScreenHidden()
	{
		this.m.Visible = false;
		this.m.Animating = false;
	}

	function onScreenAnimating()
	{
		this.m.Animating = true;
	}

	function onBrothersButtonPressed()
	{
		if (this.m.OnBrothersButtonPressedListener != null)
		{
			this.m.OnBrothersButtonPressedListener();
		}
	}

	function onCommanderButtonPressed()
	{
		if (this.m.returnModule != null)
		{
			return false;
		}

		if (this.m.OnCommanderButtonPressedListener == null)
		{
			return false;
		}

		this.m.returnModule = this.m.LastActiveModule;
		this.m.OnCommanderButtonPressedListener();
		return true;
	}

	function onShowTentBuilding( _id )
	{
		if (this.m.returnModule != null)
		{
			return false;
		}

		if (this.m.OnTentButtonPressedListener == null)
		{
			return false;
		}

		this.m.returnModule = this.m.LastActiveModule;
		this.m.OnTentButtonPressedListener(_id);
		return true;
	}

	function onEncounterClicked (_data) {
		if (this.isAnimating())
			return;
		this.World.Camp.onEncounterClicked(_data, this);
	}

	function onModuleClosed()
	{
		if (this.m.OnModuleClosedListener != null)
		{
			this.m.OnModuleClosedListener();
		}
	}

	function onCampClosed()
	{
		if (this.m.OnCampListener != null)
		{
			this.m.OnCampListener();
		}
	}

	function onContractClicked( _data )
	{
		if (this.isAnimating())
			return;
		this.World.Contracts.showContractByID(_data);
	}

	function onSlotClicked( _data )
	{
		if (this.isAnimating())
		{
			return;
		}

		local building = this.World.Camp.getBuildingByID(_data);

		if (building == null)
		{
			return;
		}

		building.onClicked(this);
	}

	function getTimeRequired()
	{
		return "No camp tasks have been scheduled...";
	}

	function getUITerrain()
	{
		return this.World.Camp.getUITerrain();
	}

	function queryCampInformation()
	{
		return this.getUIInformation();
	}

	function queryAssetsInformation()
	{
		return this.UIDataHelper.convertAssetsInformationToUIData();
	}

	function getUIInformation()
	{
		local result = this.World.Camp.getUIInformation();
		result.Assets <- this.queryAssetsInformation();
		return result;
	}

};

