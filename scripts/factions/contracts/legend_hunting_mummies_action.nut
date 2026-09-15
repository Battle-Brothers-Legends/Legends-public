this.legend_hunting_mummies_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_hunting_mummies_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!::Const.DLC.Desert)
		{
			return;
		}

		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (::World.Assets.getBusinessReputation() < 800)
		{
			return;
		}

		if (::Math.rand(1, 100) > 30)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		local village = _faction.getSettlements()[0];
		if (!village.isSouthern())
			return;

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_hunting_mummies_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		::World.Contracts.addContract(contract);
	}

});

