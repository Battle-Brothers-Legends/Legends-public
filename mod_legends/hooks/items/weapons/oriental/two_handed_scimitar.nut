::mods_hookExactClass("items/weapons/oriental/two_handed_scimitar", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Cleaver, Two-Handed";
		this.m.Value = 3100;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 105;
		this.m.DirectDamageMult = 0.35;
		this.m.ShieldDamage = 0;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/two_handed_scimitar_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/two_handed_scimitar_01" + v + ".png";
		this.m.ArmamentIcon = "icon_two_handed_scimitar_01" + v;
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
