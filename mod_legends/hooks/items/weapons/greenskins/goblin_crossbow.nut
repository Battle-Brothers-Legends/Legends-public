::mods_hookExactClass("items/weapons/greenskins/goblin_crossbow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A large and heavy crossbow with menacing spikes in front. More like a minitature ballista, it shoots stakes with enough force to knock back a target hit. Deals +100 damage to vampires.";
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_piercing_bolt_skill"));
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
	}
});
