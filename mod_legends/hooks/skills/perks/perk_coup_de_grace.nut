::mods_hookExactClass("skills/perks/perk_coup_de_grace", function(o) {
	o.m.HighBonus <- [
		::Legends.Effect.Debilitated,
		::Legends.Effect.LegendTackled
	];
	o.m.LowBonus <- [
		::Legends.Effect.Dazed,
		::Legends.Effect.Distracted,
		::Legends.Effect.LegendBaffled,
		::Legends.Effect.LegendParried,
		::Legends.Effect.LegendGrappled,
		::Legends.Effect.Net,
		::Legends.Effect.Rooted,
		::Legends.Effect.Shellshocked,
		::Legends.Effect.Sleeping,
		::Legends.Effect.Staggered,
		::Legends.Effect.Stunned,
		::Legends.Effect.Web,
		::Legends.Effect.Withered
	];

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local mult = 1.0 + this.calculateBonus(_targetEntity);

		_properties.DamageTotalMult *= mult;
	}

	o.calculateBonus <- function (_targetEntity)
	{

		local bonus = 0;

		if (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
		{
			bonus += 0.2;
		}
		else
		{
			foreach (effect in this.m.HighBonus)
			{
				if (_targetEntity.getSkills().hasEffect(effect))
				{
					bonus += 0.2;
					break;
				}
			}
		}

		foreach (effect in this.m.LowBonus)
		{
			if (_targetEntity.getSkills().hasEffect(effect))
			{
				bonus += 0.1;
				break;
			}
		}

		return bonus;
	}

	// Requires MSU; this will add tooltips to display bonuses when targeting an enemy
	o.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		local bonus = this.calculateBonus(_targetTile.getEntity()) * 100;

		if (bonus > 0)
		{
			_tooltip.push({
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+" + bonus + "%[/color] damage from " + this.m.Name
			});

		}
	}

	o.onBeforeTargetHit = function ( _skill, _targetEntity, _hitInfo )
	{
		if (_targetEntity != null && this.calculateBonus(_targetEntity) != 0) {
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}
});
