::mods_hookExactClass("events/events/player_plays_dice_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_62.png[/img]While relaxing after the day\'s walk, %gambler% comes up to you with a pair of dice and a cup in hand and asks if you wish to have a little game. The rules are quite simple: you roll the dice from the cup, whoever has the highest numbers wins. It\'s pure chance! The wager will be a hundred crowns per dice roll.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_62.png[/img]You roll the dice, landing a total of %playerdice%.\n\n%gambler% goes next, rolling a total of %gamblerdice%.\n\n{Well, you lost. The gambler snatches the dice back up - as well as your hundred crowns - and aks if you wish to have another go. | The dice were not in your favor and the gambler takes the earnings and looks up to you, grinning.%SPEECH_ON%Wish to have another go?%SPEECH_OFF% | The numbers are counted up and, alas, you have lost. The gambler asks if you wish to go again. | Lost! But maybe if you roll again... | You lose! A simple roll of the dice, and simple loss. But this one hurts a lot less than which you\'ve seen on the fields of battle. The gambler asks if you wish to have another go. | The gods have shunned you and your silly dice. Losing the game is a minor setback, but your pride costs a little more than a hundred crowns. Should you roll again? | The odds have betrayed you for a measly hundred crowns. Maybe if you roll again you can win them back? | You watch your dice tumble, seeing for but a moment the winning numbers before it tilts and falls to another side, revealing a losing total. The gambler laughs and asks if you wish to throw again. | Your throw was perfect! How could you lose? The gambler needed just those numbers to win! Shaking your head, you wonder if you should roll again.}";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Gambler.getImagePath());
					this.World.Assets.addMoney(-100);
					this.List = [{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]100[/color] Crowns"
					}];
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_62.png[/img]You roll the dice, landing a total of %playerdice%.\n\n%gambler% goes next, rolling a total of %gamblerdice%.\n\n{You won! The gambler claps hands.%SPEECH_ON%Beginner\'s luck!%SPEECH_OFF%You cross your arms.%SPEECH_ON%I thought it was all luck?%SPEECH_OFF%The gambler laughs and asks if you wish to test that theory. | The gambler leans back.%SPEECH_ON%Well I\'ll be damned. Let\'s throw again!%SPEECH_OFF% | The gambler leans back.%SPEECH_ON%{Well I\'ll be a horse\'s fartin\' arse | I\'ll be damned if the gods haven\'t turned their backs on me | Now that right there is a poor showin\' of lady luck | I\'d bedded a lady by the name of Luck, what good it\'s done me though | That right there is a misfortune, for me that is | Oy, that\'s a winning roll | I\'ll be a ragamuffin | Son of a gelded horse | Shits on a wet a pig | As damned as a nun on her back | The throw of a master I say | Yer a robber with such a throw and yeah | May %randomtown% join the orcs | And they say a blind squirrel can\'t find a nut | Tickle m\'anus with a rosebush and call me Sally Siegfried}, ya won! Let\'s roll again!%SPEECH_OFF% | You\'ve won! Laughing, you take your earnings and the gambler asks if you wish to have another throw.}";
				s.start = function ( _event ) {
					this.Characters.push(_event.m.Gambler.getImagePath());
					this.World.Assets.addMoney(100);
					this.List = [{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You win [color=" + this.Const.UI.Color.PositiveEventValue + "]100[/color] Crowns"
					}];
				}
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getMoney() <= 200)
			return;
		onUpdateScore();
	}
})
