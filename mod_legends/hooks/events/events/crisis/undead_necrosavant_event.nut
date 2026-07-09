::mods_hookExactClass("events/events/crisis/undead_necrosavant_event", function(o) {
	o.m.Warlock <- null;


	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			local getResult = _screen.Options[0].getResult;
				_screen.Options[0].getResult <- function (_event) {
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
						return "E";
					return getResult(_event)
				}
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_76.png[/img]Suddenly, a crossbow aims over your shoulder and fires so closely you can feel the air rushing past the twang of its rope. The bolt pierces the old man\'s skull and he tips forward, head to the mud, arse in the air, hands still beside himself in dispirited supination.\n\nYou turn to see %witchhunter% the witch hunter standing behind you. %They_witchhunter% lowers the crossbow and walks over to the corpse, grabbing it by the nape of the neck and putting a stake through its back. The body wretches with a shriek and the clothing bloats as the body implodes, a swirling dust hurriedly exiting out the cloak as though it had been caught impersonating a man.\n\n The witch hunter turns to you.%SPEECH_ON%Necrosavant. Rare. Extremely dangerous.%SPEECH_OFF%";
		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_76.png[/img]The figure rises and turns to you with a dark gaze of one who has lived for a thousand years.%SPEECH_ON%Ah, brothers, I have waited for you.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "Welcome to the %companyname%.",
				function getResult( _event )
				{
					this.World.getPlayerRoster().add(_event.m.Warlock);
					this.World.getTemporaryRoster().clear();
					_event.m.Warlock.onHired();
					return 0;
				}
			},
			{
				Text = "Too much flesh for us",
				function getResult( _event )
				{
					this.World.getTemporaryRoster().clear();
					return 0;
				}
			}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Warlock = roster.create("scripts/entity/tactical/player");
				_event.m.Warlock.getFlags().add("PlayerSkeleton");
				_event.m.Warlock.getFlags().add("undead");
				_event.m.Warlock.getFlags().add("skeleton");
				_event.m.Warlock.setStartValuesEx(["legend_necro_background"]);
				::Legends.Traits.grant(_event.m.Warlock, ::Legends.Trait.RacialSkeleton);
				::Legends.Traits.grant(_event.m.Warlock, ::Legends.Trait.LegendFleshless);
				this.Characters.push(_event.m.Warlock.getImagePath());
			}
		});
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Warlock = null;
	}
})
