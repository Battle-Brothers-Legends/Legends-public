::mods_hookExactClass("items/weapons/oriental/swordlance", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Cleaver/Polearm, Two-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.m.Value = 1700;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/swordlance_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/swordlance_01" + v + ".png";
		this.m.ArmamentIcon = "icon_swordlance_01" + v;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Strike))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Cleave, function (_skill)
			{
				_skill.m.Icon = "skills/active_200.png";
				_skill.m.IconDisabled = "skills/active_200_sw.png";
				_skill.m.Overlay = "active_200";
				_skill.m.IsScytheCleave = true;
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsScytheDecapitate = true;
		}.bindenv(this));
	}
});
