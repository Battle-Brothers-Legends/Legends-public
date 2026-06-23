::mods_hookExactClass("events/events/dlc2/ailing_recovers_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]{%ailing% is walking around camp with %their_ailing% hands out and %their_ailing% fingers stretched as though %they_ailing% was balancing across a rope. %They_ailing% nods to %themselves_ailing% as %they_ailing% turns around, foot placed before foot, marching %their_ailing% way back across.%SPEECH_ON%For the first time in a long time I actually feel quite alright. Thanks, %healer%!%SPEECH_OFF%It seems %healer% knew of a couple means to rid what ailed %ailing%.}";
			_screen.start = function (_event) {
				this.Characters.push(_event.m.Ailing.getImagePath());
				this.Characters.push(_event.m.Healer.getImagePath());
				::Legends.EventList.changeMood(_event.m.Ailing, 1.5, "Feels the best %they_ailing% did in a long time");
				::Legends.Traits.remove(_event.m.Ailing, ::Legends.Trait.Ailing);
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_59.png",
					text = _event.m.Ailing.getName() + " is no longer ailing"
				});
			}
		});
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
