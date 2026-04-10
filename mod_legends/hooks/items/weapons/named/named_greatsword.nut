::mods_hookExactClass("items/weapons/named/named_greatsword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Description = "A long two-handed greatsword as good for crushing as for cutting, it has a good balance between the lighter longsword and heavier zweihander.";
		this.m.Variants = [1,2,3,4,5,6];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.randomizeValues <- function ()
	{
		this.m.Value = 3800;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 10;
		named_weapon.randomizeValues();
	}

	o.updateVariant <- function() {
		this.m.Icon = "weapons/melee/named_greatsword_0" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/named_greatsword_0" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_named_greatsword_0" + this.m.Variant;
	}

	o.onEquip = function () {
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.OverheadStrike);
		::Legends.Actives.grant(this, ::Legends.Active.Swing);
		::Legends.Actives.grant(this, ::Legends.Active.Puncture, function (_skill) {
			_skill.m.IsHalfsword = true;
			_skill.m.IsGreatHalfsword = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Hammer, function (_skill) {
			_skill.m.IsMordhau = true;
			_skill.m.IsGreatMordhau = true;
		}.bindenv(this));
	}
});
