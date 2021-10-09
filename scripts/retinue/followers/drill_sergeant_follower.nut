this.drill_sergeant_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.drill_sergeant";
		this.m.Name = "Training Dummies";
		this.m.Description = "Some are born to kill, but others need a little more encouragement and less risk to fully reach their potential, with supervision of course.";
		this.m.Image = "ui/campfire/legend_drill_01";
		this.m.Cost = 1750;
		this.m.Effects = [
			"Makes your men gain 20% more experience at level 1, with 2% less at each further level",
			"Makes men in reserve never lose mood from not taking part in battles"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have a Retired Soldier, Swordmaster, Sellsword, or Gladiator with an injury in your company"
			}
		];
	}

	function onUpdate()
	{
		if ("IsDisciplined" in this.World.Assets.m)
			this.World.Assets.m.IsDisciplined = true;
	}

	function onEvaluate()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		local availableBGs = [
			"background.retired_soldier",
			"background.swordmaster",
			"background.sellsword",
			"background.gladiator"
		];

		foreach( bro in brothers )
		{
			local id = bro.getBackground().getID();
			
			if (availableBGs.find(id) != null)
			{
				if (bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury) || bro.getSkills().hasSkillOfType(this.Const.SkillType.Injury))
				{
					this.m.Requirements[0].IsSatisfied = true;
					return;
				}
			}
		}	
	}

});

