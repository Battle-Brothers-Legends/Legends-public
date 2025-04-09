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

	function onUpdateRoster()
	{
		for( local roster = this.getRoster(); roster.getSize() < 4;  )
		{
			local character = roster.create("scripts/entity/tactical/humans/noble");
			character.setFaction(this.m.ID);
			character.m.HairColors = this.Const.HairColors.Old;
			character.setAppearance();
			character.setTitle("von " + this.m.Name);
			character.assignRandomEquipment();
		}
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

