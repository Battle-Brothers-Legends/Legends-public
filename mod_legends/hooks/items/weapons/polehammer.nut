::mods_hookExactClass("items/weapons/polehammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 1600;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/polehammer_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/polehammer_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_polehammer_01_" + this.m.Variant;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPryArmor, function (_skill) {
			_skill.m.FatigueCost = 35;
			_skill.m.ActionPointCost = 6;
			_skill.m.Icon = "skills/legend_active_pry_armor_polehammer.png";
			_skill.m.IconDisabled = "skills/legend_active_pry_armor_polehammer_bw.png";
			_skill.m.Overlay = "active_legend_pry_armor_polehammer";
		});
		::Legends.Actives.grant(this, ::Legends.Active.Impale, function (_skill) {
			_skill.m.Icon = "skills/legend_halberd_impale.png";
			_skill.m.IconDisabled = "skills/legend_halberd_impale_bw.png";
			_skill.m.Overlay = "legend_halberd_impale";
			_skill.m.IsIgnoredAsAOO = true;
		}.bindenv(this));
	}
});
