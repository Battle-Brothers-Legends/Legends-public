::mods_hookExactClass("retinue/followers/negotiator_follower", function(o)  {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.negotiator";
		this.m.Name = "Meeting Point";
		this.m.Description = "Having a dedicated meeting place where negotiators can talk, barter and trade insults with prominent figures or their lackeys can help in finding work.";
		this.m.Image = "ui/campfire/legend_negotiator_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Allows for more rounds of contract negotiations and greater payment with your potential employers before they abort, and with only a 10% chance on a hit to relations. Bad relations recover faster"
			//"Greater contract payment if negotiations are successful and makes good relations with any faction decay slower and bad relations recover faster"
		];

		this.addRequirement("Negotiated for the payment of contracts x times", function() {
			return ::World.Statistics.getFlags().getAsInt("NegotiatingTries") >= 10;
		}, true, function( _r ) {
			_r.Count <- 10;
			_r.UpdateText <- function() {
				this.Text = "Negotiated for the payment of contracts " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("NegotiatingTries")) + "/" + this.Count + " times (attempts only be counted after accepting the contract)"
			};
		});

		this.addSkillRequirement("Have someone with the Pacifist perk. Guaranteed on Widow, Inventor, Tailor and many others", [
			::Legends.Perks.getID(::Legends.Perk.LegendPacifist),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		], true);
	}

	o.onUpdate = function ()
	{
		if ("NegotiationAnnoyanceMult" in this.World.Assets.m)
			this.World.Assets.m.NegotiationAnnoyanceMult = 0.5;
		if ("AdvancePaymentCap" in this.World.Assets.m)
			this.World.Assets.m.AdvancePaymentCap = 0.75;

		if ("RelationDecayGoodMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves") {
				this.World.Assets.m.RelationDecayGoodMult = 1.075;
			} else {
				this.World.Assets.m.RelationDecayGoodMult = 0.85;
			}
		}
		if ("RelationDecayBadMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves") {
				this.World.Assets.m.RelationDecayBadMult = 0.925;
			} else {
				this.World.Assets.m.RelationDecayBadMult = 1.15;
			}
		}
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

