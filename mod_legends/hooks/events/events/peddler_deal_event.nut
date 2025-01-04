::mods_hookExactClass("events/events/peddler_deal_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%peddler% comes to you, rubbing the back of their neck and nervously pulling on their shirt front. %peddler%  proposes a plan to go into town with a handful of goods to peddle around, as they\'ve done so often in the past.\n\nOnly problem is that %peddler%  doesn\'t yet have the goods -  those will need to be bought from some local in the nearby hinterlands. All %peddler% needs now is a bit of money to get started and help purchase the goods. A sum of 500 crowns all in all. Naturally, as a partner, you will get a cut of the profits once it\'s all said and done.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img]You hand %peddler% the crowns and send them off.\n\nA few hours later, the peddler comes running up with a small lockbox in hand. The wily grin on %peddler%\'s face is undeniable, unwittingly fistpumping while gliding to you. When %peddler%  tries to speak, but is seized by gasps of breath. You hold your hand out, telling %peddler%  to take their time. Settling down, the mercenary hands over a heavy purse of coins, stating that it is your cut of the profits.\n\nBefore you can even say anything, the peddler wheels on their heels and jumps away, giddy with success.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%peddler% makes off and you tend to other business for the day.\n\nAs you step out of your tent hours later, you see a slumped shape in the distance, steadily heading your way. It appears to be the peddler, carrying nothing but a frown. As %peddler% gets closer, you begin to see the bruises that dot their body. %peddler% explains that while managing to purchase the goods from the source, the actual townspeople weren\'t particularly warm to the selling tactics.\n\nWhat money was invested has been lost and %peddler% heads to a tent to nurse those wounds.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Peddler.getImagePath());
					this.World.Assets.addMoney(-500);
					this.List = [{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] Crowns"
					}];
					_event.m.Peddler.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Peddler.getName() + " suffers light wounds"
					});
					_event.m.Peddler.worsenMood(2, "Failed in a plan and lost a large amount of money");

					if (_event.m.Peddler.getMoodState() < this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Peddler.getMoodState()],
							text = _event.m.Peddler.getName() + this.Const.MoodStateEvent[_event.m.Peddler.getMoodState()]
						});
					}
				}
			}
		}
	}
})
