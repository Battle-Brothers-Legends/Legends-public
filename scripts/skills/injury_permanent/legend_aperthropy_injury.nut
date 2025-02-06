this.legend_aperthropy_injury <- this.inherit("scripts/skills/injury_permanent/legend_infected_injury", {
	m = {},
	function create()
	{
		this.legend_infected_injury.create();
		this.m.ID = "injury.legend_aperthropy";
		this.m.Name = "Aperthrope";
		this.m.Description = "This character is cursed with aperthropy and will transform into a boar ";
		this.m.Icon = "ui/injury/injury_aperthropy.png";
		this.m.Effect = "scripts/skills/effects/legend_transformed_boar_effect";
	}

	function getTooltip()
	{
		local ret = this.legend_infected_injury.getTooltip();
		ret.push({
			id = 16,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When transformed you will lose control of them, they will drop all their items and turn into a boar, with the ability to Charge and Gore. Their Stamina will triple, Health with double and Resolve will increase by 25%."
		});
		return ret;
	}

});

