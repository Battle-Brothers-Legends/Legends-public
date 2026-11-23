::mods_hookExactClass("ambitions/ambitions/sergeant_ambition", function (o) {
	o.m = {
		Sergeant = null
	};
	local create = o.create;
	o.create = function () {
		create();
		this.m.SuccessText = "[img]gfx/ui/events/event_64.png[/img]You were unsure at first about assigning %sergeantbrother% to this important task, for %they_sergeant% was as committed to revelry and carousing as any other %person_sergeant%. But %sergeantbrother% takes to %their_sergeant% duties with a zeal that is at first admirable, and later worrying.\n\nScoffing at dawn as the rising hour of the cowardly and infirm, %sergeantbrother% decides that everyone must start the day much earlier. %They_sergeant% runs the men through the usual sparring routines and checks their equipment for splits and wear, but to such light work %they_sergeant% adds strict rules about setting up and breaking camp, formation drills, lessons on flanking, forced marches with stones in their packs, and a detailed punishment regime for anyone who dares fall behind.\n\nWords such as \'back-breaking\', \'cruel\', \'flint-hearted\' and \'merciless\', as well as dozens of saltier epithets, ring in the air whenever %sergeantbrother% is safely out of earshot, though never when %they_sergeant% is sleeping. For the brothers have learned that %sergeantbrotherfull% never truly sleeps.";
	}

	o.onPrepareVariables = function (_vars) {
		local brothers = this.World.getPlayerRoster().getAll();
		local highestBravery = 0;

		foreach (bro in brothers) {
			if (bro.getSkills().hasSkill("perk.rally_the_troops")
				&& bro.getCurrentProperties().getBravery() > highestBravery)
			{
				this.m.Sergeant = bro;
				highestBravery = bro.getCurrentProperties().getBravery();
			}
		}

		_vars.push([
			"sergeantbrother",
			this.m.Sergeant.getNameOnly()
		]);
		_vars.push([
			"sergeantbrotherfull",
			this.m.Sergeant.getName()
		]);
	}
});
