this.legend_obliterate_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendObliterate);
		this.m.Description = "Wind up your hammer and strike with full force against an enemy. Exceptionally slow and prone to missing, can only be reliable against targets that can't move. Will apply [color=%status%]Staggered[/color] on hit and if the target is already [color=%status%]Staggered[/color] it will apply [color=%status%]Stunned[/color].";
		this.m.KilledString = "Obliterated";
		this.m.Icon = "skills/active_89.png";
		this.m.IconDisabled = "skills/active_89_sw.png";
		this.m.Overlay = "active_89";
		this.m.SoundOnUse = [
			"sounds/combat/smash_01.wav",
			"sounds/combat/smash_02.wav",
			"sounds/combat/smash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav",
			"sounds/combat/smash_hit_02.wav",
			"sounds/combat/smash_hit_03.wav"
		];
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
		this.m.HitChanceBonus = -75;
		this.m.DirectDamageMult = 0.6;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 100;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has a [color=%positive%]50%[/color] bonus hitchance against targets that are [color=%status%]Rooted[/color] or [color=%status%]Stunned[/color]"
		});
		return ret;
	}

	function onAfterUpdate(_properties) {
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill != this) {
			return;
		}

		if (::Legends.S.skillEntityAliveCheck(_targetEntity)) {
			return;
		}

		local user = this.getContainer().getActor();
		local targetTile = _targetEntity.getTile();

		if (::Legends.Effects.has(_targetEntity, ::Legends.Effect.Staggered)) {
			local stunned = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Stunned);
			if (!_targetEntity.isHiddenToPlayer() && targetTile.IsVisibleForPlayer) {
				this.Tactical.EventLog.log(stunned.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(user), this.Const.UI.getColorizedEntityName(_targetEntity)));
			}
			return;
		}
		local stagger = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Staggered);
		if (!_targetEntity.isHiddenToPlayer() && targetTile.IsVisibleForPlayer && !_targetEntity.getFlags().has("tail")) {
			this.Tactical.EventLog.log(stagger.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(user), this.Const.UI.getColorizedEntityName(_targetEntity)));
		}
	}

	function adjustHitchance (_targetEntity, _properties) {
		local mod = 0;
		if (_targetEntity != null && (_targetEntity.getCurrentProperties().IsRooted || ::Legends.Effects.has(_targetEntity, ::Legends.Effect.Stunned))) {
				mod += 50;
			}
		if (_properties.IsSpecializedInHammers) {
			mod += 25;
		}
		return mod;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill == this) {
			this.m.HitChanceBonus += this.adjustHitchance(_targetEntity, _properties);
			_properties.MeleeSkill += this.m.HitChanceBonus
			_properties.DamageTotalMult *= 1.5;
			_properties.ThresholdToInflictInjuryMult *= 0.66;
		}
	}

});
