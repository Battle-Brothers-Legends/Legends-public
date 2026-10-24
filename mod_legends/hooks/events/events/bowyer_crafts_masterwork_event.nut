::mods_hookExactClass("events/events/bowyer_crafts_masterwork_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%bowyer% the bowyer comes to you with a bit of request: %bowyer_they% wishes to build a weapon for the ages. Apparently, the %bowyer_person% has been attempting to build a bow of legendary qualities for many years, but now that %bowyer_they% has been on the road %bowyer_they%\'s picked up a few things to fill in the gaps of knowledge. Truly, %bowyer_they% believes %bowyer_they% can get it right this time. All %bowyer_they% needs is a few resources to help procure the elements needed to construct it. A sum of 500 crowns is what %bowyer_they% humbly requests, and the quality wood you carry.";
				s.Options[0] = {
					Text = "Build me a bow of legends!",
					function getResult( _event ) {
						local brothers = ::World.getPlayerRoster().getAll();
						foreach( bro in brothers ) {
							if (::Legends.Backgrounds.has(bro, ::Legends.Background.LegendInventor))
								return "BA";
						}
						local r = ::Math.rand(1, 100);
						if (r <= 60)
							return "B";
						else
							return "C";
					}
				}
			}
			if (s.ID == "B") {
				s.start = function ( _event )
				{
					this.Characters.push(_event.m.Bowyer.getImagePath());

					this.List.push(::Legends.EventList.changeMoney(-500));

					local stash = ::World.Assets.getStash().getItems();

					foreach( i, item in stash )
					{
						if (item != null && item.getID() == "misc.quality_wood")
						{
							stash[i] = null;
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "You lose " + item.getName()
							});
							break;
						}
					}

					local item = this.new("scripts/items/weapons/masterwork_bow");
					item.m.Name = _event.m.Bowyer.getNameOnly() + "\'s " + item.m.Name;
					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					_event.m.Bowyer.improveMood(2.0, "Created a masterwork");

					if (_event.m.Bowyer.getMoodState() >= ::Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = ::Const.MoodStateIcon[_event.m.Bowyer.getMoodState()],
							text = _event.m.Bowyer.getName() + ::Const.MoodStateEvent[_event.m.Bowyer.getMoodState()]
						});
					}
				}
			}
		}

		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]Is this thing a wild experiment? The wood cricks and cracks when bent, the string frizzes and goes wiry every time you draw it back, and you swear you saw a termite poking its head out of the shaft. Every tested arrow goes haywire, skirting this way or that, anywhere but its supposed target.\n\nYou ease the bowyer\'s pain by blaming yourself for how inaccurate the weapon is, but %otherguy1% and %otherguy2% both give it a try and come to even worse results. The bowyer eventually shuffles off, cradling %bowyer_their% construction in %bowyer_their% arms before tossing it onto the stockpile of weapons where you\'d wish it\'d look just like any other bow, but its obscene ugliness makes it stick out like a hot coal on a haystack. Surely no man will be accidentally wielding that thing!";
		});
		

		this.m.Screens.push({
			ID = "BA",
			Text = "[img]gfx/ui/events/event_05.png[/img]{This isn\'t the bow you expected, but it is an amazing creation. Your bowyer and inventor collaborated to make a minaturised crossbow that is attached to the wrist. It is light and easy to carry along side your main weapon without impeding weapon usage, but it has less damage than a regular crossbow. A curious invention that may enable some interesting tactics, and if nothing else will net a fair price in the market. You congratulate the bowyer.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A masterwork!",
				function getResult( _event ) {
					return 0;
				}
			}],
			function start( _event ) {
				this.Characters.push(_event.m.Bowyer.getImagePath());

				this.List.push(::Legends.EventList.changeMoney(-500));

				local stash = ::World.Assets.getStash().getItems();
				foreach( i, item in stash ) {
					if (item != null && item.getID() == "misc.quality_wood") {
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
						break;
					}
				}

				local item = this.new("scripts/items/weapons/legend_hand_crossbow");
				item.m.Name = _event.m.Bowyer.getNameOnly() + "\'s " + item.m.Name;
				::World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Bowyer.improveMood(2.0, "Created a masterwork");

				if (_event.m.Bowyer.getMoodState() >= ::Const.MoodState.Neutral) {
					this.List.push({
						id = 10,
						icon = ::Const.MoodStateIcon[_event.m.Bowyer.getMoodState()],
						text = _event.m.Bowyer.getName() + ::Const.MoodStateEvent[_event.m.Bowyer.getMoodState()]
					});
				}
			}
		});
	}
})
