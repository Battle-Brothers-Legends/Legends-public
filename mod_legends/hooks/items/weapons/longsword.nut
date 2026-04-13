::mods_hookExactClass("items/weapons/longsword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Description = "A long two-handed blade that makes for a versatile weapon, this longsword is the smaller and lighter of it\'s town cousins but is much more versatile.";
		this.m.IsAgainstShields = false;
		this.m.IsAoE = false;
		this.m.Value = 1700;
		this.m.ShieldDamage = 0;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
		this.m.Variants = [1,2,3];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		this.m.Icon = "weapons/melee/longsword_0" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/longsword_0" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_longsword_0" + this.m.Variant;
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsGreatSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Riposte);
		::Legends.Actives.grant(this, ::Legends.Active.Puncture, function (_skill) {
			_skill.m.IsHalfsword = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Hammer, function (_skill) {
			_skill.m.IsMordhau = true;
		}.bindenv(this));
	}

});
