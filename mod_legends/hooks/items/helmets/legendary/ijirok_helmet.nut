::mods_hookExactClass("items/helmets/legendary/ijirok_helmet", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Condition = 160;
		this.m.ConditionMax = 160; //was 300
		this.m.StaminaModifier = -10; //was 20
	}

	o.getTooltip = function () {
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Heals [color=%positive%]10[/color] hitpoints of the wearer each turn" //was 10
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/armor_damage.png",
			text = "Gain [color=%positive%]25%[/color] damage resistance from ranged and thrown attacks"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/armor_damage.png",
			text = "Receive [color=%negative%]50%[/color] more damage from burning attacks"
		});
		return result;
	}

	local onCombatFinished = o.onCombatFinished;
	o.onCombatFinished = function () {
		if (::Legends.S.isNull(this.getContainer()))
			return;
		onCombatFinished();
	}

	o.onTurnStart = function () {
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, 10); //was 10

		if (healthAdded <= 0)
			return;

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer()) {
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_02.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

	o.onBeforeDamageReceived <- function ( _attacker, _skill, _hitInfo, _properties ) {
		switch (_hitInfo.DamageType)
		{
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null) {
					_properties.DamageReceivedRegularMult *= 1.0;
				} else {
					if (_skill.isRanged()) {
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon)) {
							if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Firearm))
								_properties.DamageReceivedRegularMult *= 0.25;
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
								_properties.DamageReceivedRegularMult *= 0.25;
							else
								_properties.DamageReceivedRegularMult *= 1.0;
						}
					}
				}
				break;

			case this.Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.5;
				break;
		}
	}
});
