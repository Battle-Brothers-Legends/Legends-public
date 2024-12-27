::mods_hookExactClass("items/weapons/named/named_goblin_spear", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A masterfully crafted goblin glaive. Accurate, fast and deadly in the hands of any skilled fighter.";
		this.m.Value = 2500;
	}

	o.randomizeValues <- function ()
	{
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;

		named_weapon.randomizeValues();
	}

	o.onEquip = function ()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_glaive_slash_skill"));
		local skill = this.new("scripts/skills/actives/spearwall");
		skill.m.BaseAttackName = "Glaive Slash";
		this.addSkill(skill);
	}
	
});
