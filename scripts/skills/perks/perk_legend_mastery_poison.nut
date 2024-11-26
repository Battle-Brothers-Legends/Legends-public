this.perk_legend_mastery_poison <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecPoison);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.coat_with_poison_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_poison_weapon_skill"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_poison_weapon");
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToPoison = true;
	}

});
