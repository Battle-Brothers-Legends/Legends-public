this.legend_free_company_faction <- this.inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = ::Const.FactionType.FreeCompany;
		this.m.Base = "world_base_09";
		this.m.TacticalBase = "bust_base_military";
		this.m.CombatMusic = ::Const.Music.NobleTracks;
		this.m.PlayerRelation = 0.0;
		this.m.IsHidden = true;
		this.m.IsRelationDecaying = false;
	}

	function isReadyForContract() {
		return this.m.Contracts.len() < 3 && (this.m.LastContractTime == 0 || this.Time.getVirtualTimeF() > this.m.LastContractTime + ::World.getTime().SecondsPerDay * 4.0)
	}

	function onUpdateRoster() {
		// note, that only champions have names
		for (local roster = this.getRoster(); roster.getSize() < 4;) {
			local character = roster.create("scripts/entity/tactical/humans/barbarian_champion");
			character.setFaction(this.m.ID);
			character.m.HairColors = ::Const.HairColors.Young;
			character.setAppearance();
			character.assignRandomEquipment();
			local unit = ::Const.World.Spawn.Troops.BarbarianChampion;
			character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
		}
		for (local roster = this.getRoster(); roster.getSize() < 8;) {
			local character = roster.create("scripts/entity/tactical/enemies/bandit_leader");
			character.setFaction(this.m.ID);
			character.m.HairColors = ::Const.HairColors.Young;
			character.setAppearance();
			character.assignRandomEquipment();
			local unit = ::Const.World.Spawn.Troops.BanditLeader;
			character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
		}
		for (local roster = this.getRoster(); roster.getSize() < 12;) {
			local character = roster.create("scripts/entity/tactical/enemies/necromancer");
			character.setFaction(this.m.ID);
			character.m.HairColors = this.Const.HairColors.Old;
			character.setAppearance();
			character.assignRandomEquipment();
			local unit = ::Const.World.Spawn.Troops.Necromancer;
			character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
		}
	}

	function getRandomCharacter (_faction = null) {
		if (_faction == null)
			return this.faction.getRandomCharacter();
		local roster = ::World.getRoster(this.m.ID).getAll();
		if (_faction == ::Legends.CampContracts.EmployerFaction.Barbarians)
			return roster[::Math.rand(0, 3)];
		if (_faction == ::Legends.CampContracts.EmployerFaction.Bandits)
			return roster[::Math.rand(4, 7)];
		if (_faction == ::Legends.CampContracts.EmployerFaction.Necromancers)
			return roster[::Math.rand(8, 11)];
		return this.faction.getRandomCharacter();
	}

	function addPlayerRelation( _r, _reason = "" )
	{
	}

	function addPlayerRelationEx( _r, _reason = "" )
	{
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
	}

});

