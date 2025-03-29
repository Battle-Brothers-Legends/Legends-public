this.legend_arborthropy_injury <- this.inherit("scripts/skills/injury_permanent/legend_infected_injury", {
	m = {},
	function create()
	{
		this.legend_infected_injury.create();
		this.m.ID = "injury.legend_arborthropy";
		this.m.Name = "Arborthrope";
		this.m.Description = "This character is cursed with arborthropy and will transform into a schrat ";
		this.m.Effect = "scripts/skills/effects/legend_transformed_tree_effect";
	}

	function getTooltip()
	{
		local ret = this.legend_infected_injury.getTooltip();
		ret.push({
			id = 16,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will randomly transform into a schrat"
		});
		return ret;
	}

});

