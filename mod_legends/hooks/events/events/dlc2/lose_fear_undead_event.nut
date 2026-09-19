::mods_hookExactClass("events/events/dlc2/lose_fear_undead_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "") {

			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (!::Const.DLC.Unhold)
			return;

		if (::World.Statistics.getFlags().getAsInt("LastCombatFaction") != ::World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getID() && ::World.Statistics.getFlags().getAsInt("LastCombatFaction") != ::World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getID())
			return;

		if (::Time.getVirtualTimeF() - ::World.Events.getLastBattleTime() > ::World.getTime().SecondsPerDay * 1.0)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];
		local candidates_other = [];

		foreach( bro in brothers ) {
			if (!bro.getSkills().hasTrait(::Legends.Trait.FearUndead) || bro.getLifetimeStats().Battles < 25 || bro.getLifetimeStats().Kills < 50 || bro.getLifetimeStats().BattlesWithoutMe != 0)
				candidates_other.push(bro);
			else
				candidates.push(bro);
		}

		if (candidates.len() == 0 || candidates_other.len() == 0)
			return;

		this.m.Casualty = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Other = candidates_other[::Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = this.m.Casualty.getLifetimeStats().Kills / 10;
	}
});
