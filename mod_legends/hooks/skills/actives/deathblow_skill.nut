::mods_hookExactClass("skills/actives/deathblow_skill", function(o)
{
	o.m.DeathblowBonus <- false;
	o.m.ApplicableSkills <- [
		::Legends.Effect.Dazed,
		::Legends.Effect.LegendDazed,
		::Legends.Effect.Debilitated,
		::Legends.Effect.Distracted,
		::Legends.Effect.LegendGrappled,
		::Legends.Effect.LegendBaffled,
		::Legends.Effect.LegendChoked,
		::Legends.Effect.LegendTackled,
		::Legends.Effect.Shellshocked,
		::Legends.Effect.Sleeping,
		::Legends.Effect.Staggered
	];

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsHidden = true;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		if (this.m.DeathblowBonus && this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistPrisoner))
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]50%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] armor of targets that have the Baffled, Dazed, Stunned, Sleeping, Rooted, Distracted, Webbed, Trapped in Net, Staggered, Shellshocked, Tackled, Debilitated or Grappled status effects."

			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] armor of targets that have the Baffled, Dazed, Stunned, Sleeping, Rooted, Distracted, Webbed, Trapped in Net, Staggered, Shellshocked, Tackled, Debilitated or Grappled status effects."

			});
		}
		return tooltip;
	}

	o.isHidden <- function()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem().getID();
		if (this.m.DeathblowBonus || this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistPrisoner))
			return false;

		return this.skill.isHidden();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && _targetEntity != null)
		{
			local targetStatus = _targetEntity.getSkills();
			local bonus = false;

			if (_targetEntity.getCurrentProperties().IsRooted || _targetEntity.getCurrentProperties().IsStunned)
				bonus = true;

			foreach ( skill in this.m.ApplicableSkills)
			{
				if (targetStatus.hasEffect(skill))
				{
					bonus = true;
				}
			}

			if (bonus && this.m.DeathblowBonus && this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistPrisoner))
			{
				_properties.DamageTotalMult *= 1.5;
				_properties.DamageDirectAdd += 0.3;
			}
			else if (bonus)
			{
				_properties.DamageTotalMult *= 1.33;
				_properties.DamageDirectAdd += 0.2;
			}
		}
	}
});
