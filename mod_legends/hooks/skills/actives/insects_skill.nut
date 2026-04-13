::mods_hookExactClass("skills/actives/insects_skill", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Icon = "skills/insects_square.png";
		this.m.IconDisabled = "skills/insects_square_bw.png";
		this.m.MaxLevelDifference = 8;
	}

	o.getTooltip <- function ()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-50%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-50%[/color] Ranged Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-50%[/color] Melee Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-50%[/color] Ranged Defense"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-50%[/color] Initiative"
			}
		];
	}

	o.isUsable <- function ()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().isEngagedInMelee();
	}
});
