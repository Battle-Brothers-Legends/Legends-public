::mods_hookExactClass("items/weapons/greenskins/goblin_falchion", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.setVariant(this.Math.rand(0, 1));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/goblin_weapon_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/goblin_weapon_02" + v + ".png";
		this.m.ArmamentIcon = "icon_goblin_weapon_02" + v;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash)) {
			::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendBreach, function (_skill) {
				_skill.m.Icon = "skills/active_78.png";
				_skill.m.IconDisabled = "skills/active_78_sw.png";
				_skill.m.Overlay = "active_78";
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Gash);
	}

});
