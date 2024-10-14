::mods_hookExactClass("items/supplies/dried_lamb_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Dried Lamb is a speciality and a highy sought-after food in the south. A real treat for any hungry mercenary. Can be eaten in battle to provide up to 3 healing and fatigue recovery over ten turns, based on the amount remaining. Will be used as provisions if left in the company stash.";
		this.m.Amount = 30.0;
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.legend_usable_food.onEquip();
		local skill = this.new("scripts/skills/actives/legend_eat_rations_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});