::mods_hookExactClass("items/weapons/light_crossbow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.RangeMax = 5;
		this.m.RangeIdeal = 5;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/ranged/crossbow_02_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/crossbow_02_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_crossbow_02_" + this.m.Variant;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingBolt);
		::Legends.Actives.grant(this, ::Legends.Active.LegendStrafingRun);
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.IsRangedKnockOut = true;
		}.bindenv(this));
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
	}
});
