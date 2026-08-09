::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.IsGreatSlash <- false;
	o.m.IsStaffSlash <- false;

	local create = o.create;
	o.create = function() {
		create();
		this.m.HitChanceBonus = 10;
	}
	
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

	o.onAfterUpdate = function( _properties ) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.MeleeSkill += 10;

			if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}

});
