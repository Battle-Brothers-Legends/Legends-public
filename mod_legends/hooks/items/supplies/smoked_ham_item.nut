::mods_hookExactClass("items/supplies/smoked_ham_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. There are many ways to preserve food. This piece of ham has been treated in a smoking hut. Can be eaten in battle to provide up to 3 healing and fatigue recovery over ten turns, based on the amount remaining. Will be gradually used as provisions if left in the company stash.";
		this.m.Value = 90;
		this.m.Amount = 30.0;
		this.m.GoodForDays = 7;
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