::mods_hookExactClass("events/events/graverobber_finds_item_event", function(o) {
	o.onUpdateScore = function ()
	{
		if (this.World.getTime().IsDaytime)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_graverobber = [];
		local candidates_historian = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.graverobber")
				candidates_graverobber.push(bro);
			else if (bro.getBackground().getID() == "background.historian" || bro.getSkills().hasSkill("perk.legend_scholar"))
				candidates_historian.push(bro);
		}

		if (candidates_graverobber.len() == 0)
			return;

		this.m.Graverobber = candidates_graverobber[this.Math.rand(0, candidates_graverobber.len() - 1)];

		if (candidates_historian.len() != 0)
			this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];

		this.m.Score = 5;
	}

})
