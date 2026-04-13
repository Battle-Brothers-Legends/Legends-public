this.legend_transformed_boar_effect <- this.inherit("scripts/skills/effects/legend_transformed_effect", {
	m = {},
	function create()
	{
		this.legend_transformed_effect.create();
		this.m.ID = "effect.legend_transformed_bear";
		this.m.Name = "Boar Form";
		this.m.Description = "This character is currently a boar.";
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
					text = "[color=%positive%]+100%[/color] Fatigue Recovery per turn"
				}
			]);
		}
		return ret;
	}

	function setSkills()
	{
		::Legends.Actives.grant(this, ::Legends.Active.LegendBoarGore);
		::Legends.Actives.grant(this, ::Legends.Active.LegendBoarCharge);
		::Legends.Actives.grant(this, ::Legends.Active.Footwork);
	}

	function removeSkills()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendBoarGore);
		::Legends.Actives.remove(this, ::Legends.Active.LegendBoarCharge);
		if (!this.getContainer().hasPerk(::Legends.Perk.Footwork))
		{
			::Legends.Actives.remove(this, ::Legends.Active.Footwork);
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

