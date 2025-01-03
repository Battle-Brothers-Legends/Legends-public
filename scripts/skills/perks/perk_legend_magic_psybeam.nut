this.perk_legend_magic_psybeam <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendMagicPsybeam);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_magic_psybeam"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_magic_psybeam_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("activeslegend_magic_psybeam");
	}

});
