this.legend_infected_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {
		Effect = "",
		Chance = 100
	},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.legend_vermesthropy";
		this.m.Name = "Vermesthrope";
		this.m.Description = "This character is cursed with vermesthropy and will transform into a rat, dropping all gear and attacking wildly unless controlled.";
		this.m.Icon = "ui/injury/injury_vermesthropy.png";
	}

	function getTooltip()
	{
	 	local day = this.World.getTime().Days;
		local month = day / 28;
		local monthfloor = this.Math.floor(month);
		local ret = [
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
				id = 30,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The infection has unlocked a new set of perks which help manage the disease. These perks will give you control over their transformations, and let them wield weapons and armor while transformed."
			}
		];
		this.addTooltipHint(ret);

		if (this.World.getTime().IsDaytime && month != monthfloor)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "10% chance to transform per turn during battle in daylight."
			});
		}

		if (!this.World.getTime().IsDaytime && month != monthfloor)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "20% chance to transform per turn during battle at night."
			});
		}

		if (month == monthfloor)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "it is currently a full moon, the transformation will happen during any battle tonight"
			});
		}

		return ret;
	}

	function onUpdate( _properties )
	{
	}

	function onApplyAppearance()
	{
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasEffect(::Legends.Effect.LegendWolfsbane))
		{
			return;
		}

		if (actor.getSkills().hasPerk(::Legends.Perk.LegendMasterAnger))
		{
			return;
		}

		local validSkills = [
			"effect.legend_transformed_wolf",
			"effect.legend_transformed_bear",
			"effect.legend_transformed_boar",
			"effect.legend_transformed_rat"
		];

		foreach (s in validSkills)
		{
			if (actor.getSkills().hasSkill(s))
			{
				return;
			}
		}

		local r = this.Math.rand(1, this.m.Chance);
		local day = this.World.getTime().Days;

		//DEBUG TO ALWAYS ENABLE
		// actor.getSkills().add(this.new(this.m.Effect));
		// return

		//Always turn on full moon
		if (day % 28 == 0)
		{
			actor.getSkills().add(this.new(this.m.Effect));
			return;
		}

		//50% chance to turn at night
		if (!this.World.getTime().IsDaytime)
		{
			if (r <= 0.5 * this.m.Chance)
			{
				actor.getSkills().add(this.new(this.m.Effect));
			}
		}
		//10% chance to turn during daytime
		else if (r <= (0.1 * this.m.Chance))
		{
			actor.getSkills().add(this.new(this.m.Effect));
		}

	}

});

