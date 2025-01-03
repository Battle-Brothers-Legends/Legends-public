this.perk_legend_coordinated_volleys <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendCoordinatedVolleys);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_coordinated_volleys"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_coordinated_volleys_skill"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_coordinated_volleys");
	}

});
