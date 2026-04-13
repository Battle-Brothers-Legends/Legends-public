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
		for (local faction = 0; faction < ::Legends.CampContracts.EmployerFaction.COUNT; faction++) {
			for (local roster = this.getRoster(); roster.getSize() < (faction + 1) * ::Legends.CampContracts.EmployersPerFaction;) {
				::Legends.CampContracts.EmployerFactory[faction](this.m.ID, roster);
			}
		}
	}

	function getRandomCharacter(_faction = null) {
		if (_faction == null)
			return this.faction.getRandomCharacter();
		local roster = ::World.getRoster(this.m.ID).getAll();
		local idx = ::Math.rand(_faction * ::Legends.CampContracts.EmployersPerFaction, _faction * ::Legends.CampContracts.EmployersPerFaction + ::Legends.CampContracts.EmployersPerFaction - 1);
		if (idx < roster.len())
			return roster[idx];
		return this.faction.getRandomCharacter();
	}

	function getBanner() {
		if (::World.Contracts.getActiveContract() != null && ::World.Contracts.getActiveContract().m.Flags.has("EmulateNobleFaction"))
			return ::World.FactionManager.getFaction(::World.Contracts.getActiveContract().m.Flags.getAsInt("EmulateNobleFaction")).getBanner();
		return this.faction.getBanner();
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

