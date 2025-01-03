this.perk_legend_become_berserker <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendBecomeBerserker);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{


		local actor = this.getContainer().getActor();
		local originalbackground = actor.getBackground().getID();
		local newbackground = this.new("scripts/skills/backgrounds/legend_berserker_background");
		actor.getSkills().removeByID(originalbackground);
		actor.getSkills().add(newbackground);
	}


});
