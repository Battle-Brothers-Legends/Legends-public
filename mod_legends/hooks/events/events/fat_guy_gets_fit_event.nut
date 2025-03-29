::mods_hookExactClass("events/events/fat_guy_gets_fit_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_75.png[/img]%fatguy%, once a lumbering lump of belly fat on two legs, has lost a considerable amount of weight since enlisting with the company. No longer does the mere notion of a sparring fight leave them without breath. In fact, they\'ve got more bounce in their step and is showing a sort of agility you\'ve never seen from them before. Looks like all this walking about has done wonders.";
				s.Options[0].Text = "They might make a good sellsword yet.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
			if (bro.getLevel() >= 5 && bro.getSkills().hasTrait(::Legends.Trait.Fat))
				candidates.push(bro);

		if (candidates.len() > 0) {
			this.m.FatGuy = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 5;
		}
	}
})
