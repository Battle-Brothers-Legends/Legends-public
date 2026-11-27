::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.IsGreatSlash <- false;
	o.m.IsStaffSlash <- false;

	o.setItem <- function (_item) {
		this.skill.setItem(_item);
		if (this.m.IsGreatSlash) {
			this.m.Name = "Great Slash";
			this.m.Description = "A hefty swift slashing attack dealing average damage.";
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
			this.m.ActionPointCost = this.m.IsStaffSlash ? 5 : 4;
		}
	}

	o.getTooltip = function () {
		return this.getDefaultTooltip();
	}

	o.onAfterUpdate = function( _properties ) {
		this.m.FatigueCostMult = ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this && !this.getItem().isWeaponType(::Const.Items.WeaponType.Sword)) {
			_properties.MeleeSkill += this.addHitChanceBonus(::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? 15 : 10);
		}
		else {
			_properties.MeleeSkill += this.addHitChanceBonus(10);
		}
	}

});
