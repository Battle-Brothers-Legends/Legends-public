::mods_hookExactClass("skills/actives/split", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsTargetingActor = false;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 2 targets"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-5%[/color] chance to hit"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%positive%]+5%[/color] chance to hit"
			});
		}

		return tooltip;
	}

	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);

		local ret = false;
		if (::Legends.S.skillEntityAliveCheck(_user)) {
			return ret;
		}

		local ownTile = _user.getTile();
		if (_targetTile.IsOccupiedByActor && _targetTile.getEntity().isAttackable() && this.Math.abs(_targetTile.Level - ownTile.Level) <= 1)
		{
			ret = this.attackEntity(_user, _targetTile.getEntity());
		}

		local dir = ownTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local forwardTile = _targetTile.getNextTile(dir);

			if (forwardTile.IsOccupiedByActor && forwardTile.getEntity().isAttackable() && this.Math.abs(forwardTile.Level - ownTile.Level) <= 1)
			{
				ret = this.attackEntity(_user, forwardTile.getEntity()) || ret;
			}
		}

		return ret;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 5;
			}
			else
			{
				_properties.MeleeSkill += 5;
			}
		}
	}

});
