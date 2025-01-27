::mods_hookExactClass("items/weapons/greenskins/goblin_spear", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A long shaft with a sharp metal blade at the top.";
		this.m.Value = 500;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
	}

	o.onEquip = function ()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.isGlaiveSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Spearwall, function (_skill) {
			_skill.m.BaseAttackName = "Glaive Slash";
		}.bindenv(this));
	}
});
