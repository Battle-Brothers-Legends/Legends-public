this.perk_legend_push_forward <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendForwardPush);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPushForward))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPushForward);
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendCoordinatedVolleys))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendCoordinatedVolleys);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPushForward);
		::Legends.Actives.remove(this, ::Legends.Active.LegendCoordinatedVolleys);
	}

});
