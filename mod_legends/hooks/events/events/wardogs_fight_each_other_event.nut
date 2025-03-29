::mods_hookExactClass("events/events/wardogs_fight_each_other_event", function(o) {
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_houndmaster = [];
		local candidates_other = [];
		local candidates_wardog = [];

		foreach( bro in brothers ) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Player))
				continue;

			if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.legend_muladi" )
				candidates_houndmaster.push(bro);
			else
				candidates_other.push(bro);
		}

		if (candidates_other.len() == 0)
			return;

		local stash = this.World.Assets.getStash().getItems();

		foreach( item in stash )
			if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
				candidates_wardog.push(item);

		if (candidates_wardog.len() < 2)
			return;

		this.m.Otherbrother = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_houndmaster.len() != 0)
			this.m.Houndmaster = candidates_houndmaster[this.Math.rand(0, candidates_houndmaster.len() - 1)];

		local r = this.Math.rand(0, candidates_wardog.len() - 1);
		this.m.Wardog1 = candidates_wardog[r];
		candidates_wardog.remove(r);
		r = this.Math.rand(0, candidates_wardog.len() - 1);
		this.m.Wardog2 = candidates_wardog[r];
		this.m.Score = candidates_wardog.len() * 5;
	}
})
