this.arena_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.arena";
		this.m.Name = "Gladiator's Tools";
		this.m.Description = "Winning fights in the arena can be tough, however with these tools one can entertain the croud for many more hours.";
		this.m.Image = "ui/campfire/legend_blacksmith_01";
		this.m.Cost = 3250;
		this.m.Effects = [
			"Increase winnings from the arena by 25%",
			"Fight up to 3 arena matches per day"
		];
		this.addRequirement("Triumph in 5 arena fights ", function() {
			return ::World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 5;
		});
	}

	function onUpdate()
	{
		::World.Assets.m.IsArenaTooled = true;
	}


});
