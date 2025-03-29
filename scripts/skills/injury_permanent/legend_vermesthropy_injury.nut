this.legend_vermesthropy_injury <- this.inherit("scripts/skills/injury_permanent/legend_infected_injury", {
	m = {},
	function create()
	{
		this.legend_infected_injury.create();
		this.m.ID = "injury.legend_vermesthropy";
		this.m.Name = "Vermesthrope";
		this.m.Description = "This character is cursed with vermesthropy and will transform into a rat, dropping all gear and attacking wildly unless controlled.";
		this.m.Icon = "ui/injury/injury_vermesthropy.png";
		this.m.Effect = "scripts/skills/effects/legend_transformed_rat_effect";
	}

	function getTooltip()
	{
		local ret = this.legend_infected_injury.getTooltip();
		ret.push({
			id = 16,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When transformed you will lose control of them, they will drop all their items and turn into a rat, with a poisonous Bite and Claws. They will gain 2 action points, and they will gain 25 melee defense while retreating, but their resolve will halve."
		});
		return ret;
	}

});

