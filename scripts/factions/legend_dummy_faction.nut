this.legend_dummy_faction <- this.inherit("scripts/factions/faction", {
	m = {
		MimicID = ::Const.Faction.None, // the ID of the Faction that the dummy faction is mimicking
	},
	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.DummyFaction;
		// this.setMimicValues(::Const.Faction.None);
		this.m.PlayerRelation = -200.0; // Always enemy by default
		this.m.IsHidden = true;
		this.m.IsRelationDecaying = false;
	}

	// Sets the type, base, tacticalbase, and combatmusic
	function setMimicValues( _factionID, _forceReset = true )
	{
		if (_factionID == null)
		{
			return;
		}

		if (_factionID != ::Const.Faction.None && _factionID != this.getMimicID() && this.getMimicID() != ::Const.Faction.None)
		{
			::logWarning("Attempting to set Dummy Faction to mimic faction with ID = [" + _factionID + "] when it is still mimicking faction with ID = [" + this.getMimicID() + "]");
			if (_forceReset)
			{
				this.reset(); // preemptive clean up if are mimicking a new faction while still mimicking another faction
			}
		}

		if (_factionID == this.getID())
		{
			::logError("Attempted to set Dummy Faction to mimic itself");
			return;
		}

		if (_factionID == ::Const.Faction.None)
		{
			this.m.MimicID = ::Const.Faction.None;
			this.m.Base = "";
			this.m.TacticalBase = "";
			this.m.CombatMusic = [];
			this.m.BannerPrefix = "";
			this.m.Banner = 1;
			return;
		}
		else if (::MSU.isNull(::World.FactionManager.getFaction(_factionID)))
		{
			::logWarning("Attempted to set Dummy Faction to mimic empty faction with ID = [" + _factionID + "]");
			return;
		}
		else
		{
			::Legends.Mod.Debug.printLog("Setting Dummy Faction to mimic faction with ID = [" + _factionID + "]");
			local faction = ::World.FactionManager.getFaction(_factionID);
			this.m.MimicID = _factionID;
			this.m.Base = faction.m.Base;
			this.m.TacticalBase = faction.m.TacticalBase;
			this.m.CombatMusic = clone faction.m.CombatMusic;
			this.m.BannerPrefix = faction.m.BannerPrefix;
			this.m.Banner = faction.m.Banner;
			return;
		}

		// this.m.MimicID = _faction.getID();
		// local factionType = _faction.getType();
		// switch ( factionType )
		// {
		// 	case this.Const.FactionType.None:
		// 		return
		// 	case this.Const.FactionType.OrientalBandits:
		// 		this.m.Base = "world_base_07";
		// 		this.m.TacticalBase = "bust_base_nomads";
		// 		this.m.CombatMusic = this.Const.Music.OrientalBanditTracks;
		// 		return
		// }
	}

	function getMimicID()
	{
		return this.m.MimicID;
	}

	// Transfers all units to the faction that is being mimicked
	function reset()
	{
		local faction = ::World.FactionManager.getFaction(this.getMimicID());

		if (!::MSU.isNull(faction))
		{
			local units = clone this.getUnits();
			foreach (i, u in units)
			{
				// WARNING: if dummy faction is not consistently reset before use, 
				// you may end up with units from mimicking different factions all being transferred to the currently mimicked faction
				faction.addUnit(u);
				this.removeUnit(u);
			}
		}

		// Reset dummy faction to none
		this.setMimicValues(::Const.Faction.None);
	}

	function addPlayerRelation( _r, _reason = "" )
	{
	}

	function addPlayerRelationEx( _r, _reason = "" )
	{
	}

	// // Do not believe this should be used
	// function setFakeType( _factionType )
	// {
	// 	this.m.Type = _factionType
	// }

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
		_out.writeU8(this.m.MimicID);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
		this.m.MimicID = _in.readU8();
		// this.setMimicValues(::World.FactionManager.getFaction(this.m.MimicID)); // perform this at the end of FactionManager onDeserialize to make sure all other factions are ready
	}

});

