::mods_hookExactClass("events/events/bowyer_crafts_masterwork_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%bowyer% the bowyer comes to you with a bit of request: they wish to build a weapon for the ages. Apparently, %bowyer% has been attempting to build a bow of legendary qualities for many years, but now that they've has been on the road they've picked up a few things to fill in the gaps of knowledge. Truly, %bowyer% believes they can get it right this time. All tthe mercenary needs is a few resources to help procure the elements needed to construct it. A sum of 500 crowns is humbly requested, and the quality wood you carry.";
				s.Options[0] = {
					Text = "Build me a bow of legends!",
					function getResult( _event ) {
						local brothers = this.World.getPlayerRoster().getAll();
						foreach( bro in brothers ) {
							if ( bro.getBackground().getID() == "background.legend_inventor")
								return "BA";
						}
						local r = this.Math.rand(1, 100);
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
					this.World.Assets.addMoney(-500);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] Crowns"
					});
					local stash = this.World.Assets.getStash().getItems();

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
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					_event.m.Bowyer.improveMood(2.0, "Created a masterwork");

					if (_event.m.Bowyer.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Bowyer.getMoodState()],
							text = _event.m.Bowyer.getName() + this.Const.MoodStateEvent[_event.m.Bowyer.getMoodState()]
						});
					}
				}
			}
		}

		this.m.Screens.push({
			ID = "BA",
			Text = "[img]gfx/ui/events/event_05.png[/img]{This isn\'t the bow you expected, but it is an amazing creation. Your bowyer and inventor collaborated to make a minaturised crossbow that can be held in one hand. It is light and easy to carry along side your main weapon, but it has less damage than a regular crossbow. A curious invention that may enable some interesting tactics, and if nothing else will net a fair price in the market. You congratulate the bowyer.}",
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
				this.World.Assets.addMoney(-500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] Crowns"
				});
				local stash = this.World.Assets.getStash().getItems();

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
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Bowyer.improveMood(2.0, "Created a masterwork");

				if (_event.m.Bowyer.getMoodState() >= this.Const.MoodState.Neutral) {
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Bowyer.getMoodState()],
						text = _event.m.Bowyer.getName() + this.Const.MoodStateEvent[_event.m.Bowyer.getMoodState()]
					});
				}
			}
		});
	}
})
