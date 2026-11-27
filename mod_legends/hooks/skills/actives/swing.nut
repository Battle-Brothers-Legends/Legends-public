::mods_hookExactClass("skills/actives/swing", function (o) {
	o.m.IsStaffSwing <- false;
	o.m.TilesLeft <- 2;
	o.m.TilesRight <- 0;

	o.getTooltip = function () {
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 3 targets"
		});
		return ret;
	}

	o.onAfterUpdate = function (_properties) {
		if (this.m.IsStaffSwing	&& ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
		}
		this.m.FatigueCostMult = ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_skill != this) {
			return;
		}

		if (!this.getItem().isWeaponType(::Const.Items.WeaponType.Sword)) {
			_properties.MeleeSkill += this.addHitChanceBonus(::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? 10 : -5);
		}
		else {
			_properties.MeleeSkill += this.addHitChanceBonus(::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? 0 : -5);
		} 
	}
});
