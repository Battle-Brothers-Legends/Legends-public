this.perk_legend_distant_visions <- this.inherit("scripts/skills/skill", {
	m = {
		BaseChance = 10,
		DaysNotProcced = 0
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDistantVisions);
	}

	function onAdded()
	{
		if (m.IsNew && ::MSU.isKindOf(getContainer().getActor(), "player") && getContainer().getActor().isPlayerControlled())
		{
			foreach (settlement in ::World.EntityManager.getSettlements())
			{
				if (::MSU.isKindOf(settlement, "settlement") && settlement.m.OnEnter == null)
					settlement.setVisited(true);
			}
		}

		m.IsNew = false;
	}

	function onNewDay()
	{
		if (!this.getContainer().getActor().isInReserves())
			return;

		if ( this.Math.rand(1,100) <= this.m.BaseChance + (this.m.DaysNotProcced/4) )
		{
			if ( this.World.State.getDistantVisionBonus() ) //just on the off chance 2 different brothers would proc it in the same newDay(), this wouldn't pop 2 events
			{
				this.m.DaysNotProcced = 0;
				return;
			}
			this.World.State.setDistantVisionBonus(true);
			this.m.DaysNotProcced = 0;
			this.World.Events.fire("event.legend_distant_visions");
		}
		else
		{
			this.m.DaysNotProcced += 1;
		}
	}

});
