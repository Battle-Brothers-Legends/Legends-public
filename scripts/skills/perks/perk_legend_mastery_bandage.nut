this.perk_legend_mastery_bandage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecBandage);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_bandage"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_bandage_skill"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_bandage");
	}

});
