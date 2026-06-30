::mods_hookExactClass("events/events/dlc2/hate_undead_event", function(o) {
	o.m.excludedTraits <- [
		"fear_undead",
		"hate_undead",
		"dastard",
		"craven",
		"fainthearted",
		"weasel"
	];

	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "%image%{%brother% spits and runs %their_casualty% hand under %their_casualty% nose. %Their_casualty% face scowls and %they_casualty% seems to be talking to %themselves_casualty% as others look on.%SPEECH_ON%The old gods will have our arses if we permit the dead to walk again! You fellas can go to the hereafter thinking you did right in this world, but I ain\'t following the idle road cause by my sum that road goes straight to the hells. I\'ll see to it that I meet a righteous end, and I\'ll see to that by felling every godforsaken undead fark I see!%SPEECH_OFF%}";
		});
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 30.0) //from 5
			return;

		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
			return;

		if (fallen[0].Time < this.World.getTime().Days || fallen[1].Time < this.World.getTime().Days)
			return;

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID() && this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID())
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() < 3)
				return;
			foreach (trait in this.m.excludedTraits)
				if (bro.getSkills().hasSkill("trait." + trait))
					continue;
			candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 500;
	}
});
