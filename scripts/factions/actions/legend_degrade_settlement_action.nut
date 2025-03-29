this.legend_degrade_settlement_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Settlement = null
	},
	function create()
	{
		this.m.ID = "legend_degrade_settlement_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 15;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if(!::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			return;
		}

		// if (this.Math.rand(1, 100) > 10)
		// {
		// 	return;
		// }

		this.m.Settlement = _faction.getSettlements()[this.Math.rand(0, _faction.getSettlements().len() - 1)];

		if (this.m.Settlement.isBuilding())
		{
			return;
		}

		if (this.m.Settlement.getWealth() > 50)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onClear()
	{
		this.m.Settlement = null;
	}

	function onExecute( _faction )
	{
		this.m.Settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_degrading_effort_situation"));
	}

});

