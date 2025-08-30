::mods_hookExactClass("items/weapons/pitchfork", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Pitchfork;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/pitchfork_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/pitchfork_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_pitchfork_01_" + this.m.Variant;
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
