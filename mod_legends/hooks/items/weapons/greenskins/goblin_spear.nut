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
		skillToAdd = this.new("scripts/skills/actives/slash")
		skillToAdd.m.isGlaiveSlash = true;
		this.addSkill(skillToAdd);
		local skill = this.new("scripts/skills/actives/spearwall");
		skill.m.BaseAttackName = "Glaive Slash";
		this.addSkill(skill);
	}
});
