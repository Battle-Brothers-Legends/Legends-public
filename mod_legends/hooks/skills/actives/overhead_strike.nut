::mods_hookExactClass("skills/actives/overhead_strike", function(o)
{
	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();

		if (this.m.StunChance != 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to stun on a hit"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInGreatSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue  + "]+5%[/color] chance to hit due to sword specialisation"
			});
		}

		return ret;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInGreatSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
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

		if (success && _targetTile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned"))
		{
			target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

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
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInGreatSwords)
			{
				_properties.MeleeSkill += 5;
			}

		}
	}
});
