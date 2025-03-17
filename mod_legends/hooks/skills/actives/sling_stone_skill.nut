::mods_hookExactClass("skills/actives/sling_stone_skill", function(o)
{
	o.m.AdditionalAccuracy = -5;
	o.m.AdditionalHitChance = -4;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsShieldRelevant = true;
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

		return ret;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.AdditionalAccuracy = _properties.IsSpecializedInSlings ? (this.m.Item.getAdditionalAccuracy() + 5) : this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSlingerSpins))
			this.m.IsShieldRelevant = false;
		if (this.getContainer().hasEffect(::Legends.Effect.LegendPrepareBullet))
			this.m.MaxRange += 1;
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

	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
