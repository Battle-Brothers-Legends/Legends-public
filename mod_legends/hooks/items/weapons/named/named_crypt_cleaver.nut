::mods_hookExactClass("items/weapons/named/named_crypt_cleaver", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.IsAgainstShields = false;
		this.m.Value = 3950;
	}

	o.randomizeValues <- function () {
		this.m.Condition = 52.0;
		this.m.ConditionMax = 52.0;
		this.m.StaminaModifier = -19;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 95;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.35;
		this.m.ShieldDamage = 0;
		this.named_weapon.randomizeValues();
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsTwoHand = true;
		}.bindenv(this));
	}
});
