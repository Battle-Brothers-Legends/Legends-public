this.perk_legend_push_forward <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendForwardPush);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPushForward))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_push_forward_skill"));
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendCoordinatedVolleys))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_coordinated_volleys_skill"));
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPushForward);
		::Legends.Actives.remove(this, ::Legends.Active.LegendCoordinatedVolleys);
	}

});
