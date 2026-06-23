::mods_hookExactClass("skills/perks/perk_shield_bash", function(o) {
	o.m.PossibleSkills <- [
		::Legends.Actives.getID(::Legends.Active.KnockBack),
		::Legends.Actives.getID(::Legends.Active.LegendPush),
	];

	local create = o.create;
	o.create = function() {
		create();
		m.ID = "perk.shield_bash_legend"; // change id for greater purpose
	}

	o.onTriggeredMovement = function(_skill, _targetEntity, _hitInfo) {
		if (_skill != null && _skill.getID() in this.m.PossibleSkills) {
			local p = this.getContainer().getActor().getCurrentProperties();
			local damage = this.Math.rand(10, 25) * p.DamageTotalMult;
			_hitInfo.DamageRegular += damage * p.DamageRegularMult;
			_hitInfo.DamageFatigue += 10;
			_hitInfo.DamageArmor += this.Math.floor(damage * 0.5);
		}
	}
});
