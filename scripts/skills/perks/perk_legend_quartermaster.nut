this.perk_legend_quartermaster <- this.inherit("scripts/skills/skill", {

	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendQuartermaster);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateFoodModifier();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateFoodModifier();
	}


});
