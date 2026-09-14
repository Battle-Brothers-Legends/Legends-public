::mods_hookExactClass("items/weapons/polehammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 1600;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer | this.Const.Items.WeaponType.Polearm;
		this.setCategories("Hammer/Polearm, Two-Handed");
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/polehammer_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/polehammer_01" + v + ".png";
		this.m.ArmamentIcon = "icon_polehammer_01" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPryArmor, function (_skill) {
			_skill.m.IsPolearm = true;
		});
		::Legends.Actives.grant(this, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/legend_halberd_impale.png";
			_skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
			_skill.m.Overlay = "legend_halberd_impale";
			_skill.m.IsIgnoredAsAOO = true;
		}.bindenv(this));
	}
});
