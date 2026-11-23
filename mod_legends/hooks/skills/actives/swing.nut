::mods_hookExactClass("skills/actives/swing", function(o)
{
	o.m.IsStaffSwing <- false;

	local create = o.create;
	o.create = function() {
		create();
		this.m.HitChanceBonus = -5;
	}

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

	o.onAfterUpdate = function ( _properties ) {
		if (this.m.IsStaffSwing && ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
		}
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.MeleeSkill -= 5;
			if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}
});
