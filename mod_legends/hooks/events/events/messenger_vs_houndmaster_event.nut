::mods_hookExactClass("events/events/messenger_vs_houndmaster_event", function(o) {
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local messenger_candidates = [];

		foreach( bro in brothers )
			if (bro.getLevel() <= 3 && bro.getBackground().getID() == "background.messenger")
				messenger_candidates.push(bro);

		if (messenger_candidates.len() == 0)
			return;

		local houndmaster_candidates = [];

		foreach( bro in brothers )
			if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.legend_muladi")
				houndmaster_candidates.push(bro);

		if (houndmaster_candidates.len() == 0)
			return;

		this.m.Messenger = messenger_candidates[this.Math.rand(0, messenger_candidates.len() - 1)];
		this.m.Houndmaster = houndmaster_candidates[this.Math.rand(0, houndmaster_candidates.len() - 1)];
		this.m.Score = (messenger_candidates.len() + houndmaster_candidates.len()) * 3;
	}
})
