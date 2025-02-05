this.legend_lycanthropy_injury <- this.inherit("scripts/skills/injury_permanent/legend_infected_injury", {
	m = {},
	function create()
	{
		this.legend_infected_injury.create();
		this.m.ID = "injury.legend_lycanthropy";
		this.m.Name = "Lycanthrope";
		this.m.Description = "This character is cursed with lycanthropy and will transform into a wolf, dropping all gear and attacking wildly unless controlled. It is rumoured wolfsbane may help.";
		this.m.Icon = "ui/injury/injury_lycanthropy.png";
		this.m.Effect = "scripts/skills/effects/legend_transformed_wolf_effect";
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

