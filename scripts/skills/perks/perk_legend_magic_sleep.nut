this.perk_legend_magic_sleep <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_magic_sleep";
		this.m.Name = this.Const.Strings.PerkName.LegendMagicSleep;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMagicSleep;
		this.m.Icon = "ui/perks/sleep_56.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_magic_sleep"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_magic_sleep"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_magic_sleep");
	}
});
