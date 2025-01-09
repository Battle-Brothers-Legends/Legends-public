this.legend_sling_heavy_stone_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = -5,
		AdditionalHitChance = -4
	},
	function create()
	{
		this.m.ID = "actives.legend_sling_heavy_stone";
		this.m.Name = "Sling Heavy Stone";
		this.m.Description = "Hurl a stone towards a target with your sling. Hard to aim and very unwieldy, but stones are everywhere so you never run out of ammunition. Can not be used while engaged in melee.";
		this.m.KilledString = "Stoned";
		this.m.Icon = "skills/active_12.png";
		this.m.IconDisabled = "skills/active_12_sw.png";
		this.m.Overlay = "active_12";
		this.m.SoundOnUse = [
			"sounds/combat/dlc4/sling_use_01.wav",
			"sounds/combat/dlc4/sling_use_02.wav",
			"sounds/combat/dlc4/sling_use_03.wav",
			"sounds/combat/dlc4/sling_use_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc4/sling_hit_01.wav",
			"sounds/combat/dlc4/sling_hit_02.wav",
			"sounds/combat/dlc4/sling_hit_03.wav",
			"sounds/combat/dlc4/sling_hit_04.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/dlc4/sling_shield_hit_01.wav",
			"sounds/combat/dlc4/sling_shield_hit_02.wav",
			"sounds/combat/dlc4/sling_shield_hit_03.wav",
			"sounds/combat/dlc4/sling_shield_hit_04.wav",
			"sounds/combat/dlc4/sling_shield_hit_05.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/dlc4/sling_miss_01.wav",
			"sounds/combat/dlc4/sling_miss_02.wav",
			"sounds/combat/dlc4/sling_miss_03.wav",
			"sounds/combat/dlc4/sling_miss_04.wav",
			"sounds/combat/dlc4/sling_miss_05.wav",
			"sounds/combat/dlc4/sling_miss_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 750;
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
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.75;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 17;
		this.m.MinRange = 4;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 8;
		this.m.ProjectileType = this.Const.ProjectileType.Stone;
		this.m.ProjectileTimeScale = 1.2;
		this.m.IsProjectileRotated = true;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 25;
	}

	function getTooltip()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());
		local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + 3) * this.Const.Combat.FatigueReceivedPerHit;

		ret.extend([
		{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] chance to daze a target on a hit to the head and always staggers the target"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + fatPerHit + "[/color] extra fatigue"
		}]);

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || (this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()));
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.AdditionalAccuracy = _properties.IsSpecializedInSlings ? 0 : -5;
		this.m.AdditionalHitChance = _properties.IsSpecializedInSlings ? -2 : -4;
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSlingDamage) && this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSlingSkill))
		{
			this.m.ActionPointCost = 7;
			this.m.FatigueCost = 25;
		}
		else if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSlingDamage) || this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSlingSkill))
		{
			this.m.ActionPointCost = 6;
			this.m.FatigueCost = 21;
		}
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
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 250, this.onPerformAttack, tag);

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
			_properties.FatigueDealtPerHitMult += 3.0;
			if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSlingDamage))
			{
				_properties.DamageRegularMin += 15;
				_properties.DamageRegularMax += 30;
				//_properties.DamageDirectAdd += 0.2;
			}
			if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSlingSkill))
			{
				_properties.DamageArmorMult *= 1.5;
			}
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
		}

		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
				}
			}
		}
	}
});

