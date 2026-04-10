::mods_hookExactClass("skills/actives/shoot_stake", function(o)
{
	o.m.AdditionalAccuracy = 10;
	o.m.AdditionalHitChance = -3;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "A quick pull of the trigger to loose a heavy bolt. Must be reloaded after each shot to be able to fire again. Will stagger on hit.";
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		if (this.getContainer().hasPerk(::Legends.Perk.LegendBallistics))
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Up to [color=%positive%]+30%[/color] of any damage ignores armor depending on the distance to the target, with the highest bonus in melee and lowest at maximum range"
			});
		}

		if (!this.getItem().isLoaded())
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Must be reloaded before firing again[/color]"
			});
		}

		return tooltip;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.7 : 0.5;
		this.m.AdditionalAccuracy = 10 + this.m.Item.getAdditionalAccuracy();
	}

	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this)
			return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		local actor = this.getContainer().getActor();
		local stagger = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Staggered);
		if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer && !_targetEntity.getFlags().has("tail"))
			this.Tactical.EventLog.log(stagger.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(actor), this.Const.UI.getColorizedEntityName(_targetEntity)));
		return onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor );
	}

	o.onUse = function( _user, _targetTile )
	{
		local success = this.attackEntity(_user, _targetTile.getEntity());
		this.getItem().setLoaded(false);
		return success;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
			return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		_properties.RangedSkill += this.m.AdditionalAccuracy;
		_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		if (_properties.IsSharpshooter)
		{
			_properties.DamageDirectMult += 0.05;
		}

		if (_skill == this && this.getContainer().hasPerk(::Legends.Perk.LegendBallistics))
		{
			local distance = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());
			_properties.DamageDirectAdd += 0.35 - (distance * 0.05)
		}
	}

});
