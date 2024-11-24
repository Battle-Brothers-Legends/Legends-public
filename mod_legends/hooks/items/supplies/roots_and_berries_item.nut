::mods_hookExactClass("items/supplies/roots_and_berries_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Name = "Dried Roots and Berries";
		this.m.Description = "Provisions. Dried roots and berries are not the most exciting of rations but easy to come by and durable. Can be eaten in battle to provide up to 1 healing and fatigue recovery over ten turns, based on the amount remaining. Will be gradually used as provisions if left in the company stash.";
		this.m.Icon = "supplies/legend_dried_roots_and_berries.png";
		this.m.Amount = 15.0;
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.food_item.onEquip();
		local skill = this.new("scripts/skills/actives/legend_eat_rations_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});