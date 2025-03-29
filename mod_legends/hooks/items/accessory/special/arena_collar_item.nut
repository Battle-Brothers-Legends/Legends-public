::mods_hookExactClass("items/accessory/special/arena_collar_item", function(o) {
	o.m.affectedSkills <- ["legend_leap_skill", "legend_climb_skill", "legend_levitating_skill"];

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local result = getTooltip();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Disables specific skills than can be used to scale the arena walls when worn."
		});
		return result;
	}

	o.onEquip <- function ()
	{
		local skills = this.getContainer().getActor().getSkills();
		foreach (skill in this.m.affectedSkills)
		{	
			if (skills.hasSkill("actives." + skill))
			{
				skills.removeByID("actives." + skill);
			}
		}
	}

	o.onUnequip <- function ()
	{
		local skills = this.getContainer().getActor().getSkills();
		foreach (skill in this.m.affectedSkills)
		{	
			if (skills.hasSkill("perk." + skill))
			{
				skills.add(this.new("scripts/skills/actives/" + skill));
			}
		}
	}
});