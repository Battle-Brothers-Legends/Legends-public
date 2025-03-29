// Help calculate damage on magic attacks
this.legend_magic_attack_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {
		BaseDamageRegularMin = 0,
		BaseDamageRegularMax = 0,
		DamageArmorMult = 0.0,
		DamageRegularMin = 0,
		DamageRegularMax = 0
	},

	function create() {
		this.legend_magic_skill.create()
	}

	// Return damage range as a length 5 array
	// [Min Regular Damage, Max Regular Damage,
	//  Min Armor Damage, Max Armor Damage,
	//  Max Direct Damage]
	function getDamageRange() {
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();

		local regularDamageMin = this.Math.floor(this.m.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult);
		local regularDamageMax = this.Math.floor(this.m.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult);
		local armorDamageMin = this.Math.floor(this.m.DamageRegularMin * this.m.DamageArmorMult * p.DamageTotalMult);
		local armorDamageMax = this.Math.floor(this.m.DamageRegularMax * this.m.DamageArmorMult * p.DamageTotalMult);
		local directDamageMax = this.Math.floor(this.m.DamageRegularMax * this.m.DirectDamageMult);

		return [regularDamageMin, regularDamageMax, armorDamageMin, armorDamageMax, directDamageMax]
	}

	function setDamage() {
		this.m.DamageRegularMin = this.m.BaseDamageRegularMin + this.getResolveScaling();
		this.m.DamageRegularMax = this.m.BaseDamageRegularMax + this.getResolveScaling();
	}

});