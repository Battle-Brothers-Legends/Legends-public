this.camp_commander_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Title = "Commanders Tent",
		Description = "Left click or drag assigns a Primary task, right click or drag a Secondary task.",
		PopupDialogVisible = false,
		CurrentTent = null,
		RightClickedTent = null
	},

	function create() {
		this.m.ID = "CampCommanderDialogModule";
		this.ui_module.create();
	}

	function isAnimating() {
		if (this.m.Animating == null) {
			return false;
		}

		return this.m.Animating == true || this.m.PopupDialogVisible == true;
	}

	function destroy() {
		this.ui_module.destroy();
	}

	function onModuleShown() {
		this.ui_module.onModuleShown();
		this.m.PopupDialogVisible = false;
	}

	function onModuleHidden() {
		this.ui_module.onModuleHidden();
		this.m.PopupDialogVisible = false;
		this.m.CurrentTent = null;
	}

	function onPopupDialogIsVisible(_isVisible) {
		this.m.PopupDialogVisible = _isVisible;
	}

	function queryLoad() {
		local result = {
			Title = this.m.Title,
			SubTitle = this.m.Description,
			brothers = this.queryRosterInformation(),
			buildings = this.onQueryBuildingsList(),
			Assets = this.m.Parent.queryAssetsInformation(),
			SelectedID = this.m.RightClickedTent
		};
		this.m.RightClickedTent = null;
		return result;
	}

	function queryRosterInformation() {
		local brothers = ::World.getPlayerRoster().getAll();
		local roster = [];

		foreach (b in brothers) {
			local background = b.getBackground();
			local tent = ::World.Camp.getBuildingByID(b.getPrimaryCampAssignment());

			local injuries = [];
			local allInjuries = b.getSkills().query(::Const.SkillType.TemporaryInjury);

			for (local i = 0; i < allInjuries.len(); i++) {
				local inj = allInjuries[i];
				if (!inj.isTreated()) {
					injuries.push({
						id = inj.getID(),
						icon = inj.getIconColored(),
						name = inj.getNameOnly(),
						price = inj.getCost(),
						treatable = inj.isTreatable() && inj.getQueue() == 0,
						points = inj.getPoints()
					});
				}
			}

			local skills = [];
			if (b.getSkills().hasEffect(::Legends.Effect.Trained)) {
				local _skill = ::Legends.Effects.get(b, ::Legends.Effect.Trained);
				skills.push({
					id = _skill.getID(),
					icon = "skills/status_effect_75.png"
				});
			}

			local e = {
				ID = b.getID(),
				Name = b.getName(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				CampAssignment = b.getPrimaryCampAssignment(),
				CampBanner = tent.getBanner(),
				Injuries = injuries,
				Skills = skills
			};
			roster.push(e);
		}

		return roster;
	}

	function onQueryBrothersList() {
		local roster = ::World.Assets.getFormation();

		for (local i = 0; i != roster.len(); i = ++i) {
			if (roster[i] != null) {
				roster[i] = ::UIDataHelper.convertEntityToUIData(roster[i], null);
			}
		}

		return roster;
	}

	function onQueryBuildingsList() {
		local result = [];
		foreach (b in ::World.Camp.getBuildings().filter(@(_, _building) (_building != null && _building.inCommanderTent()))) {
			result.push({
				id = b.getID(),
				name = b.getName(),
				count = b.getNumberAssignedAs(false),
				secondaryCount = b.getNumberAssignedAs(true),
				bannerImage = b.getBanner(),
				resourceImage = b.getResourceImage(),
				resourceCount = b.getResourceCount()
			});
		}

		return result;
	}

	function onTentSelected(_id) {
		this.m.CurrentTent = ::World.Camp.getBuildingByID(_id);
		::World.Camp.updateAssignments();
		return {
			Roster = this.m.CurrentTent.getSortedRoster(),
			Label = this.m.CurrentTent.getName(),
			Enabled = this.m.CurrentTent.canEnter(),
			Configure = this.m.CurrentTent.hasPopup(),
			Modifiers = this.m.CurrentTent.getModifiers(),
			Info = this.m.CurrentTent.getInfo(),
		}
	}

	function onBroAssigned(_data) {
		local bro = ::Tactical.getEntityByID(_data[0]);
		if (!(_data[3] ? this.assignSecondary(bro, _data[1], !_data[2]) : this.assignPrimary(bro, _data[1], !_data[2]))) {
			return;
		}
		::World.Camp.updateAssignments();
		::Sound.play("sounds/movement/movement_snow_00.wav", 1.0);
		return this.queryLoad();
	}

	function onAssignedAll(_campID) {
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			this.assignPrimary(bro, _campID, false);
		}

		::World.Camp.updateAssignments();
		::Sound.play("sounds/movement/movement_snow_00.wav", 1.0);
		return this.queryLoad();
	}

	function assignPrimary(_bro, _campID, _canToggle) {
		local current = _bro.getPrimaryCampAssignment();
		if (current == _campID) {
			if (!_canToggle) {
				return false;
			}
			_campID = _bro.getLastCampAssignment();
		}
		if (!::World.Camp.getBuildingByID(_campID).onBroEnter(_bro)) {
			return false;
		}
		::World.Camp.getBuildingByID(current).onBroLeave(_bro);
		// the two tasks swap when the Secondary one is made the Primary
		if (_bro.getSecondaryCampAssignment() == _campID) {
			_bro.setSecondaryCampAssignment(current);
		}
		_bro.setLastCampAssignment(current);
		_bro.setCampAssignment(_campID);
		return true;
	}

	function assignSecondary(_bro, _campID, _canToggle) {
		if (_bro.getSecondaryCampAssignment() == _campID) {
			if (_canToggle) {
				_bro.setSecondaryCampAssignment(null);
			}
			return _canToggle;
		}
		if (_bro.getPrimaryCampAssignment() == _campID || !::World.Camp.getBuildingByID(_campID).onBroEnter(_bro)) {
			return false;
		}
		_bro.setSecondaryCampAssignment(_campID);
		return true;
	}

	function onSavePresetName(_data) {
		local index = _data[0];
		local presetName = _data[1];
		::Legends.Mod.Debug.printLog(format("Saving camping preset %i name: %s", index + 1, presetName));
		::World.Camp.setPresetName(index, presetName);
		::Sound.play("sounds/scribble.wav", 1.0);
	}

	function onDeletePresetName(_index) {
		::Legends.Mod.Debug.printLog(format("Deleting camping preset %i name", _index + 1));
		::World.Camp.setPresetName(_index, false);
		::Sound.play("sounds/movement/movement_stone_01.wav", 0.5);
	}

	function onSaveAssignmentPreset(_presetNumber) {
		::Legends.Mod.Debug.printLog("Saving camping assignments preset: " + _presetNumber);
		::World.Camp.saveAssignmentPreset(_presetNumber);
		::Sound.play("sounds/scribble.wav", 1.0);
	}

	function onLoadAssignmentPreset(_presetNumber) {
		::Legends.Mod.Debug.printLog("Loading camping assignments preset: " + _presetNumber);
		::World.Camp.loadAssignmentPreset(_presetNumber);
		::Sound.play("sounds/movement/movement_snow_00.wav", 1.0);

		return this.queryLoad();
	}

	function onSaveSlotButtonPressed(_presetNumber) {
		::Legends.Mod.Debug.printLog("Currently selected camping assignment preset slot: " + _presetNumber);
		if (::Legends.Mod.ModSettings.getSetting("ClickPresetToSwitch").getValue()) {
			::World.Camp.loadAssignmentPreset(_presetNumber);
			::Sound.play("sounds/movement/movement_snow_00.wav", 1.0);
			return this.queryLoad();
		}
		::Sound.play("sounds/move_pot_clay_01.wav", 2.0);
		return false;
	}

	function onLeaveButtonPressed() {
		this.m.Parent.onModuleClosed();
	}

	function onTentBuildingClicked(_id) {
		this.m.Parent.onShowTentBuilding(_id);
	}

	function onPopupButtonClicked(_data) {
		if (this.m.CurrentTent == null) {
			return;
		}

		this.m.CurrentTent.onPopupButtonClicked(_data);
	}

	function onConfigureButtonClicked(_id) {
		if (this.m.CurrentTent == null || this.m.CurrentTent.getID() != _id || this.m.JSHandle == null || !this.isVisible()) {
			return;
		}

		foreach (camp, i in ::Legends.Camp.CampBuildings) {
			if (i != _id) {
				continue;
			}

			::Tooltip.hide();
			this.m.JSHandle.asyncCall("show" + camp + "PopupDialog", this.m.CurrentTent.queryConfigureSettings());
		}

		::Sound.play("sounds/move_pot_clay_01.wav", 2.0);
	}
});
