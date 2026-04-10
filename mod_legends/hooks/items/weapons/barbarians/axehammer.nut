::mods_hookExactClass("items/weapons/barbarians/axehammer", function(o) {	
	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Hammer/Axe, One-Handed";
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 5;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_03" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_03" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_03" + v;
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitShield, function (_skill)
			{
				_skill.m.IsHammer = true;
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function()
	{
		onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.ThrowAxe, function (_skill) {
			_skill.m.IsBackupAxe = true;
		}.bindenv(this));
	}

});
