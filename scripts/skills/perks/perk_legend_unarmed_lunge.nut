this.perk_legend_unarmed_lunge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendUnarmedLunge);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(this.new("scripts/skills/actives/legend_unarmed_lunge_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.legend_unarmed_lunge");
	}

});

