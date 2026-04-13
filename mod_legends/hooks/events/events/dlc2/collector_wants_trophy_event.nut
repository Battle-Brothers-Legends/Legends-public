::mods_hookExactClass("events/events/dlc2/collector_wants_trophy_event", function(o) {
	o.m.Merchant <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options = [{
					Text = "Deal.",
					function getResult( _event ) {
						if (_event.m.Merchant != null)
							return "Merchant";
						if (_event.m.Peddler != null)
							return "Peddler";
						else {
							this.World.Assets.addMoney(_event.m.Reward);
							local stash = this.World.Assets.getStash().getItems();
							foreach( i, item in stash ) {
								if (item != null && item.getID() == _event.m.Item.getID()) {
									stash[i] = null;
									break;
								}
							}
							return 0;
						}
					}
				}, {
					Text = "No deal.",
					function getResult( _event ) {
						if (_event.m.Merchant != null)
							return "Merchant";
						if (_event.m.Peddler != null)
							return "Peddler";
						return 0;
					}
				}]
			}
			if (s.ID == "Peddler") {
				s.Text = "[img]gfx/ui/events/event_01.png[/img]{%peddler% steps forward and pushes you back as though you were a random customer and not the company captain. %peddler% yells at the buyer and throws a hand up and the buyer responds and it\'s like two dogs barking at one another and it\'s all so fast and with so many numbers being thrown around it may as well be another language. After a minute passes, the peddler returns.%SPEECH_ON%Alright. He\'s now offering %reward% crowns. I\'m off to look at some pots and pans, good luck.%SPEECH_OFF%He pats you on the shoulder and walks off.}";
			}
		}
		this.m.Screens.push({
			ID = "Merchant",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You see your chance and step forward, the buyer looks a little concerned as if they just wandered into a tavern filled with angry barbarians. You playfully lean on the stall and lock eyes with him. You gracefully smile while maintaining eye contact. %SPEECH_ON%This isn\'t just any trophy — this came from a great beast with jaws bigger than a horse and a tail as long as a man!%SPEECH_OFF%The merchant recoils slightly, trying to picture the beast in his mind while eye the trophy in your hands. %SPEECH_ON%This beast was mighty — legendary even! You\'ll be the talk of the market when you have it safely away in your store...%SPEECH_OFF%The man purses his lips and contemplates this for a moment, before gingerly counting out additional coin from an unassuming bag. %SPEECH_ON%I\'ll give you %reward% for it. No more.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Deal.",
				function getResult( _event ) {
					this.World.Assets.addMoney(_event.m.Reward);
					local stash = this.World.Assets.getStash().getItems();
					foreach( i, item in stash )
						if (item != null && item.getID() == _event.m.Item.getID()) {
							stash[i] = null;
							break;
						}
					return 0;
				}
			}, {
				Text = "No deal.",
				function getResult( _event ) {
					return 0;
				}

			}],
			function start( _event ) {
				this.Characters.push(_event.m.Merchant.getImagePath());
				_event.m.Reward = this.Math.floor(_event.m.Reward * 1.66);
			}
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		onUpdateScore();
		if (this.m.Score == 0)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_merchant = [];
		foreach( bro in brothers )
			if (bro.getBackground().getID() == "background.legend_peddler_commander")
				candidates_merchant.push(bro);

		if (candidates_merchant.len() != 0)
			this.m.Merchant = candidates_merchant[this.Math.rand(0, candidates_merchant.len() - 1)];
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function (_vars) {
		onPrepareVariables(_vars);
		_vars.push([
			"merchant",
			this.m.Merchant != null ? this.m.Merchant.getName() : ""
		]);
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Merchant = null;
	}
});
