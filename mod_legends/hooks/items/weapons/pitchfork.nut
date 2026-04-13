::mods_hookExactClass("items/weapons/pitchfork", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Pitchfork;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/pitchfork_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/pitchfork_01" + v + ".png";
		this.m.ArmamentIcon = "icon_pitchfork_01" + v;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/active_57.png";
			_skill.m.IconDisabled = "skills/active_57_sw.png";
			_skill.m.Overlay = "active_57";
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker, function (_skill) {
			_skill.m.IsPolearm = true;
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Repel, function (_skill) {
			_skill.m.Icon = "skills/active_58.png";
			_skill.m.IconDisabled = "skills/active_58_sw.png";
			_skill.m.Overlay = "active_58";
		}.bindenv(this));
	}

});
