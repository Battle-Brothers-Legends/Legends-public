::mods_hookExactClass("retinue/followers/trader_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.trader";
		this.m.Name = "Secure Chests";
		this.m.Description = "While not common, some companies have special goods stashed away to tell on the road to travellers. These goods are always kept in the most fortified chests the company has to offer, to prevent prying fingers from outside and inside the camp.";
		this.m.Image = "ui/campfire/legend_trader_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Increases the amount of trade goods for sale by 1 for each location that produces them, like salt near salt mines, allowing you to trade at higher volumes"
		];

		this.addRequirement("Sold 25 trade goods", function() {
			return ::World.Statistics.getFlags().getAsInt("TradeGoodsSold") >= 25;
		}, false, function( _r ) {
			_r.Count <- 25;
			_r.UpdateText <- function() {
				this.Text = "Sold " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("TradeGoodsSold")) + "/" + this.Count + " trade goods"
			};
		});

		this.addSkillRequirement("Have at least one of the following backgrounds: Caravan Hand, Peddler, Trader, Donkey", [
			"background.caravan_hand",
			"background.legend_trader",
			"background.legend_commander_trader",
			"background.legend_donkey",
			"background.peddler",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

