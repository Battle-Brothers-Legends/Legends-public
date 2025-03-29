this.legend_ursathropy_injury <- this.inherit("scripts/skills/injury_permanent/legend_infected_injury", {
	m = {},
	function create()
	{
		this.legend_infected_injury.create();
		this.m.ID = "injury.legend_ursathropy";
		this.m.Name = "Ursathrope";
		this.m.Description = "This character is cursed with ursathropy and will transform into a bear ";
		this.m.Icon = "ui/injury/injury_ursathropy.png";
		this.m.Effect = "scripts/skills/effects/legend_transformed_bear_effect";
	}

	function getTooltip()
	{
		local ret = this.legend_infected_injury.getTooltip();
		ret.push({
			id = 16,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When transformed you will lose control of them, they will drop all their items and turn into a bear."
		});
		return ret;
	}

});

