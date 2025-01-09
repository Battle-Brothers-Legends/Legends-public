this.legend_transformed_boar_effect <- this.inherit("scripts/skills/effects/legend_transformed_effect", {
	m = {},
	function create()
	{
		this.legend_transformed_effect.create();
		this.m.ID = "effect.legend_transformed_bear";
		this.m.Name = "Boar Form";
		this.m.Description = "This character is currently a boar";
		this.m.Icon = "ui/perks/bear_circle.png";
		this.m.IconMini = "status_effect_08_mini";
		this.m.Agent1 = "legend_boar_agent";
		this.m.Agent2 = "legend_boar_agent";
		this.m.Head = "were_boar_head";
		this.m.Body = "were_boar_body";
		this.m.Injury = "were_boar_body_injured";
	}

	function getTooltip()
	{
		local ret = this.legend_transformed_effect.getTooltip();
		{
			ret.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/health.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color] stamina recovery rate"
				}
			]);
		}
		return ret;
	}

	function setSkills()
	{
		local actor = this.getContainer().getActor();

		if (!actor.getSkills().hasSkill("actives.legend_boar_gore"))
		{
			actor.getSkills().add(this.new("scripts/skills/actives/legend_boar_gore_skill"));
		}
		if (!actor.getSkills().hasSkill("actives.legend_boar_charge"))
		{
			actor.getSkills().add(this.new("scripts/skills/actives/legend_boar_charge_skill"));
		}
		if (!actor.getSkills().hasSkill("actives.footwork"))
		{
			actor.getSkills().add(this.new("scripts/skills/actives/footwork"));
		}
	}

	function removeSkills()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().removeByID("actives.legend_boar_gore");
		actor.getSkills().removeByID("actives.legend_boar_charge");
		if (!actor.getSkills().hasPerk(::Legends.Perk.Footwork))
		{
			actor.getSkills().removeByID("actives.footwork");
		}
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRateMult *= 2.0;
		_properties.StaminaMult *= 2.0;
		_properties.HitpointsMult *= 2.0;
		_properties.BraveryMult *= 1.25;
	}

});

