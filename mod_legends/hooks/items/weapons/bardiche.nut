::mods_hookExactClass("items/weapons/bardiche", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsAoE = true;
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
	}

	o.updateVariant <- function ()
	{
		this.m.IconLarge = "weapons/melee/bardiche_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/bardiche_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_bardiche_0" + this.m.Variant;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Swing, function (_skill) {
			_skill.setApplyAxeMastery(true);
		}.bindenv(this));
	}
});
