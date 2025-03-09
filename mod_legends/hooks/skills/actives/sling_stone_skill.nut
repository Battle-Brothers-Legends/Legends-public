::mods_hookExactClass("skills/actives/sling_stone_skill", function(o)
{
	q.m.AdditionalAccuracy = -10;
	q.m.AdditionalHitChance = -6;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.MinRange = 2;
		this.m.IsShieldRelevant = true;
	}

	o.getTooltip = function ()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		if (!this.getContainer().getActor().getSkills().hasSkill("perk.legend_barrage"))
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
		if (this.getContainer().hasSkill("perk.legend_slinger_spins"))
			this.m.IsShieldRelevant = false;
		if (this.getContainer().hasSkill("effects.legend_slinger_spins"))
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
			local effect = !_targetEntity.getCurrentProperties().IsImmuneToDaze ? this.new("scripts/skills/effects/dazed_effect") : this.new("scripts/skills/effects/staggered_effect");
			local effectName = !_targetEntity.getCurrentProperties().IsImmuneToDaze ? "dazed" : "staggered";

			if (user.getSkills().hasSkill("perk.legend_barrage") && isApplied)
			{
				local targetStatus = _targetEntity.getSkills();
				local effectCounter = 0;

				switch (true)
				{
					case targetStatus.hasSkill("effects.dazed"):
						effectCounter += 1;
					case targetStatus.hasSkill("effects.legend_baffled"):
						effectCounter += 1;	
					case targetStatus.hasSkill("effects.debilitated"):
						effectCounter += 1;
					case targetStatus.hasSkill("effects.staggered"):			
						effectCounter += 1;
				}
				if (effectCounter >= 3 && !_targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves the already reeling " + this.Const.UI.getColorizedEntityName(_targetEntity) + " stunned");
					return;
				}
				else
				{
					local rand = this.Math.rand(1, 100);
					switch (true)
					{
						case rand <= 25:
							effect = this.new("scripts/skills/effects/dazed_effect");
							effectName = "dazed"
						case rand <= 50:
							effect = this.new("scripts/skills/effects/staggered_effect");
							effectName = "staggered"
						case rand <= 75:
							effect = this.new("scripts/skills/effects/debilitated_effect");
							effectName = "debilitated"
						case rand <= 100:
							effect = this.new("scripts/skills/effects/legend_baffled_effect");
							effectName = "baffled"
					}
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
