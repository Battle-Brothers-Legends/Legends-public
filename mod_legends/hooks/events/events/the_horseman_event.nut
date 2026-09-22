::mods_hookExactClass("events/events/the_horseman_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "%terrainImage%You take out your blade and cut the man down. He crumples onto his shoulders and splays out, his lashed back in the dirt. The soil may as well have been salt judging by his wailing. One of the whippers stands up.%SPEECH_ON%Hey, just what do you think you\'re doing? We ain\'t finished here!%SPEECH_OFF%%randombrother% draws %their_randombrother% weapon and the man backs off. The horse owner spits and shakes his head.%SPEECH_ON%Are you really going to defend this piece of work? Ain\'t that some fucking horseshit. I guess now I can say I\'ve seen it all which is exactly what I said when I caught this bastard porkin\' my dead horse!%SPEECH_OFF%The man catches his breath then points at the recently rescued.%SPEECH_ON%I hope you die on your first day out ya filly fiddling bastard.%SPEECH_OFF%";
			_screen.start = function ( _event ) {
				_event.m.Dude = ::World.getTemporaryRoster().create("scripts/entity/tactical/" + (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion" ? "legend_player_legion" : "player"));
				_event.m.Dude.setStartValuesEx([::Legends.Background.Vagabond]);

				_event.m.Dude.setTitle("the Filly Fiddler");
				_event.m.Dude.getBackground().m.RawDescription = "You found %name% being whipped for \'involving\' himself with a dead horse. Hopefully that past is, er, behind him now.";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.setHitpoints(30);
				_event.m.Dude.improveMood(1.0, "Satisfied his needs with a dead horse");
				_event.m.Dude.worsenMood(1.0, "Got whipped");

				if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null)
					_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).removeSelf();

				if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Offhand) != null)
					_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Offhand).removeSelf();

				if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Head) != null)
					_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Head).removeSelf();

				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
	}
})
