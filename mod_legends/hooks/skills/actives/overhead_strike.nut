::mods_hookExactClass("skills/actives/overhead_strike", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = 5;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();

		if (this.m.StunChance != 0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]" + this.m.StunChance + "%[/color] chance to stun on a hit"
			});
		}

		return tooltip;
	}

	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (!target.isAlive() || target.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasEffect(::Legends.Effect.Stunned))
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
			}
		}

		return success;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		onAnySkillUsed( _skill, _targetEntity, _properties );
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}

		}
	}
});
