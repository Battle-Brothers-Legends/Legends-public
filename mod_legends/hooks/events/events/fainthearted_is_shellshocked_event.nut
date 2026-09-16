::mods_hookExactClass("events/events/fainthearted_is_shellshocked_event", function(o) {
	o.onUpdateScore = function () {
		local fallen = ::World.Statistics.getFallen();

		if (fallen.len() < 2)
			return;

		if (::World.getTime().Days - fallen[0].Time > 1 || ::World.getTime().Days - fallen[1].Time > 1)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() <= 4 && bro.getSkills().hasTrait(::Legends.Trait.Fainthearted) && bro.getPlaceInFormation() <= 26 && bro.getLifetimeStats().Battles >= 1)
				candidates.push(bro);
		}

		if (candidates.len() < 1)
			return;

		this.m.Rookie = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 15;
	}
})
