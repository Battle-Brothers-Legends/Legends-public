::mods_hookExactClass("skills/actives/prong_skill", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.HitChanceBonus = 20;
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();
		if (!::Legends.Weapons.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return tooltip;
	}

	o.onAfterUpdate = function (_properties) {
		if (::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_skill == this) {
			_properties.MeleeSkill += 20;

			if (_targetEntity != null && !::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				_properties.MeleeSkill -= 15;
				this.m.HitChanceBonus -= 5;
			}
		}
	}
});
