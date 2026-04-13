::mods_hookExactClass("events/events/dlc2/ailing_recovers_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]{%ailing% is walking around camp with hands out and fingers stretched as though balancing across a rope. Nodding and turns around, foot placed before foot, marching back across.%SPEECH_ON%For the first time in a long time I actually feel quite alright. Thanks, %healer%!%SPEECH_OFF%It seems %healer% knew of a couple means to rid what ailed %ailing%.}";
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Unhold)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates_ailing = [];
		local candidates_healer = [];

		foreach (bro in brothers) {
			if (bro.getLevel() < 4)
				continue;

			if (bro.getSkills().hasTrait(::Legends.Trait.Ailing))
				candidates_ailing.push(bro);
			else if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.legend_herbalist" || bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_commander_witch" )
				candidates_healer.push(bro);
		}

		if (candidates_ailing.len() == 0 || candidates_healer.len() == 0)
			return;

		this.m.Ailing = candidates_ailing[this.Math.rand(0, candidates_ailing.len() - 1)];
		this.m.Healer = candidates_healer[this.Math.rand(0, candidates_healer.len() - 1)];
		this.m.Score = 5;
	}
});
