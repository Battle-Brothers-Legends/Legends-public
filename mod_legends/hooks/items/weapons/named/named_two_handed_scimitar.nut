::mods_hookExactClass("items/weapons/named/named_two_handed_scimitar", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
		this.m.Value = 4100;
		this.m.Categories = "Cleaver, Two-Handed";
	}

	o.randomizeValues <- function ()
	{
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 105;
		this.m.DirectDamageMult = 0.35;
		this.m.ShieldDamage = 0;
		named_weapon.randomizeValues();
	}

	o.onEquip = function ()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsTwoHand = true;
		}.bindenv(this));
	}
});
