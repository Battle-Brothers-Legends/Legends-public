::mods_hookExactClass("events/events/drunkard_loses_stuff_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]While taking inventory last night, %drunkard% had a little too much to drink and ended up losing %item%!\n\nYou\'ve had the mercenary brought to you, and swaying while speaking, the drunkard still reeks of alcohol. %drunkard% hiccups while trying to explain what happened, but the best defense they can muster is collapsing to the ground in a drunken heap. %drunkard% laughs and laughs, but you see nothing funny about this. %otherguy% asks what you want to do with this mess.";
				s.Options[2].Text = "If %drunkard% won\'t put down the drink I\'ll do it. Get the whip.";
				s.Options.push({
					Text = "Sober them up, we will talk it out",
					function getResult( _event ) {
						return this.Math.rand(1, 100) <= 25 ? "F" : "G";
					}
				})
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]The drunkard falls on their back, staring aimlessly at the sky. You see tears in their eyes and %drunkard% covers their face, trying to hide the shame. There is something about their past that you do not know, perhaps something that led to the drink in the first place. You can\'t possibly punish someone for what they cannot control.";
				s.Options[0].Text = "Get this drunkard out of my sight.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You grab a shovel, a bucket, and a crusty bit of wool wrapped around a stick.%SPEECH_ON%Latrine duty. One month.%SPEECH_OFF%The drunkard looks at you and with wide eyes makes something of a plead.%SPEECH_ON%Sir, please. I -hic- don\'t... the company, sir, they -hic-...%SPEECH_OFF%You hold your hand up, stopping the protestations. The mercenary sways and tries to stand straight. Cracking your knuckles, you explain the other option.%SPEECH_ON%If you do not wish to have these duties, then we can expedite your punishment by the whip. Which would you prefer?%SPEECH_OFF%Amazingly, the drunkard actually spends a few moments thinking it over, eyebrows rising and falling and a grimace passing from side of their mouth to the other with a stream of realizations that there\'s no way out of it. Finally, %drunkard% submits to the smellier of the two options. Quite shocked to see the choice even took any time at all, you begin to wonder just how bad the company\'s diet has gotten.";
				s.Options[0].Text = "Get this drunkard out of my sight.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_38.png[/img]The mercenary was driven to the drink, so you plan to drive it out of them. You order a flogging. A few battle brothers drag the drunk away, hiccupping and moaning, head bouncing aloll, seemingly unaware of what is going on. They string the drunkard up beneath a tree and shred the clothes off their back. After a few lashings, the drunkard wakes up to the punishment and begins crying out uncontrollably, beggin for mercy in a tongue blurred by drink and pain, like someone fighting for freedom from a nightmare. One thing is for certain: they\'ll never make this mistake again.";
				s.Options[0].Text = "That\'ll teach \'em.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Drunkard.getImagePath());
					_event.m.Drunkard.addLightInjury();
					this.List = [
					{
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Drunkard.getName() + " receives an injury"
					}
					];
					::Legends.Traits.remove(_event.m.Drunkard, ::Legends.Trait.Drunkard);
					this.List.push({
						id = 10,
						icon = "ui/traits/trait_icon_29.png",
						text = _event.m.Drunkard.getName() + " is no longer a drunkard"
					});
					_event.m.Drunkard.worsenMood(2.5, "Was flogged on your orders");
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Drunkard.getMoodState()],
						text = _event.m.Drunkard.getName() + this.Const.MoodStateEvent[_event.m.Drunkard.getMoodState()]
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() == _event.m.Drunkard.getID())
							continue;

						if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) || bro.getBackground().getID() == "background.flagellant"  || bro.getBackground().getID() == "background.cultist"  || bro.getBackground().getID() == "background.converted_cultist" || bro.getBackground().getID() == "background.monk_turned_flagellant" )
							continue;

						bro.worsenMood(1.0, "Appalled by your order to have " + _event.m.Drunkard.getName() + " flogged");

						if (bro.getMoodState() < this.Const.MoodState.Neutral) {
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}
			if (s.ID == "E") {
				s.start <- function ( _event )
				{
					this.Characters.push(_event.m.Drunkard.getImagePath());
					_event.m.Drunkard.addLightInjury();
					this.List = [
					{
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Drunkard.getName() + " receives an injury"
					}
					];
					_event.m.Drunkard.worsenMood(2.5, "Was flogged on your orders");
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Drunkard.getMoodState()],
						text = _event.m.Drunkard.getName() + this.Const.MoodStateEvent[_event.m.Drunkard.getMoodState()]
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() == _event.m.Drunkard.getID())
							continue;

						if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) || bro.getBackground().getID() == "background.flagellant"  || bro.getBackground().getID() == "background.cultist"  || bro.getBackground().getID() == "background.converted_cultist" || bro.getBackground().getID() == "background.monk_turned_flagellant" )
							continue;

						bro.worsenMood(1.0, "Appalled by your order to have " + _event.m.Drunkard.getName() + " flogged");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
					}
				}
			}
		}
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_23.png[/img]The mercenary\'s drinking must be a result of something. You set out to find out what the cause was. You give some water and food to the drunkard and have them exercise until they sober up. You {walk a short way | sit for a time | wander around the camp perimeter | sit in your tent | sit around the fire after others fall asleep | walk a long time through the surrounding lands | stare at the sky together | gaze into the fire} and talk on the {issues | memories | concerns | worries | fears} that {plague | haunt | hunt | pursue | govern | tarry | gnaw at | consume} them, %drunkard% tells you their story of {family abuse | lost love | tyrantical injustice | infidelity | brutal employment | childhood neglect | a wartorn hometown | natural disaster | family tradgedy | a witch curse | the cruelty of the gods | a lost child | a backstabbing business parter | abandonment | loss | tragedy | brutality}. You talk for a time about not letting the past {influence | govern | control | infect | overcome | outweigh | shade | color | undo | replace | undermine} the future. Something stirs deep inside them, and they swear they\'ll never make this mistake again.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "We may have found the cause",
				function getResult( _event ) {
					return 0;
				}
			}],
			function start( _event ) {
				::Legends.Traits.remove(_event.m.Drunkard, ::Legends.Trait.Drunkard);
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_29.png",
					text = _event.m.Drunkard.getName() + " is no longer a drunkard"
				});
				::Legends.Effects.grant(_event.m.Drunkard, ::Legends.Effect.Hangover);
				this.List.push({
					id = 10,
					icon = "skills/status_effect_62.png",
					text = _event.m.Drunkard.getName() + " is hungover"
				});
				_event.m.Drunkard.worsenMood(2.5, "Relived the past and realised the error of their ways");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Drunkard.getMoodState()],
					text = _event.m.Drunkard.getName() + this.Const.MoodStateEvent[_event.m.Drunkard.getMoodState()]
				});
				local brothers = this.World.getPlayerRoster().getAll();
			}
		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_23.png[/img]The mercenary\'s drinking must be a result of something. You set out to find out what the cause was. You give some water and food to the drunkard and have them excercise until they sober up. You {walk a short way | sit for a time | wander around the camp perimeter | sit in your tent | sit around the fire after others fall asleep | walk a long time through the surrounding lands | stare at the sky together | gaze into the fire} and talk on the {issues | memories | concerns | worries | fears} that {plague | haunt | hunt | pursue | govern | tarry | gnaw at | consume} them, %drunkard% tells you their story of {family abuse | lost love | tyrantical injustice | infidelity | brutal employment | childhood neglect | a wartorn hometown | natural disaster | family tradgedy | a witch curse | the cruelty of the gods | a lost child | a backstabbing business parter | abandonment | loss | tragedy | brutality | hopelessness | tyrany | injustice | unrequited love | unfulfilled ambition}. You talk for a time about not letting the past {influence | govern | control | infect | overcome | outweigh | shade | color | undo | replace | undermine} the future. Despite the in depth conversation, you fear the issue is not yet resolved.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "This is not over.",
				function getResult( _event ) {
					return 0;
				}
			}],
			function start( _event ) {
				::Legends.Effects.grant(_event.m.Drunkard, ::Legends.Effect.Hangover);
				this.List.push({
					id = 10,
					icon = "skills/status_effect_62.png",
					text = _event.m.Drunkard.getName() + " is hungover"
				});
				_event.m.Drunkard.worsenMood(1.0, "Lost an item and relived the past");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Drunkard.getMoodState()],
					text = _event.m.Drunkard.getName() + this.Const.MoodStateEvent[_event.m.Drunkard.getMoodState()]
				});
				local brothers = this.World.getPlayerRoster().getAll();
			}
		});
	}

	o.getEligibleItems <- function () {
		return ::World.Assets.getStash().getItems().filter(function (_, _item) {
			if (_item == null)
				return false;
			if (_item.isNamed() || _item.isIndestructible()) //rap I love you but i do not like how sadistic you can be.
				return false;
			if (_item.isItemType(::Const.Items.ItemType.Weapon))
				return true;
			if (_item.isItemType(::Const.Items.ItemType.Shield))
				return true;
			if (_item.isItemType(::Const.Items.ItemType.Armor))
				return true;
			if (_item.isItemType(::Const.Items.ItemType.Helmet))
				return true;
			return false;
		});
	}

	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers )
			if (bro.getSkills().hasTrait(::Legends.Trait.Drunkard) && bro.getBackground().getID() != "background.legend_commander_noble")
				candidates.push(bro);

		if (candidates.len() == 0)
			return;

		if (this.getEligibleItems().len() == 0)
			return;

		this.m.Drunkard = candidates[this.Math.rand(0, candidates.len() - 1)];
		local other_candidates = [];

		foreach( bro in brothers )
			if (bro.getID() != this.m.Drunkard.getID())
				other_candidates.push(bro);

		if (other_candidates.len() == 0)
			return;

		this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}

	o.onPrepare = function () {
		local candidates = this.getEligibleItems();
		this.m.Item = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.World.Assets.getStash().remove(this.m.Item);
	}
})
