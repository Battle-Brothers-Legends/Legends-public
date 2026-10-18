this.legend_improvised_strike_skill <- this.inherit("scripts/skills/skill", {
	m = {
		EffectChance = 25;
	}
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendImprovisedStrike);
		this.m.Description = "Use the butt of your ranged weapon to hit the target. Not particularly damaging, but might get you out of a tricky situation.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/bash", 3);
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/bash_hit", 3);
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function getTooltip () {
		local ret = this.skill.getDefaultTooltip();
		local param = [
			["_fatigue", 2 * ::Const.Combat.FatigueReceivedPerHit],
			["_chance", this.m.EffectChance],
		];
		ret.extend([{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=%damage%]%_fatigue%[/color] extra fatigue",
			param = param
		},{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]%_chance%%[/color] chance to [color=%effect%]Daze[/color] or [color=%effect%]Stagger[/color] on a hit and [color=%effect%]Stun[/color] on a hit to the head",
			param
		}]);

		return ret;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.DamageTotalMult *= 0.25;
			_properties.FatigueDealtPerHitMult += 2.0;
		}
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.EffectChance = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? 50 : 25;
	}

	function onTargetHit (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (!this.m.IsRangedKnockOut || _skill != this) {
			return;
		}

		if (::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return;
		}

		local targetTile = _targetEntity.getTile();
		local user = this.getContainer().getActor();
		local effect;
		if (_bodyPart == ::Const.BodyPart.Head) {
			if (!_targetEntity.getCurrentProperties().IsImmuneToStun) {
				effect = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Stunned);

				
			}
		}
		else if (::Math.rand(0, 100) < this.m.EffectChance) {
			if (::Math.rand(1, 2) == 1 && !_targetEntity.getCurrentProperties().IsImmuneToDaze) {
				effect = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Dazed);
			}
			else {
				effect = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Staggered);
			}
		}

		if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer) {
			::Tactical.EventLog.log(effect.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(user), ::Const.UI.getColorizedEntityName(_targetEntity)));
		}

	}
});
