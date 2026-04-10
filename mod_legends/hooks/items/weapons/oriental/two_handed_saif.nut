::mods_hookExactClass("items/weapons/oriental/two_handed_saif", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2700;
		this.m.Categories = "Cleaver, Two-Handed";
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Condition = 62.0;
		this.m.ConditionMax = 62.0;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.35;
	}

	o.updateVariant <- function() {
		if (this.getVariant() == 0) {
			this.m.Icon = "weapons/melee/two_handed_saif_70x70.png";
			this.m.IconLarge = "weapons/melee/two_handed_saif.png";
			this.m.ArmamentIcon = "icon_two_handed_saif_01";
		} else {
			this.m.Icon = "weapons/melee/two_handed_saif_01_" + this.getVariant() + "_70x70.png";
			this.m.IconLarge = "weapons/melee/two_handed_saif_01_" + this.getVariant() + ".png";
			this.m.ArmamentIcon = "icon_two_handed_saif_01_" + this.getVariant();
		}
	}

	o.onEquip = function ()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsTwoHand = true;
		}.bindenv(this));
	}
});
