::mods_hookExactClass("scripts/skills/skill", function(o)
{
	m =
	{
		AdditionalAccuracy		= -5
		AdditionalHitChance		= -4
	}

	// constructor

	local create = o.create;
	o.create = function ()
	{
		create();
		m.ID					= "actives.sling_stone";
		m.Name					= "Sling Stone";
		m.Description			= "Propel a stone towards a target with your sling. Accuracy drops sharply with distance. Can not be used while engaged in melee.";
		m.KilledString			= "Stoned";
		m.Icon					= "skills/active_12.png";
		m.IconDisabled			= "skills/active_12_sw.png";
		m.Overlay				= "active_12";
		m.SoundOnUse			= [ "sounds/combat/dlc4/sling_use_01.wav", "sounds/combat/dlc4/sling_use_02.wav", "sounds/combat/dlc4/sling_use_03.wav", "sounds/combat/dlc4/sling_use_04.wav" ];
		m.SoundOnHit			= [ "sounds/combat/dlc4/sling_hit_01.wav", "sounds/combat/dlc4/sling_hit_02.wav", "sounds/combat/dlc4/sling_hit_03.wav", "sounds/combat/dlc4/sling_hit_04.wav" ];
		m.SoundOnHitShield		= [ "sounds/combat/dlc4/sling_shield_hit_01.wav", "sounds/combat/dlc4/sling_shield_hit_02.wav", "sounds/combat/dlc4/sling_shield_hit_03.wav", "sounds/combat/dlc4/sling_shield_hit_04.wav", "sounds/combat/dlc4/sling_shield_hit_05.wav" ]
		m.SoundOnMiss			= [ "sounds/combat/dlc4/sling_miss_01.wav", "sounds/combat/dlc4/sling_miss_02.wav", "sounds/combat/dlc4/sling_miss_03.wav", "sounds/combat/dlc4/sling_miss_04.wav", "sounds/combat/dlc4/sling_miss_05.wav", "sounds/combat/dlc4/sling_miss_06.wav" ];
		m.Type					= Const.SkillType.Active;
		m.Order					= Const.SkillOrder.OffensiveTargeted;
		m.Delay					= 500;
		m.IsSerialized			= false;
		m.IsActive				= true;
		m.IsTargeted			= true;
		m.IsStacking			= false;
		m.IsAttack				= true;
		m.IsRanged				= true;
		m.IsIgnoredAsAOO		= true;
		m.IsShowingProjectile	= true;
		m.IsWeaponSkill			= true;

		m.IsDoingForwardMove	= false;

		m.InjuriesOnBody	= Const.Injury.BluntBody;
		m.InjuriesOnHead	= Const.Injury.BluntHead;

		m.DirectDamageMult		= 0.35;

		m.ActionPointCost		= 4;
		m.FatigueCost			= 15;
		m.MinRange				= 1;
		m.MaxRange				= 6;
		m.MaxLevelDifference	= 4;

		m.ProjectileType		= Const.ProjectileType.Stone;
		m.ProjectileTimeScale	= 1.2;
		m.IsProjectileRotated	= true;

		m.ChanceDecapitate	= 0;
		m.ChanceDisembowel	= 0;
		m.ChanceSmash		= 25;

		m.IsShieldRelevant = true;
		m.IsShieldwallRelevant = true;
	}

	o.getTooltip = function ()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		if (!this.getContainer().hasPerk(::Legends.Perk.LegendBarrage))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] chance to daze a target on a hit to the head"
			});
		}
		else
		{
			ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance on a hit to the head and [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance on a hit to the body to apply daze, debilitate, stagger or baffle on the target"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] to stun the target if any 3 of the above effects are already applied on the target"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Ignores the bonus to Defense granted by shields"
			}]);
		}
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		if (!this.m.IsShieldRelevant) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Ignores the bonus to Ranged Defense granted by shields"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return skill.isUsable() && (!Tactical.isActive() || !getContainer().getActor().getTile().hasZoneOfControlOtherThan(getContainer().getActor().getAlliedFactions()));
	}


	//////////////////////////////////////////////////////
	// Interface
	//////////////////////////////////////////////////////

	o.onAfterUpdate = function ( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.AdditionalAccuracy = _properties.IsSpecializedInSlings ? (this.m.Item.getAdditionalAccuracy() + 5) : this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSlingerSpins)) {
			this.m.IsShieldRelevant = false;
			// this.m.IsShieldwallRelevant = false;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.LegendPrepareBullet))
			this.m.MaxRange += 1;
	}

	function onUse(_user, _targetTile)
	{
		if(!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			getContainer().setBusy(true);
			local tag = { Skill = this, User = _user, TargetTile = _targetTile };
			Time.scheduleEvent(TimeUnit.Virtual, m.Delay, onPerformAttack, tag);

			// visibility hack to avoid problems because of the delay
			if(!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
				_user.getTile().addVisibilityForFaction(Const.Faction.Player);

			return true;
		}
		else
		{
			return attackEntity(_user, _targetTile.getEntity());
		}
	}

	function onPerformAttack(_tag)
	{
		_tag.Skill.getContainer().setBusy(false);
		return _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			_properties.FatigueDealtPerHitMult += 2.0;
		}
	}

	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();
			local isApplied = _bodyPart == this.Const.BodyPart.Head ? true : this.Math.rand(1, 100) <= 33;
			local effect = !_targetEntity.getCurrentProperties().IsImmuneToDaze ? ::Legends.Effects.new(::Legends.Effect.Dazed) : ::Legends.Effects.new(::Legends.Effect.Staggered);
			local effectName = !_targetEntity.getCurrentProperties().IsImmuneToDaze ? "dazed" : "staggered";

			if (user.getSkills().hasPerk(::Legends.Perk.LegendBarrage) && isApplied)
			{
				local targetStatus = _targetEntity.getSkills();
				local effectCounter = 0;

				switch (true)
				{
					case targetStatus.hasEffect(::Legends.Effect.Dazed):
					case targetStatus.hasEffect(::Legends.Effect.LegendDazed):
					case targetStatus.hasEffect(::Legends.Effect.LegendBaffled):
					case targetStatus.hasEffect(::Legends.Effect.Debilitated):
					case targetStatus.hasEffect(::Legends.Effect.Staggered):
						effectCounter += 1;
				}
				if (effectCounter >= 3 && !_targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Stunned);
					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves the already reeling " + this.Const.UI.getColorizedEntityName(_targetEntity) + " stunned");
					return;
				}
				else
				{
					// todo, this is bs, doesn't check if can be dazed for example
					local effects = [
						[::Legends.Effect.Dazed, "dazed"],
						[::Legends.Effect.Staggered, "staggered"],
						[::Legends.Effect.Debilitated, "debilitated"],
						[::Legends.Effect.LegendBaffled, "baffled"]
					];
					local rand = this.Math.rand(0, effects.len() - 1);
					effect = ::Legends.Effects.new(effects[rand][0]);
					effectName = effects[rand][1];
				}
			}

			_targetEntity.getSkills().add(effect);

			if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " " + effectName);
			}
		}
	}

});
