::mods_hookExactClass("retinue/followers/alchemist_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.alchemist";
		this.m.Name = "Alchemy Tools";
		this.m.Description = "An Alchemist is knowledgeable in crafting all kinds of mysterious contraptions and concoctions from exotic ingredients when given access to taxidermist equipment, and uses less material to do so.";
		this.m.Image = "ui/campfire/legend_alchemist_01";
		this.m.Cost = 1250;
		this.m.Effects = [
			"Has a 25% chance of not consuming any crafting component used by you",
			"Unlocks \'Snake Oil\' recipe to earn money by crafting from various low tier components",
			"Allows you to refill bombs and flasks with ammunition"
		];

		this.addRequirement("Crafted 10 items", function() {
			return ::World.Statistics.getFlags().getAsInt("ItemsCrafted") >= 10;
		}, false, function( _r ) {
			_r.Count <- 10;
			_r.UpdateText <- function() {
				this.Text = "Crafted " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("ItemsCrafted")) + "/" + this.Count + " items"
			};
		});

		this.addSkillRequirement("Have at least one of the following backgrounds: Herbalist, Taxidermist, Druid, Alchemist", [
			"background.legend_herbalist",
			"background.legend_taxidermist",
			"background.legend_druid",
			"background.legend_commander_druid",
			"background.legend_alchemist",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

