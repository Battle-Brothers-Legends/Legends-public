// TODO Edit strings.nut
this.perk_legend_magic_circle_of_protection <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_magic_circle_of_protection";
		this.m.Name = this.Const.Strings.PerkName.LegendMagicCircleOfProtection;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMagicCircleOfProtection;
		this.m.Icon = "ui/perks/mage_legend_magic_circle_of_protection_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_magic_circle_of_protection"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_magic_circle_of_protection"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_magic_circle_of_protection");
	}

});
