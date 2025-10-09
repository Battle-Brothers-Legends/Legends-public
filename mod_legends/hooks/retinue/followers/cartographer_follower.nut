::mods_hookExactClass("retinue/followers/cartographer_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.cartographer";
		this.m.Name = "Mapping Supplies";
		this.m.Description = "Learning to read is a rare skill and can take some a lifetime to master. Reading maps on the other head can be a little less taxing on the average mercenary. Giving the best and brightest of the company what they need to draw could prove useful.";
		this.m.Image = "ui/campfire/legend_cartographer_01";
		this.m.Cost = 1250;
		this.m.Effects = [
			"Pays you between 100 and 400 crowns for every location you discover on your own. The further away from civilization, the more you\'re paid. Legendary locations pay double."
		];

		this.addRequirement("Discovered a legendary location", function() {
			return ::World.Flags.getAsInt("LegendaryLocationsDiscovered") >= 1;
		});

		this.addSkillRequirement("Have at least one of the following backgrounds: Adventurous Noble/Lady, Noble Commander, Philosopher, Historian", [
			"background.adventurous_noble",
			"background.historian",
			"background.legend_philosopher",
			"background.legend_commander_noble",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onLocationDiscovered = function ( _location )
	{
		local settlements = this.World.EntityManager.getSettlements();
		local dist = 9999;

		foreach( s in settlements )
		{
			local d = s.getTile().getDistanceTo(_location.getTile());

			if (d < dist)
			{
				dist = d;
			}
		}

		local reward = this.Math.min(400, this.Math.max(100, 10 * dist));

		if (_location.isLocationType(this.Const.World.LocationType.Unique))
		{
			reward = reward * 2;
		}

		this.World.Assets.addMoney(reward);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

