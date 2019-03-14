this.perk_legend_barter_trustworthy <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_barter_trustworthy";
		this.m.Name = this.Const.Strings.PerkName.LegendBarterTrustworthy;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBarterTrustworthy;
		this.m.Icon = "ui/perks/BarterT2.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local BarterMod = this.Const.LegendMod.getBarterModifier;
		BarterMod += 0.05; 

	}
		function onRemoved()
	{
		local BarterMod = this.Const.LegendMod.getBarterModifier;
		BarterMod -= 0.05; 
	}
});
