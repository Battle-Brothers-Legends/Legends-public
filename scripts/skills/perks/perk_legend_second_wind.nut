this.perk_legend_second_wind <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_second_wind";
		this.m.Name = this.Const.Strings.PerkName.LegendSecondWind;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSecondWind;
		this.m.Icon = "ui/perks/SecondWindPerk.png";
		this.m.IconDisabled = "ui/perks/SecondWindPerk_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local maxHP = actor.getHitpointsMax();
		local currentHP = actor.getHitpoints();
		if (!actor.getSkills().hasSkill("effects.legend_second_wind"))
		{
			if (currentHP < (maxHP / 2))
			{
				actor.setFatigue(actor.getFatigue() - 0.5 * actor.getFatigue() );
				actor.getSkills().add(this.new("scripts/skills/effects/legend_second_wind_effect"));

				if (this.m.Container.hasSkill("effects.stunned"))
				{
				this.m.Container.removeByID("effects.stunned");
				}
				if (this.m.Container.hasSkill("effects.dazed"))
				{
				this.m.Container.removeByID("effects.dazed");
				}
				if (this.m.Container.hasSkill("effects.legend_dazed"))
				{
				this.m.Container.removeByID("effects.legend_dazed");
				}
				if (this.m.Container.hasSkill("effects.staggered"))
				{
				this.m.Container.removeByID("effects.staggered");
				}
				if (this.m.Container.hasSkill("effects.legend_baffled"))
				{
				this.m.Container.removeByID("effects.legend_baffled");
				}
				if (this.m.Container.hasSkill("effects.charmed"))
				{
				this.m.Container.removeByID("effects.charmed");
				}
				if (this.m.Container.hasSkill("effects.sleeping"))
				{
				this.m.Container.removeByID("effects.sleeping");
				}
			}
		}
	}

});
