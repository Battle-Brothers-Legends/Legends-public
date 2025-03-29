this.legend_upgrade_settlement_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Settlement = null
	},
	function create()
	{
		this.m.ID = "legend_upgrade_settlement_action";
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

		//We can only upgrade a settlement once all the locations have been filled up.
		if (this.m.Settlement.canBuildLocation())
		{
			return;
		}

		if (!this.m.Settlement.canUpgrade())
		{
			return;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
		this.m.Settlement = null;
	}

	function onExecute( _faction )
	{
		this.m.Settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_upgrading_effort_situation"));
	}

});

