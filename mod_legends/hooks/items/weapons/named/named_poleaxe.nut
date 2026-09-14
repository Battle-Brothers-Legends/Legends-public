::mods_hookExactClass("items/weapons/named/named_poleaxe", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
		this.m.Variants = [1, 2]; // there's 2 more of these but the quality gap is big
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
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
