::mods_hookExactClass("events/events/dlc8/anatomist_vs_splinter_event", function(o) {
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local splinter_candidates = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.anatomist") {
				anatomist_candidates.push(bro);
			}
			else if (!bro.getSkills().hasTrait(::Legends.Trait.Bright) && !::Legends.Backgrounds.hasAny(bro,
				::Legends.Background.Monk,
				::Legends.Background.Historian,
				::Legends.Background.LegendInventor,
				::Legends.Background.LegendAlchemist,
				::Legends.Background.AdventurousNoble,
				::Legends.Background.LegendAdventurousNobleRanged,
				::Legends.Background.LegendDisownedNobleRanged,
				::Legends.Background.DisownedNoble,
				::Legends.Background.RegentInAbsentia,
				::Legends.Background.Minstrel)) {
				splinter_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() == 0 || splinter_candidates.len() == 0) {
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.SplinterBro = splinter_candidates[this.Math.rand(0, splinter_candidates.len() - 1)];
		this.m.Score = 3 * anatomist_candidates.len();
	}
});
