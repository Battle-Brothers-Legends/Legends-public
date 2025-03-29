::mods_hookExactClass("events/events/historian_records_adventures_event", function(o) {
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
			if (bro.getLevel() >= 9 && (bro.getBackground().getID() == "background.historian" || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar)))
				candidates.push(bro);

		if (candidates.len() == 0)
			return;

		this.m.Historian = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}
})
