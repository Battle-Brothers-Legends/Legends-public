::mods_hookExactClass("events/events/traveling_troupe_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Entertainer") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]%entertainer% steps forward and picks up some of the troupe\'s tools of trade.  %entertainer% tests them out, impressing the entertainers with how well the mercenary is able to use their own equipment. The mime asks if perhaps they could play a couple of tunes together.  Joining the entertainers with a nod, putting on a show that\'s for the ages. When it\'s all over, the troupe is so impressed that they try and recruit the mercenary. You tell them that ain\'t happening and %entertainer% nods.%SPEECH_ON%My time is with the %companyname% now, but I appreciate the compliment.%SPEECH_OFF%You ask how much for the show, but the troupe leader shakes his head.%SPEECH_ON%No need. It was a pleasure playing. We\'ve not put on a show like that in some time and the practice will do us well.%SPEECH_OFF%";
			}
			if (s.ID == "Noble") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]Before the troupe can start, %nobleman% the noble gets up and asks if they know of a particular song from their days in the court.%SPEECH_ON%They used to sing it when I was a little child. It\'s been years since I\'ve heard it.%SPEECH_OFF%The mime, again breaking character, grins and loudly proclaims that they know it. He snaps his fingers and the musicians of the group pick up their instruments. When they start, the tune is instantly catchy. It\'s a stringed and horn orchestration, played alongside a large woman singing from both heart and belly. She is a tempest of a singer, bringing both the quiet and ferocity of a large storm\'s coming and going, and her lyrics are that of incredible heroism of yore.\n\n After the troupe finishes, you ask how much you owe them. The mime shakes his head.%SPEECH_ON%No, sir, payment is not necessary. It\'s been awhile since that got requested and it was a pleasure to play it for you.%SPEECH_OFF%";
			}
			if (s.ID == "Robbing") {
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-2);
					local item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.jesters_hat]]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					item = this.new("scripts/items/weapons/lute");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					item = this.Math.rand(50, 200);
					this.World.Assets.addMoney(item);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + item + "[/color] Crowns"
					});
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});

					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getSkills().hasTrait(::Legends.Trait.Bloodthirsty) || bro.getBackground().getID() == "background.raider") {
							bro.improveMood(1.0, "Enjoyed beating up a traveling troupe");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral)
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
						}
					}
				}
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (this.Stash.getNumberOfEmptySlots() < 2)
			return;
		onUpdateScore();
	}
})
