::mods_hookExactClass("items/weapons/legendary/obsidian_dagger", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Condition = 95.0;
		this.m.ConditionMax = 95.0;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.15;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		this.addSkill(this.new("scripts/skills/actives/deathblow_skill"));
	}
});
