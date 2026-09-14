::mods_hookExactClass("items/armor/legendary/ijirok_armor", function(o) {
	// this doesn't really matter but i thought it should be kept for posterity
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Condition = 350; //was 320
		this.m.ConditionMax = 350;
		this.m.StaminaModifier = -25; //was -32
	}

	o.getTooltip = function ()
	{
		local result = this.armor.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Heals [color=%positive%]15[/color] hitpoints of the wearer each turn" //was 10
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

	o.onBeforeDamageReceived <- function ( _attacker, _skill, _hitInfo, _properties ) {
		switch (_hitInfo.DamageType) {
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null) {
					_properties.DamageReceivedRegularMult *= 1.0;
				} else {
					if (_skill.isRanged()) {
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon)) {
							if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Firearm)) {
								_properties.DamageReceivedRegularMult *= 0.25;
							} else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing)) {
								_properties.DamageReceivedRegularMult *= 0.25;
							} else {
								_properties.DamageReceivedRegularMult *= 1.0;
							}
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
