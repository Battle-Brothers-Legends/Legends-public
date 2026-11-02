::mods_hookExactClass("skills/perks/perk_coup_de_grace", function (o) {
	o.m.HighBonus <- [
		::Legends.Effect.Debilitated,
		::Legends.Effect.LegendKnockedOver
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

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_targetEntity == null) {
			return;
		}

		_properties.DamageTotalMult *= 1.0 + this.calculateBonus(_targetEntity);
	}

	o.calculateBonus <- function (_targetEntity) {
		local bonus = 0;

		if (_targetEntity.getSkills().hasSkillOfType(::Const.SkillType.TemporaryInjury) || ::Legends.S.any(this.m.HighBonus, @(_effect) ::Legends.Effects.has(_targetEntity, _effect))) {
			bonus += 0.2;
		}

		if (::Legends.S.any(this.m.LowBonus, @(_effect) ::Legends.Effects.has(_targetEntity, _effect))) {
			bonus += 0.1;
		}

		return bonus;
	}

	o.onBeforeTargetHit = function (_skill, _targetEntity, _hitInfo) {
		if (_targetEntity != null && this.calculateBonus(_targetEntity) != 0) {
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}
});
