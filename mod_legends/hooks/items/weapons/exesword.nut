::mods_hookExactClass("items/weapons/exesword", function (o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.Categories = "Cleaver, Two-Handed";
		this.m.IsAgainstShields = false;
		this.m.Value = 3300;
		this.m.ShieldDamage = 0;
		this.m.Variants = [1];
		this.m.StaminaModifier = -18;
		this.m.ShieldDamage = 0;
		this.m.ArmorDamageMult = 1.2;

		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function () {
		this.m.Icon = "weapons/melee/sword_exe_0" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_exe_0" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_sword_exe_0" + this.m.Variant;
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew, function (_skill) {
			_skill.m.Icon = "skills/active_239.png";
			_skill.m.IconDisabled = "skills/active_239_sw.png";
			_skill.m.Overlay = "active_239";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsTwoHand = true;
		}.bindenv(this));
	}
});
