this.legend_vala_warden_wail_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendValaWardenWail);
		this.m.Description = "";
		this.m.KilledString = "Frightened to death";
		this.m.SoundOnUse = ["sounds/combat/legend_vala_warden_wail.wav"];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 2;
		this.m.MaxRange = 3;
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		return !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions());
	}

	function onUse(_user, _targetTile) {
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill == this) {
			_properties.RangedAttackBlockedChanceMult = 0.0;
			local scaling = ::Legends.Effects.get(this, ::Legends.Effect.LegendValaWardenDamage);
			local fury = ::Legends.Effects.get(this, ::Legends.Effect.LegendValaChantFuryEffect);
			local bonus1 = (scaling != null) ? scaling.getDamageBonus() : 0;
			local bonus2 = (fury != null) ? fury.getWardenDamage() : 0;

			local actor = this.getContainer().getActor();
			if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != actor.getID() && _targetEntity.getFaction() == actor.getFaction()) {
				_properties.DamageRegularMin = 0;
				_properties.DamageRegularMax = 0;
				_properties.IsIgnoringArmorOnAttack = false;
			} else {
				_properties.DamageRegularMin += 10 + ::Math.round(bonus1 * 0.67) + ::Math.round(bonus2 * 0.67);
				_properties.DamageRegularMax += 15 + ::Math.round(bonus1) + ::Math.round(bonus2);
				_properties.IsIgnoringArmorOnAttack = true;
				_properties.HitChanceAdditionalWithEachTile -= 2;
			}
		}
	}
});
