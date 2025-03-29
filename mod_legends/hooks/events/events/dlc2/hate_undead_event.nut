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
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "") {

			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Unhold)
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
