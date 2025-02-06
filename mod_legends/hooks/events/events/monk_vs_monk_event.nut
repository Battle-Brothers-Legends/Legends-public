::mods_hookExactClass("events/events/monk_vs_monk_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] Ah, the campfire is brimming with talk and chatter. The mercenaries are enjoying some beer and food when rather suddenly the shouts of two in particular get everyone else to quiet down, not because they yell louder than the rest, but because it\'s rather out of character for the both of them: the holy folk %monk1% and %monk2% are screaming-deep in a theological debate.\n\nYou\'ve not the education to understand the intricacies nor complexities of what they are arguing, but you do understand that getting into another person\'s face and pointing furiously, or at a holy book, is probably asking for trouble one way or another.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img] For a moment, you think to stop the debate before it gets out of hand and into fists, but then you remember that this isn\'t the first time you\'ve seen two holy men exchanging rather heatedly. It\'s just what they do. So you decide to let them hash it out. In time, their voices lower in volume, and their faces lower together into a book. They quietly peruse it, bumping heads as they draw their eyes over the pages. Finally, %monk1% raises up, pointing to some sentence.%SPEECH_ON%There! Right there! \'Man from mud\', not \'man from blood\'. Man can\'t be from blood, he is blood! Man can\'t be from himself, see? Now does it make sense?%SPEECH_OFF%Scratching his chin, %monk2% nods, but then wonders aloud.%SPEECH_ON%What if...%SPEECH_OFF%Before the thought is finished %monk1% slaps the book closed with hands thrown into the air.";
				s.Options[0].Text = "The holy avert another crisis.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]Now, this isn\'t the first time you\'ve seen two religious types squabbling. The last time it happened the debaters hashed it out right quick. So naturally you think these two will do the same. Alas, it isn\'t to be. Their voices grow louder and louder. You never knew the pious could be so sharp-tongued. Fierceness and lewdness don\'t even begin to describe the insults being thrown back and forth. It isn\'t but a few seconds later that they are on the ground, wrestling and punching until you order %otherguy% to put an end to it.\n\nThe company of sellswords and their bloody daywork, it seems, have left a mark on the once peaceful demeanor of the two.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Monk1.getImagePath());
					this.Characters.push(_event.m.Monk2.getImagePath());

					this.List.push({
						id = 10,
						icon = "ui/icons/relation.png",
						text = _event.m.Monk1.getName() + " and " + _event.m.Monk2.getName() + " grow distant"
					});

					_event.m.Monk1.getBaseProperties().Bravery += 1;
					_event.m.Monk1.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Monk1.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Resolve"
					});
					_event.m.Monk2.getBaseProperties().Bravery += 1;
					_event.m.Monk2.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Monk2.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Resolve"
					});
					_event.m.Monk1.worsenMood(1.0, "Lost composure and resorted to violence");

					if (_event.m.Monk1.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Monk1.getMoodState()],
							text = _event.m.Monk1.getName() + this.Const.MoodStateEvent[_event.m.Monk1.getMoodState()]
						});
					}

					_event.m.Monk2.worsenMood(1.0, "Lost composure and resorted to violence");

					if (_event.m.Monk2.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Monk2.getMoodState()],
							text = _event.m.Monk2.getName() + this.Const.MoodStateEvent[_event.m.Monk2.getMoodState()]
						});
					}

					if (this.Math.rand(1, 100) <= 50) {
						_event.m.Monk1.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = _event.m.Monk1.getName() + " suffers light wounds"
						});
					} else {
						local injury = _event.m.Monk1.addInjury(this.Const.Injury.Brawl);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Monk1.getName() + " suffers " + injury.getNameOnly()
						});
					}

					if (this.Math.rand(1, 100) <= 50) {
						_event.m.Monk2.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = _event.m.Monk2.getName() + " suffers light wounds"
						});
					} else {
						local injury = _event.m.Monk2.addInjury(this.Const.Injury.Brawl);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Monk2.getName() + " suffers " + injury.getNameOnly()
						});
					}
				}
			}
		}
	}
})
