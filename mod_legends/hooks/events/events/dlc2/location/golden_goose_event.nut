::mods_hookExactClass("events/events/dlc2/location/golden_goose_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_125.png[/img]{Seeing as how the skeleton and his beer and bread ain\'t going anywhere, you leave it be. The axehead however draws your eye again. %observer% walks over to the stump and the glowing wedge. He tries to take it out. Finding no luck there, he steps back and kicks it further in. The trump cracks in twain and the sellsword suddenly flies upside down and the axehead shoots through the roof of the boat and you can hear it clunk and clatter down its sides outside. Debris and smoke drift lazily about. The sellsword gets up and pats himself off.%SPEECH_ON%What in all the hells was that?%SPEECH_OFF%You shush him and point. A little golden goose squats where the stump\'s base used to be. The sheen of its metal glows and swirls. You\'ve heard stories of a golden goose, but never thought they were anything beyond that!}";
			}
		}
	}

	o.onPrepare = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers ) {
			if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble) && !bro.getSkills().hasSkill("trait.bright") && !bro.getSkills().hasSkill("trait.short_sighted") && !bro.getSkills().hasSkill("trait.night_blind"))
				candidates.push(bro);
		}

		if (candidates.len() != 0)
			this.m.Observer = candidates[this.Math.rand(0, candidates.len() - 1)];
		else
			this.m.Observer = brothers[this.Math.rand(0, brothers.len() - 1)];
	}
});
