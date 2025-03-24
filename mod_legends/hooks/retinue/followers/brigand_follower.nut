::mods_hookExactClass("retinue/followers/brigand_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.brigand";
		this.m.Name = "Stolen Documents";
		this.m.Description = "The nobles and merchants are sloppy with their security and their underlings are easily intimidated. A well placed bribe, brawl or a set of light fingers can keep you informed on who is taking what where.";
		this.m.Image = "ui/campfire/legend_brigand_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"Makes you see the position of some caravans at all times and even if outside your sight radius",
			"Allows you to see up to 3 of the most valuable items that are being transporting by caravans"
		];

		this.addRequirement("Raided at least 3 caravans", function() {
			return ::World.Statistics.getFlags().getAsInt("CaravansRaided") >= 3;
		}, true, function( _r ) {
			_r.Count <- 3;
			_r.UpdateText <- function() {
				this.Text = "Raided " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("CaravansRaided")) + "/" + this.Count + " caravans"
			};
		});

		this.addSkillRequirement("Have at least one of the following backgrounds: Raider, Barbarian, Deserter", [
			"background.raider",
			"background.barbarian",
			"background.deserter",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		], true);
	}

	o.onUpdate = function ()
	{
		if ("IsBrigand" in this.World.Assets.m)
			this.World.Assets.m.IsBrigand = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

