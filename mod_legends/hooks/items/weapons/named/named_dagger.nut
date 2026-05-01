::mods_hookExactClass("items/weapons/named/named_dagger", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3,4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.m.AmmoCost = 1;
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.addSkill <- function( _skill ) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Stab)) {
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Stab, function (_skill) {
				_skill.m.IsBackstab = true;
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}

	o.randomizeValues <- function ()
	{
		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
		named_weapon.randomizeValues();
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Deathblow);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendThrowKnife);
	}
});
