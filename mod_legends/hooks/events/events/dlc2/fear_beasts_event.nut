::mods_hookExactClass("events/events/dlc2/fear_beasts_event", function(o) {
	o.m.excludedBackgrounds <- [
		"companion",
		"beast_slayer",
		"hunter",
		"witchhunter",
		"wildman",
		"wildwoman",
		"hedge_knight"
	];
	o.m.excludedTraits <- [
		"fear_beasts",
		"hate_beasts",
		"fearless",
		"brave",
		"determined",
		"bloodthirsty"
	];

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]{%brother% is carving a rabbit into a piece of bark. It\'s shaping up nicely until the whole thing is angrily thrown into the campfire.%SPEECH_ON%Oh who the fark am I kidding? I wish I was out here hunting game! But this ain\'t game, these are monsters! Creatures of the night! Bullshit, all of it, where\'d they even come from? Well I tell you what, I ain\'t gonna be killed by one of them things! Not a farking chance!%SPEECH_OFF%The rest of the company stares as %brother% comes down from the outburst. %brother% quietly sits watching the rabbit carving churn and burn.}";
				s.Options[0].Text = "This is taking a toll on the mercenaries."
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Unhold)
			return;

		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
			return;

		if (fallen[0].Time < this.World.getTime().Days || fallen[1].Time < this.World.getTime().Days)
			return;

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID())
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() > 7)
				continue;

			foreach (background in this.m.excludedBackgrounds)
				if (bro.getBackground().getID() == "background." + background)
					continue;

			foreach (trait in this.m.excludedTraits)
				if (bro.getSkills().hasSkill("trait." + trait))
					continue;

			candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 50;
	}
});
