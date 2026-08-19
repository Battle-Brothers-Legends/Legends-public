this.camp_manager <- {
	m = {
		IsCamping = false,
		IsEscorting = false,
		LastHourUpdated = 0,
		StartTime = 0,
		StopTime = 0,
		LastCampTime = 0,
		Tents = [],
		PresetNames = [
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false
		], // CAUTION: the length of this array is tightly coupled with mSaveSlotNum in camp_screen_commander_dialog_module.js
		StartedWhileEscorting = false,
		LastCampingUpdateText = [],
		CampEncountersCooldownUntil = 0.0,
		CampEncounters = [],
	},

	function create()
	{
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/commander_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/rest_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/healer_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/repair_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/workshop_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/crafting_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/scout_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/training_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/fletcher_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/gatherer_building"));
		//this.addBuilding(this.new("scripts/entity/world/camp/buildings/hunter_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/kitchen_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/enchanter_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/barber_building"));
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/painter_building")); //PaintingTent
	}

	function destroy()
	{
		foreach( b in this.m.Tents )
		{
			b.destroy();
		}

		this.m.Tents = [];
	}

	function clear()
	{
		this.m.Tents = [];
		this.m.CampEncountersCooldownUntil = 0.0;
		this.m.CampEncounters = [];
	}

	function init()
	{
		foreach( b in this.m.Tents )
		{
			if (this.m.IsCamping && b.Camping() || this.m.IsEscorting && b.Escorting())
			{
				b.init();
			}
		}
		this.m.StartedWhileEscorting = ::World.State.m.EscortedEntity != null;
	}

	function getBuildingByID( _id )
	{
		foreach( b in this.m.Tents )
		{
			if (b.getID() != _id)
			{
				continue;
			}

			return b;
		}

		return null;
	}

	function isCamping()
	{
		return this.m.IsCamping;
	}

	function getStopTime()
	{
		return this.m.StopTime;
	}

	function getElapsedTime()
	{
		return this.Time.getVirtualTimeF() - this.m.StartTime;
	}

	function getElapsedHours()
	{
		return (this.Time.getVirtualTimeF() - this.m.StartTime) / (::World.getTime().SecondsPerDay / 24);
	}

	function getCampTime()
	{
		return this.m.StopTime - this.m.StartTime;
	}

	function getCampTimeHours()
	{
		return this.getCampTime() / (::World.getTime().SecondsPerDay / 24);
	}

	function getHoursSinceLastCamp()
	{
		return (this.m.LastCampTime - this.m.StartTime) / (::World.getTime().SecondsPerDay / 24);
	}

	function getResults()
	{
		local biomeText = this.m.StartedWhileEscorting ? "while escorting" : ::Const.World.TerrainLocation[::World.State.getPlayer().getTile().Type];
		local L = [
			{
				id = 9000,
				icon = "ui/buttons/icon_time.png",
				text = "You were encamped for " + this.Math.floor(this.getElapsedHours()) + " hours " + biomeText + ".",
			}
		];

		foreach( b in this.m.Tents )
		{
			L.extend(b.getResults());
		}

		return L;
	}

	function getBuildings()
	{
		return this.m.Tents;
	}

	function onEscort( _val )
	{
		if (this.m.IsEscorting == _val)
		{
			return;
		}

		this.m.IsEscorting = _val;

		if (this.m.IsEscorting)
		{
			this.m.StartTime = this.Time.getVirtualTimeF();
			this.m.LastHourUpdated = ::World.getTime().Hours;
			this.init();
		}
		else
		{
			this.m.StopTime = this.Time.getVirtualTimeF();

			foreach( b in this.m.Tents )
			{
				if (b.Escorting())
				{
					b.completed();
				}
			}

			this.m.LastCampTime = this.m.StopTime;
			::World.State.getPlayer().updateStrength();
			::World.TopbarDayTimeModule.hideMessage();
		}
	}

	function onCamp()
	{
		this.m.IsCamping = !this.m.IsCamping;
		::World.State.getPlayer().setCamping(this.m.IsCamping);

		if (this.m.IsCamping)
		{
			this.m.StartTime = this.Time.getVirtualTimeF();
			this.m.LastHourUpdated = ::World.getTime().Hours;
			this.init();
		}
		else
		{
			this.m.StopTime = this.Time.getVirtualTimeF();

			foreach( b in this.m.Tents )
			{
				if (b.Camping())
				{
					b.completed();
				}
			}

			this.m.LastCampTime = this.m.StopTime;
			::World.Assets.consumeItems();
			::World.Assets.refillAmmo();
			::World.Assets.updateAchievements();
			::World.Assets.checkAmbitionItems();
			::World.State.getPlayer().updateStrength();
			::World.Events.fire("event.camp_completed");
		}
	}

	function onEnter () {
		this.updateEncounters();
		return true;
	}

	/**
	 * Callback function for UI, called on encounter icon click
	 */
	function onEncounterClicked (_i, _townScreen) {
		local selectedEncounter = this.m.CampEncounters.filter(@(_, _enc) _enc.isVisible())[_i];
		::World.Encounters.fireCampEncounter(selectedEncounter);
    	this.m.CampEncounters.remove(this.m.CampEncounters.find(selectedEncounter));
	}

	function assignRepairs()
	{
		this.getBuildingByID(::Legends.Camp.CampBuildings.Repair).assignEquipped();
	}

	function update( _worldState )
	{
		local escortEntity = ::World.State.getEscortedEntity();
    	local isCurrentlyEscorting = escortEntity != null && !escortEntity.isNull();
    	if (isCurrentlyEscorting != this.m.IsEscorting) {
        	this.onEscort(isCurrentlyEscorting);
    	}

		foreach( b in this.m.Tents )
		{
			if (this.m.IsCamping && b.Camping() || this.m.IsEscorting && b.Escorting())
			{
				b.updateTick(this.getElapsedHours());
			}
		}

		if (::World.getTime().Hours == this.m.LastHourUpdated)
		{
			return;
		}

		this.m.LastHourUpdated = ::World.getTime().Hours;
		local updates = this.getCampingUpdateText();


		if (this.m.IsEscorting)
		{
			::World.TopbarDayTimeModule.showMessage("ESCORTING", updates);
		}
		else if (this.m.IsCamping)
		{
			::World.TopbarDayTimeModule.showMessage("ENCAMPED", updates);
		}
		// else if (this.m.IsEscorting)
		// {
		// 	::World.TopbarDayTimeModule.showMessage("ESCORTING", updates);
		// }
	}

	function getCampingUpdateText()
	{
		local updates = [];
		local text;

		updates.push("----------------------------------");
		updates.push("Hours Encamped: " + this.Math.floor(this.getElapsedHours()));
		updates.push("----------------------------------");

		foreach( b in this.m.Tents )
		{
			if (this.m.IsCamping && b.Camping() || this.m.IsEscorting && b.Escorting())
			{
				text = b.update();

				if (text && typeof text == "string")
				{
					updates.push(text);
				}
				else if (text && typeof text == "array")
				{
					updates.extend(text);
				}
			}
		}

		this.m.LastCampingUpdateText = updates;
		return updates;
	}

	function getLastCampingUpdateText()
	{
		return this.m.LastCampingUpdateText;
	}

	function fireEvent( _eventID, _name )
	{
		local event = ::World.Events.getEvent(_eventID);

		if (event == null)
		{
			return;
		}

		event.setTownName(_name);

		if (::World.Events.canFireEvent(true))
		{
			::World.Events.fire(_eventID);
		}
		else
		{
			local me = this;
			this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _t )
			{
				me.fireEvent(_eventID, _name);
			}, null);
		}
	}

	function addBuilding( _building )
	{
		_building.setCamp(this);
		this.m.Tents.push(_building);
	}

	function saveAssignmentPreset( _presetNumber )
	{
		foreach(p in ::World.getPlayerRoster().getAll())
		{
			p.getFlags().set("camping_preset_" + _presetNumber, p.getCampAssignment());
		}
	}

	function loadAssignmentPreset( _presetNumber )
	{
		foreach(p in ::World.getPlayerRoster().getAll())
		{
			if(p.getFlags().has("camping_preset_" + _presetNumber))
			{
				p.setLastCampAssignment(p.getCampAssignment());
				p.setCampAssignment(p.getFlags().get("camping_preset_" + _presetNumber));
			}
		}
	}

	function setPresetName( _index, _presetName)
	{
		if(_index > this.m.PresetNames.len() + 1)
		{
			::Legends.Mod.Debug.printError(format("Index %i greater than length of m.PresetNames", _index));
		}
		this.m.PresetNames[_index] = _presetName;
	}

	function getPresetName( _index )
	{
		if(_index > this.m.PresetNames.len() + 1)
		{
			::Legends.Mod.Debug.printError(format("Index %i greater than length of m.PresetNames", _index));
		}
		return this.m.PresetNames[_index];
	}

	/**
	 * Updates encounters in the camp.
	 */
	function updateEncounters () {
		/*if (this.m.CampEncountersCooldownUntil > this.Time.getVirtualTimeF()) {
			local notValid = [];
			foreach (i, e in this.m.CampEncounters) {
				if (i > 0 && !e.isValid(this))
					notValid.push(e);
			}
			foreach (e in notValid) {
				::MSU.Array.removeByValue(this.m.CampEncounters, e);
			}
			return;
		}*/

		local list = [::World.Encounters.m.CampEncounters[0]];
		foreach (e in ::World.Encounters.m.CampEncounters) {
			if (e.isValid(this) && e.isVisible()) {
				list.push(e);
			}
		}

		local count = this.Math.rand(::Legends.Encounters.CampMin, ::Legends.Encounters.CampMax);
		while(list.len() > count + 1) {
			local r = this.Math.rand(1, list.len() - 1);
			list.remove(r);
		}
		this.m.CampEncounters.clear();
		foreach (e in list) {
			this.m.CampEncounters.push(e);
		}
		//this.m.CampEncountersCooldownUntil = this.Time.getVirtualTimeF() + (::Legends.Encounters.CampCooldown * ::World.getTime().SecondsPerDay);
	}

	function getContracts() {
		local contracts = [];
		foreach(c in ::World.FactionManager.getFactionOfType(::Const.FactionType.FreeCompany).getContracts()) {
			if (c.isVisible())
				contracts.push(c);
		}
		return contracts;
	}

	function hasContract( _id ) {
		local contracts = this.getContracts();
		foreach(c in contracts) {
			if (c.getType() == _id)
				return true;
		}
		return false;
	}

	function getUIContractInformation() {
		local result = {
			Contracts = [],
			IsContractActive = ::World.Contracts.getActiveContract() != null,
			IsContractsLocked = false
		};
		local contracts = this.getContracts();

		foreach( i, contract in contracts ) {
			if (i > 9)
				break;

			if (contract.isActive())
				continue;

			local c = {
				Icon = contract.getBanner(),
				ID = contract.getID(),
				IsNegotiated = contract.isNegotiated(),
				DifficultyIcon = contract.getUIDifficultySmall()
			};
			result.Contracts.push(c);
		}
		return result;
	}

	function getUITerrain () {
		local tile = ::World.State.getPlayer().getTile();
		local terrain = [];
		terrain.resize(::Const.World.TerrainType.COUNT, 0);

		terrain[tile.Type] += 2;

		for(local i = 0; i < 6; i++) {
			if (tile.hasNextTile(i))
				++terrain[tile.getNextTile(i).Type];
		}

		terrain[::Const.World.TerrainType.Plains] = this.Math.max(0, terrain[::Const.World.TerrainType.Plains] - 2);

		if (terrain[::Const.World.TerrainType.Hills] > 0 || terrain[::Const.World.TerrainType.Mountains] > 0) {
			if (terrain[::Const.World.TerrainType.Steppe] > 0) {
				terrain[::Const.World.TerrainType.Steppe] += 2;
			}
			if (terrain[::Const.World.TerrainType.Snow] > 0) {
				terrain[::Const.World.TerrainType.Snow] += 2;
			}
		}

		local highest = tile.Type;

		if (highest == ::Const.World.TerrainType.Ocean || highest == ::Const.World.TerrainType.Shore) {
			highest = ::Const.World.TerrainType.Plains;
		}

		for(local i = 0; i < ::Const.World.TerrainType.COUNT; i++) {
			if (i != ::Const.World.TerrainType.Ocean && i != ::Const.World.TerrainType.Shore && terrain[i] > terrain[highest]) {
				highest = i;
			}
		}
		return highest;
	}

	function getUIInformation () {
		local night = !::World.getTime().IsDaytime;
		local highest = this.getUITerrain();
		local terrain = ::Legends.Camp.TerrainCampImages[highest];
		local background = terrain.Background;
		local foreground = terrain.Foreground;
		local mood = terrain.Mood;
		local result = {
			Title = ::World.Assets.getName() + " Camp",
			SubTitle = "Give various camp tasks to your mercenaries while taking a break from marching.",
			HeaderImagePath = null,
			Background = background != null ? background + (night ? "_night" : "") + ".jpg" : null,
			Mood = mood != null ? mood + ".png" : null,
			Foreground = foreground != null ? foreground + (night ? "_night" : "") + ".png" : null,
			Slots = [],
			Situations = [],
			Contracts = [],
			IsContractActive = ::World.Contracts.getActiveContract() != null,
			IsContractsLocked = false,
		};

		foreach (building in this.getBuildings()) {
			if (building == null || building.isHidden()) {
				result.Slots.push(null);
				continue;
			}

			local b = {
				Image = building.getUIImage(::Legends.Camp.TerrainCampImages[highest].BuildingVariant),
				Tooltip = building.getTooltipID(),
				Slot = building.getSlot(),
				CanEnter = building.canEnter()
			};
			result.Slots.push(b);
		}

		local isEscorting = ::World.State.m.EscortedEntity != null && !::World.State.m.EscortedEntity.isNull();
		if (!isEscorting) {
			result.Encounters <- [];
			local visibleEncounters = this.m.CampEncounters.filter(@(_,_enc) (_enc != null && _enc.isVisible()));
			foreach(encounter in visibleEncounters) {
				result.Encounters.push({
					Icon = encounter.m.Icon,
					Type = encounter.getType(),
				});
			}
		}

		local contractUI = this.getUIContractInformation();
		foreach(contract in contractUI.Contracts)
			result.Contracts.push(contract);

		return result;
	}

	function onSerialize( _out )
	{
		_out.writeBool(this.m.IsCamping);
		_out.writeU8(this.m.LastHourUpdated);
		_out.writeF32(this.m.StartTime);
		_out.writeF32(this.m.LastCampTime);
		_out.writeU8(this.m.Tents.len());

		foreach( building in this.m.Tents )
		{
			if (building == null)
			{
				_out.writeI32(0);
			}
			else
			{
				_out.writeI32(building.ClassNameHash);
				building.onSerialize(_out);
			}
		}

		::MSU.Serialization.serialize(this.m.PresetNames, _out);
		// serialize encounters
		_out.writeF32(this.m.CampEncountersCooldownUntil);
		foreach(_, e in this.m.CampEncounters) {
			if (e.isValid(this)) {
				_out.writeBool(true);
				_out.writeString(e.getType());
			}
		}
		_out.writeBool(false);
	}

	function onDeserialize( _in )
	{
		this.m.IsCamping = _in.readBool();
		this.m.LastHourUpdated = _in.readU8();
		this.m.StartTime = _in.readF32();
		this.m.LastCampTime = _in.readF32();
		this.m.Tents = [];
		local numBuildings = _in.readU8();

		for( local i = 0; i < numBuildings; ++i )
		{
			local id = _in.readI32();
			if (id != 0)
			{
				local b = this.new(this.IO.scriptFilenameByHash(id));
				b.setCamp(this);
				b.onDeserialize(_in);
				this.m.Tents.push(b);
			}
		}
		this.m.PresetNames = ::MSU.Serialization.deserialize(_in);
		this.m.CampEncountersCooldownUntil = _in.readF32();
		this.m.CampEncounters.push(::World.Encounters.m.CampEncounters[0]);
		while(_in.readBool()) {
			local e = ::World.Encounters.getEncounter(_in.readString());
			if (e != null) {
				this.m.CampEncounters.push(e);
			}
		}
	}

};

