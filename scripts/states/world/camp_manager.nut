this.camp_manager <- {
	m = {
		IsCamping = false,
		IsEscorting = false,
		LastHourUpdated = 0,
		StartTime = 0,
		StopTime = 0,
		LastCampTime = 0,
		lasttick = 0.0,
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
		this.addBuilding(this.new("scripts/entity/world/camp/buildings/hunter_building"));
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
		return (this.Time.getVirtualTimeF() - this.m.StartTime) / (this.World.getTime().SecondsPerDay / 24);
	}

	function getCampTime()
	{
		return this.m.StopTime - this.m.StartTime;
	}

	function getCampTimeHours()
	{
		return this.getCampTime() / (this.World.getTime().SecondsPerDay / 24);
	}

	function getHoursSinceLastCamp()
	{
		return (this.m.LastCampTime - this.m.StartTime) / (this.World.getTime().SecondsPerDay / 24);
	}

	function getResults()
	{
		local biomeText = this.m.StartedWhileEscorting ? "while escorting" : ::Const.World.TerrainLocation[::World.State.getPlayer().getTile().Type]
		local L = [
			{
				id = 9000,
				icon = "ui/buttons/icon_time.png",
				text = "You were encamped for " + this.Math.floor(this.getElapsedHours()) + " hours " + biomeText,
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
			this.m.LastHourUpdated = this.World.getTime().Hours;
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
			this.World.State.getPlayer().updateStrength();
			this.World.TopbarDayTimeModule.hideMessage();
		}
	}

	function onCamp()
	{
		this.m.IsCamping = !this.m.IsCamping;
		this.World.State.getPlayer().setCamping(this.m.IsCamping);

		if (this.m.IsCamping)
		{
			this.m.StartTime = this.Time.getVirtualTimeF();
			this.m.LastHourUpdated = this.World.getTime().Hours;
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
			this.World.Assets.consumeItems();
			this.World.Assets.refillAmmo();
			this.World.Assets.updateAchievements();
			this.World.Assets.checkAmbitionItems();
			this.World.State.getPlayer().updateStrength();
			this.World.Events.fire("event.camp_completed");
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
		this.World.Encounters.fireCampEncounter(this.m.CampEncounters[_i]);
		if (_i > 0) { // 1st are tips, don't remove them
			this.m.CampEncounters.remove(_i);
		}
	}

	function assignRepairs()
	{
		this.getBuildingByID(this.Const.World.CampBuildings.Repair).assignEquipped();
	}

	function update( _worldState )
	{
		foreach( b in this.m.Tents )
		{
			if (this.m.IsCamping && b.Camping() || this.m.IsEscorting && b.Escorting())
			{
				b.updateTick(this.getElapsedHours());
			}
		}

		if (this.World.getTime().Hours == this.m.LastHourUpdated)
		{
			return;
		}

		this.m.LastHourUpdated = this.World.getTime().Hours;
		local updates = this.getCampingUpdateText();


		if (this.m.IsEscorting)
		{
			this.World.TopbarDayTimeModule.showMessage("ESCORTING", updates);
		}
		else if (this.m.IsCamping)
		{
			this.World.TopbarDayTimeModule.showMessage("ENCAMPED", updates);
		}
		// else if (this.m.IsEscorting)
		// {
		// 	this.World.TopbarDayTimeModule.showMessage("ESCORTING", updates);
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
		local event = this.World.Events.getEvent(_eventID);

		if (event == null)
		{
			return;
		}

		event.setTownName(_name);

		if (this.World.Events.canFireEvent(true))
		{
			this.World.Events.fire(_eventID);
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
		if (this.m.CampEncountersCooldownUntil > this.Time.getVirtualTimeF()) {
			local notValid = [];
			foreach (i, e in this.m.CampEncounters) {
				if (i > 0 && !e.isValid(this))
					notValid.push(e);
			}
			foreach (e in notValid) {
//				::logInfo("encounter became non valid " + e.getType());
				::MSU.Array.removeByValue(this.m.CampEncounters, e);
			}
//			::logInfo("cooldown still on, skipping the creation");
			return;
		}

		local list = [this.World.Encounters.m.CampEncounters[0]];
		foreach (e in this.World.Encounters.m.CampEncounters) {
			if (e.isValid(this)) {
				list.push(e);
			}
		}

		local count = this.Math.rand(3, 5);
		while(list.len() > count + 1) {
			local r = this.Math.rand(1, list.len() - 1);
			list.remove(r);
		}
		this.m.CampEncounters.clear();
		foreach (e in list) {
			this.m.CampEncounters.push(e);
		}
		this.m.CampEncountersCooldownUntil = this.Time.getVirtualTimeF() + (5 * this.World.getTime().SecondsPerDay);
	}

	function getUITerrain () {
		local tile = this.World.State.getPlayer().getTile();
		local terrain = [];
		terrain.resize(this.Const.World.TerrainType.COUNT, 0);

		for(local i = 0; i < 6; i++) {
			if (tile.hasNextTile(i))
				++terrain[tile.getNextTile(i).Type];
		}

		terrain[this.Const.World.TerrainType.Plains] = this.Math.max(0, terrain[this.Const.World.TerrainType.Plains] - 1);

		if (terrain[this.Const.World.TerrainType.Steppe] != 0 && this.Math.abs(terrain[this.Const.World.TerrainType.Steppe] - terrain[this.Const.World.TerrainType.Hills]) <= 2)
			terrain[this.Const.World.TerrainType.Steppe] += 2;

		if (terrain[this.Const.World.TerrainType.Snow] != 0 && this.Math.abs(terrain[this.Const.World.TerrainType.Snow] - terrain[this.Const.World.TerrainType.Hills]) <= 2)
			terrain[this.Const.World.TerrainType.Snow] += 2;

		local highest = 0;

		for(local i = 0; i < this.Const.World.TerrainType.COUNT; i++)
		{
			if (i == this.Const.World.TerrainType.Ocean || i == this.Const.World.TerrainType.Shore)
			{
			}
			else if (terrain[i] >= terrain[highest])
			{
				highest = i;
			}
		}
		return highest;
	}

	function getUIInformation () {
		local night = !this.World.getTime().IsDaytime;
		local highest = this.getUITerrain();
		local foreground = this.Const.World.TerrainCampImages[highest].Foreground;
		local result = {
			Title = this.World.Assets.getName() + " Camp",
			SubTitle = "No camp tasks have been scheduled...",
			HeaderImagePath = null,
			Background = this.Const.World.TerrainCampImages[highest].Background + (night ? "_night" : "") + ".jpg",
			Mood = this.Const.World.TerrainCampImages[highest].Mood + ".png",
			Foreground = foreground != null ? foreground + (night ? "_night" : "") + ".png" : null,
				Slots = [],
				Situations = []
		};
		foreach (building in this.getBuildings())
		{
			if (building == null || building.isHidden())
			{
				result.Slots.push(null);
				continue;
			}

			local image = null;

			// how about consts here? magic numbers are bad practice
			if (highest == 4 || highest == 8 || highest == 9) {
				image = building.getUIImage(highest);
			} else {
				image = building.getUIImage(0);
			}

			local b = {
				Image = image,
				Tooltip = building.getTooltipID(),
				Slot = building.getSlot(),
				CanEnter = building.canEnter()
			};
			result.Slots.push(b);
		}

		local isEscorting = this.World.State.m.EscortedEntity != null && !this.World.State.m.EscortedEntity.isNull();
		if (!isEscorting) {
			result.Encounters <- [];
			foreach(encounter in this.m.CampEncounters) {
				if (encounter != null) {
					result.Encounters.push({
						Icon = encounter.m.Icon,
						Type = encounter.getType(),
					});
				}
			}
		}
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

		//_out.writeBool(false);
		::MSU.Utils.serialize(this.m.PresetNames, _out);
		// serialize encounters
		_out.writeF32(this.m.CampEncountersCooldownUntil);
		_out.writeU32(this.m.CampEncounters.len());
		foreach(e in this.m.CampEncounters) {
			_out.writeString(e.getType());
			e.onSerialize(_out)
		}
	}

	function onDeserialize( _in )
	{
		this.m.IsCamping = _in.readBool();
		this.m.LastHourUpdated = _in.readU8();
		this.m.StartTime = _in.readF32();
		this.m.LastCampTime = _in.readF32();

		if (_in.getMetaData().getVersion() >= 52)
		{
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

			if (_in.getMetaData().getVersion() < 65)
			{
				this.addBuilding(this.new("scripts/entity/world/camp/buildings/painter_building"));
			}
		}

		//_in.readBool();

		if (::Legends.Mod.Serialization.isSavedVersionAtLeast("17.1.0", _in.getMetaData()))
		{
			this.m.PresetNames = ::MSU.Utils.deserialize(_in);
		}

		if (::Legends.Mod.Serialization.isSavedVersionAtLeast("19.1.0", _in.getMetaData())) {
			this.m.CampEncountersCooldownUntil = _in.readF32();
			local size = _in.readU32();
			for(local i = 0; i < size; i++) {
				local e = this.World.Encounters.getEncounter(_in.readString());
				if (e != null) {
					this.m.CampEncounters.push(e);
				} else {
					_in.readF32(); // same as in encounter
				}
			}
		}
	}

};

