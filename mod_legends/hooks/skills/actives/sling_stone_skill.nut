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
				text = "Has a [color=%negative%]100%[/color] chance to baffle a target on a hit to the head"
			});
		}
		else
		{
			ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to debilitate a target on a hit to the head"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to baffle a target on a hit to the body"
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
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
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

		if (this.getContainer().hasPerk(::Legends.Perk.LegendBarrage))
		{
			this.m.IsShieldRelevant = false;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head && !_targetEntity.getCurrentProperties().IsImmuneToDaze)
			{
				::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendBaffled);

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " baffled");
				}
			}
		}
	}
});
