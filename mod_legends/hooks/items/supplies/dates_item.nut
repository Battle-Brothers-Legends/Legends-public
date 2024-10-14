::mods_hookExactClass("items/supplies/dates_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Name = "Dried Dates";
		this.m.Description = "Provisions. Dried dates are common in the south. These sweet, dried fruits are high energy and well preserved. They are dried to preserve them longer. Can be eaten in battle to provide up to 2 healing and fatigue recovery over ten turns, based on the amount remaining. Will be used as provisions if left in the company stash.";
		this.m.Amount = 20.0;
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