::mods_hookExactClass("skills/actives/deathblow_skill", function(o)
{
	o.m.ApplicableSkills <-
	[
		"effects.dazed",
		"effects.debilitated",
		"effects.distracted",
		"effects.grappled",
		"effects.legend_baffled",
		"effects.legend_choked",
		"effects.legend_tackled",
		"effects.shellshocked",
		"effects.staggered",
	];

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] armor of targets that have the Baffled, Dazed, Stunned, Sleeping, Rooted, Distracted, Webbed, Trapped in Net, Staggered, Shellshocked, Tackled, Debilitated or Grappled status effects."

		});
		return tooltip;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && _targetEntity != null)
		{
			if (_targetEntity.getCurrentProperties().IsRooted || _targetEntity.getCurrentProperties().IsStunned) {
				_properties.DamageTotalMult *= 1.33;
				_properties.DamageDirectAdd += 0.2;
				return;
			}

			local targetStatus = _targetEntity.getSkills();

			foreach ( skill in this.m.ApplicableSkills)
			{
				if (targetStatus.hasSkill(skill))
				{
					_properties.DamageTotalMult *= 1.33;
					_properties.DamageDirectAdd += 0.2;
					break;
				}
			}
		}
	}
});
