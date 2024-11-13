::mods_hookExactClass("items/supplies/fermented_unhold_heart_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Various kinds of grounded grain that will be cooked up with water or milk for a daily meal. It is satiating but tasteless. Can be eaten in battle to provide up to 1 healing and fatigue recovery over ten turns, based on the amount remaining. Will be gradually used as provisions if left in the company stash.";
		this.m.IsUndesirable = true;
		this.m.Amount = 40.0;
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
