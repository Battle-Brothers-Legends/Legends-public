this.perk_legend_prayer_of_faith <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendPrayerOfFaith);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_prayer_of_faith"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_prayer_of_faith_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_prayer_of_faith");
	}

});

