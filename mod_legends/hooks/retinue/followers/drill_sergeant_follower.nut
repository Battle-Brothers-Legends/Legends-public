::mods_hookExactClass("retinue/followers/drill_sergeant_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.drill_sergeant";
		this.m.Name = "Training Dummies";
		this.m.Description = "Some are born to kill, but others need a little more encouragement and less risk to fully reach their potential, with supervision of course.";
		this.m.Image = "ui/campfire/legend_drill_01";
		this.m.Cost = 1750;
		this.m.Effects = [
			"Makes your mercenaries gain 20% more experience at level 1, with 2% less at each further level",
			"Makes mercenaries in reserve never lose mood from not taking part in battles"
		];

		this.addRequirement("Won 50 battles", function() {
			return ::World.Statistics.getFlags().getAsInt("BattlesWon") >= 50;
		}, true, function( _r ) {
			_r.Count <- 50;
			_r.UpdateText <- function() {
				this.Text = "Won at least " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("BattlesWon")) + "/" + this.Count + " battles"
			};
		});

		this.addSkillRequirement("Have at least one of the following backgrounds: Retired Soldier, Swordmaster, Sellsword, or Gladiator", [
			"background.retired_soldier",
			"background.swordmaster",
			"background.sellsword",
			"background.gladiator",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		], true);
	}

	o.onUpdate = function ()
	{
		if ("IsDisciplined" in this.World.Assets.m)
			this.World.Assets.m.IsDisciplined = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

