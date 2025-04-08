::mods_hookExactClass("skills/actives/knock_out", function(o)
{
	o.m.IsStaffKnockOut <- false;
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsHidden = true;
	}

	o.isHidden <- function()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem().getID();
		if ((item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel") && this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistGravedigger))
			return true;

		return this.skill.isHidden();
	}

	o.setItem <- function (_item)
	{
		if (this.m.IsStaffKnockOut)
		{
			this.m.Name = "Staff Daze";
			this.m.Description = "A heavy blow intended to daze anyone unlucky enough to be hit for one turn, but not to do the most damage. Dazed targets have their damage, initiative and stamina reduced by 35%";
			this.m.Icon = "skills/staff_knock_out.png";
			this.m.IconDisabled = "skills/staff_knock_out_bw.png";
			this.m.MaxRange = 2;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		if (!this.m.IsStaffKnockOut)
			return getTooltip();

		local ret = this.skill.getDefaultTooltip();
		local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + 2) * this.Const.Combat.FatigueReceivedPerHit;
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + fatPerHit + "[/color] extra fatigue"
		});

		local properties = this.getContainer().getActor().getCurrentProperties();
		local effects = properties.IsSpecializedInStaffStun ? "daze, stagger and stun" : "daze";
		if (properties.IsSpecializedInStaves)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to" + effects + " on a hit"
			});
		}
		else if (properties.IsSpecializedInStaves)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to " + effects + " on a hit"
			});
		}

		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.IsStaffKnockOut)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else
		{
			onAfterUpdate( _properties );
		}
	}

	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if (this.m.IsStaffKnockOut && (_user.getCurrentProperties().IsSpecializedInStaves || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getCurrentProperties().IsImmuneToDaze)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Dazed);

				if (_user.getCurrentProperties().IsSpecializedInStaffStun)
				{
					::Legends.Effects.grant(target, ::Legends.Effect.Staggered);

					if (!target.getCurrentProperties().IsImmuneToStun)
					{
						::Legends.Effects.grant(target, ::Legends.Effect.Stunned);
					}
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has dazed " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
				}
			}
			else if ((_user.getCurrentProperties().IsSpecializedInMaces || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasEffect(::Legends.Effect.Stunned))
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
				}

				if (this.m.IsFromLute && _user.isPlayerControlled())
				{
					this.updateAchievement("LuteStun", 1, 1);
				}
			}
		}

		return success;
	}

});
