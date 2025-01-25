::mods_hookExactClass("skills/actives/sling_stone_skill", function(o)
{
	o.m.AdditionalAccuracy = -10;
	o.m.AdditionalHitChance = -5;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.MinRange = 2;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());
		local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + 2) * this.Const.Combat.FatigueReceivedPerHit;

		tooltip.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] chance to daze a target on a hit to the head"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + fatPerHit + "[/color] extra fatigue"
		}
		]);

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.AdditionalAccuracy = _properties.IsSpecializedInSlings ? (this.m.Item.getAdditionalAccuracy() + 5) : this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
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

			if (_bodyPart == this.Const.BodyPart.Head && !_targetEntity.getCurrentProperties().IsImmuneToDaze)
			{
				::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Dazed);

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
				}
			}
		}
	}
});
