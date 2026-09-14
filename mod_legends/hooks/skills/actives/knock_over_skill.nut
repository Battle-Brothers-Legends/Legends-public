::mods_hookExactClass("skills/actives/knock_over_skill", function(o)
{
	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();
		local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + 2) * this.Const.Combat.FatigueReceivedPerHit;
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2" + "[/color] tiles"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=%damage%]" + fatPerHit + "[/color] extra fatigue"
		});

		if (::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem()))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to stun on a hit"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]" + this.m.StunChance + "%[/color] chance to stun on a hit"
			});
		}

		if (!::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem()))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return ret;
	}

	o.onUse = function ( _user, _targetTile ) {
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, target);

		if (::Legends.S.isEntityNullOrDead(_user)) {
			return success;
		}

		if (::Legends.S.isEntityNullOrDead(target)) {
			return success;
		}

		if (success)
		{
			if ((::Legends.S.isCharacterWeaponSpecialized(_user.getCurrentProperties(), this.getItem()) || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasEffect(::Legends.Effect.Stunned))
			{
				local stun = ::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(stun.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(target)));
				}
			}
		}

		return success;
	}

	o.onAfterUpdate = function ( _properties ) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.DamageTotalMult *= 0.5;
			_properties.FatigueDealtPerHitMult += 2.0;

			if (_targetEntity != null && !::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
		}
	}
});
