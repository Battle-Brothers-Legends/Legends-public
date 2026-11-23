::mods_hookExactClass("items/weapons/poleaxe", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function () {
		this.m.Icon = "weapons/melee/poleaxe_0" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/poleaxe_0" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_pollaxe_0" + this.m.Variant;
	}

	// o.onEquip = function () {
	// 	this.weapon.onEquip();
	// 	::Legends.Actives.grant(this, ::Legends.Active.Assault);
	// 	::Legends.Actives.grant(this, ::Legends.Active.Smite, function (_skill){
	// 		_skill.m.Icon = "skills/active_241.png";
	// 		_skill.m.IconDisabled = "skills/active_241_sw.png";
	// 		_skill.m.Overlay = "active_241";
	// 		_skill.m.IsPolearm = true;
	// 		_skill.m.DirectDamageMult = 0.4;
	// 	});
	// 	::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
	// 		_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
	// 	}.bindenv(this));
	// }
});
