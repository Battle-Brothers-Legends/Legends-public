::mods_hookExactClass("events/events/dlc8/disowned_noble_vs_deserter_event", function(o) {
	o.onUpdateScore = function ()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local deserter_candidates = [];
		local disowned_candidates = [];

		foreach( bro in brothers ) {
			if (::Legends.Backgrounds.hasAny(bro, ::Legends.Background.DisownedNoble, ::Legends.Background.LegendDisownedNobleRanged, ::Legends.Background.RegentInAbsentia) && !bro.getFlags().has("reminiscedWithDeserter")) {
				disowned_candidates.push(bro);
			}
			else if (::Legends.Backgrounds.has(bro, ::Legends.Background.Deserter) && !bro.getFlags().has("reminiscedWithDisowned")) {
				deserter_candidates.push(bro);
			}
		}

		if (disowned_candidates.len() == 0 || deserter_candidates.len() == 0) {
			return;
		}

		this.m.Deserter = deserter_candidates[this.Math.rand(0, deserter_candidates.len() - 1)];
		this.m.Disowned = disowned_candidates[this.Math.rand(0, disowned_candidates.len() - 1)];
		this.m.Score = 3 * disowned_candidates.len() + 3 * deserter_candidates.len();
	}
});
