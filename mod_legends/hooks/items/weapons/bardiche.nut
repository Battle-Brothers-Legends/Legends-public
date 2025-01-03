::mods_hookExactClass("items/weapons/bardiche", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsAoE = true;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		local skill = this.new("scripts/skills/actives/swing");
		skill.setApplyAxeMastery(true);
		this.addSkill(skill);
	}
});
