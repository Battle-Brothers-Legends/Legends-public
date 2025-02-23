this.legend_shoot_dart_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = -20,
		AdditionalHitChance = -1
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendShootDart);
		this.m.Description = "A quick puff of air to propel a dart. A hit to the head will put the target to sleep, a hit to the body has a 50% chance to daze the target.";
		this.m.KilledString = "Darted";
		this.m.Icon = "skills/blowgun_square.png";
		this.m.IconDisabled = "skills/blowgun_square_sw.png";
		this.m.Overlay = "blowgun_square";
		this.m.SoundOnUse = [
			"sounds/combat/blowgun_01.wav",
			"sounds/combat/blowgun_02.wav",
			"sounds/combat/blowgun_03.wav",
			"sounds/combat/blowgun_04.wav",
			"sounds/combat/blowgun_05.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bolt_shot_hit_01.wav",
			"sounds/combat/bolt_shot_hit_02.wav",
			"sounds/combat/bolt_shot_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/dlc4/sling_shield_hit_01.wav",
			"sounds/combat/dlc4/sling_shield_hit_02.wav",
			"sounds/combat/dlc4/sling_shield_hit_03.wav",
			"sounds/combat/dlc4/sling_shield_hit_04.wav",
			"sounds/combat/dlc4/sling_shield_hit_05.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/bolt_shot_miss_01.wav",
			"sounds/combat/bolt_shot_miss_02.wav",
			"sounds/combat/bolt_shot_miss_03.wav"

		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.35;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Dart;
		this.m.ProjectileTimeScale = 1.2;
		this.m.IsProjectileRotated = true;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInBows ? 1 : 0);
		this.m.AdditionalAccuracy = _properties.IsSpecializedInBows ? (this.m.Item.getAdditionalAccuracy() + 5) : this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);
			local tag = {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			};
			this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.Delay, this.onPerformAttack, tag);

			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
			{
				_user.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}

			return true;
		}
		else
		{
			return this.attackEntity(_user, _targetTile.getEntity());
		}
	}

	function onPerformAttack( _tag )
	{
		_tag.Skill.getContainer().setBusy(false);
		return _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this)
			return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < 1 || _targetEntity.getHitpoints() <= 0)
			return;

		local targetTile = _targetEntity.getTile();
		local user = this.getContainer().getActor();
		local r;
		r = this.Math.rand(1, 2);
		if (_bodyPart == this.Const.BodyPart.Head)
		{

			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Sleeping);

			if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit to the head that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " sleeping");
			}
		}
		if (_bodyPart == this.Const.BodyPart.Body)
		{
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Dazed);

			if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit to the body that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
			}
		}
	}

});

