::mods_hookExactClass("items/weapons/dagger", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
		this.m.AmmoCost = 1;
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
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

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/dagger_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/dagger_01" + v + ".png";
		this.m.ArmamentIcon = "icon_dagger_01" + v;
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
