::mods_hookExactClass("items/supplies/fermented_unhold_heart_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Once a delicacy for barbarian kings of the north who wished to embolden their virility, fermented unhold heart tastes distinctively awful.";
		this.m.IsUndesirable = true;
		this.m.Amount = 40.0;
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
