::mods_hookExactClass("events/events/dlc2/hate_greenskins_event", function(o) {
	o.m.excludedTraits <- [
		"fear_greenskins",
		"hate_greenskins",
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
		if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;

		if (::Time.getVirtualTimeF() - ::World.Events.getLastBattleTime() > 30.0) //from 5
			return;

		local fallen = ::World.Statistics.getFallen();

		if (fallen.len() < 2)
			return;

		if (fallen[0].Time < ::World.getTime().Days || fallen[1].Time < ::World.getTime().Days)
			return;

		if (::World.Statistics.getFlags().getAsInt("LastCombatFaction") != ::World.FactionManager.getFactionOfType(::Const.FactionType.Orcs).getID() && ::World.Statistics.getFlags().getAsInt("LastCombatFaction") != ::World.FactionManager.getFactionOfType(::Const.FactionType.Goblins).getID())
			return;

		local brothers = ::World.getPlayerRoster().getAll();

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

		this.m.Casualty = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = 500;
	}
});
