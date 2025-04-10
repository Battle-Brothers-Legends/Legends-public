::mods_hookExactClass("skills/perks/perk_coup_de_grace", function(o) {
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local mult = 1.0 + this.calculateBonus(_skill, _targetEntity);

		_properties.DamageTotalMult *= mult;
	}

	o.onBeforeTargetHit = function ( _skill, _targetEntity, _hitInfo )
	{
		if ( _targetEntity != null && (this.isBonusEligible(_skill, _targetEntity) || this.isLowerBonusEligible(_skill, _targetEntity)))
		{
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}

	o.isBonusEligible <- function ( _skill, _targetEntity )
	{
		if (_skill.isAttack() && _targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) || _targetEntity.getSkills().hasEffect(::Legends.Effect.Debilitated) || _targetEntity.getSkills().hasEffect(::Legends.Effect.LegendTackled))
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	o.isLowerBonusEligible <- function ( _skill, _targetEntity )
	{
		if (!_skill.isAttack()) return false;

		local effects = [
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
			::Legends.Effect.Withered,
		];

		foreach(e in effects)
		{
			if (_targetEntity.getSkills().hasEffect(e))
				return true;
		}

		return false;
	}

	o.calculateBonus <- function ( _skill, _targetEntity )
	{
		local bonus = 0;

		if (this.isBonusEligible(_skill, _targetEntity))
		{
			bonus += 0.2;
		}
		if (this.isLowerBonusEligible(_skill, _targetEntity))
		{
			bonus += 0.1;
		}

		return bonus;
	}

	// Requires MSU; this will add tooltips to display bonuses when targeting an enemy
	o.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		local bonus = this.calculateBonus(_skill, _targetTile.getEntity()) * 100;

		if (bonus > 0)
		{
			_tooltip.push({
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "%[/color] damage from " + this.m.Name
			});

		}
	}
});
