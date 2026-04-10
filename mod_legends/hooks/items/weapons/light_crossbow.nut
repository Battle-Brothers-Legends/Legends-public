::mods_hookExactClass("items/weapons/light_crossbow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.RangeMax = 5;
		this.m.RangeIdeal = 5;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/crossbow_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/crossbow_02" + v + ".png";
		this.m.ArmamentIcon = "icon_crossbow_02" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendStrafingRun);
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.IsRangedKnockOut = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.ReloadBolt);
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
	}
});
