::mods_hookExactClass("events/events/fainthearted_is_shellshocked_event", function(o) {
	o.onUpdateScore = function () {
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
			return;

		if (this.World.getTime().Days - fallen[0].Time > 1 || this.World.getTime().Days - fallen[1].Time > 1)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() <= 4 && bro.getSkills().hasTrait(::Legends.Trait.Fainthearted) && bro.getPlaceInFormation() <= 26 && bro.getLifetimeStats().Battles >= 1)
				candidates.push(bro);
		}

		if (candidates.len() < 1)
			return;

		this.m.Rookie = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 15;
	}
})
