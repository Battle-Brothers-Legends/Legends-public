this.legend_camp_legion_defend_cemetery_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create() {
		this.m.ID = "legend_camp_legion_defend_cemetery_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = false;
		this.m.IsRunOnNewCampaign = true;
		this.faction_action.create();
	}

	function onUpdate(_faction) {
		if (!::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legend_risen_legion"))
			return;

		if (::World.State.getRegions().len() == 0)
			return;

		if (_faction.getType() != ::Const.FactionType.FreeCompany)
			return;

		if (!_faction.isReadyForContract())
			return;

		local playerTile = ::World.State.getPlayer().getTile();
		local locations = ::World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getSettlements()
			.filter(@(_, _loc) ::Legends.S.oneOf(_loc.getTypeID(), "location.undead_graveyard", "location.undead_crypt"));
		if (locations.len() == 0)
			return;

		this.m.Score = 1;
	}

	function onClear() {
	}

	function onExecute(_faction) {
		if (_faction.getType() != ::Const.FactionType.FreeCompany)
			return;
		local contract = ::new("scripts/contracts/contracts/legend_camp_legion_defend_cemetery_contract");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter(contract.m.EmployerFaction).getID());
		::World.Contracts.addContract(contract);
	}
});
