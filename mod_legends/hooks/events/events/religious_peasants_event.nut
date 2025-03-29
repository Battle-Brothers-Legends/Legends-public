::mods_hookExactClass("events/events/religious_peasants_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_59.png[/img]The forests have always been a refuge for people - the wilds from whence we came, to the wilds where we always wish to return. And here you find a great number of people, a tribe of the lost, unconcerned with their departed civilizations, draped in religious habits, and carrying great sigils of faith, and tomes of truth. They\'re impoverished almost to the point of being decadently fashionable, like great kings looking to fit in with commoners. You sit and watch this shuffle by, clinking, clanging, hollow wooden beads rattling, whispers under their breath, raspy and dry. And so they go on, hardly even bothering to look at you.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_03.png[/img]Curious, you call out to the procession to ask where they are going. The man in front slowly turns to you, his eyes peering out from the dark of a wrapped shawl. He slowly draws the cloak back, revealing a head scarred in a pattern of religious rites. All the followers behind him slowly follow suit, like a row of cards falling by the brush of a chaotic and mad wind.%SPEECH_ON%Davkul shall see you in the next world!%SPEECH_OFF%One of them shouts and they charge.";
				s.Options = [{
					Text = "To arms!",
					function getResult( _event ) {
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];

						for( local i = 0; i < 50; i = ++i ) {
							local unit = clone this.Const.World.Spawn.Troops.Cultist;
							unit.Faction <- this.Const.Faction.Enemy;
							properties.Entities.push(unit);
						}

						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}
				}]
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_12.png[/img]{Obviously, this isn\'t an ordinary sight for you so, curious, you call out to the weary travelers. Words barely leave your lips before the entire line of men stops in an instant and bolts upright. Their cloaks unravel and droop from their heads, and their tomes and sticks and religious imports fall aside in a uniform clatter. The people look around, wide eyes more alive than ever. One screams. Then another. And soon they are all screaming, and some crumple to the ground, clutching their ears as though to silence the horrid howls their mouths had to give, while others wheel in circles, arms out, begging for answers.\n\n Your mere utterance has seemingly broken a spell that was so long over their heads it had brought them here, impoverished, hungry, and insane. Step by step, they were governed by a malicious higher power, and step by step they felt the control in their lives slip away, and with it the sanity all men require to be themselves. Unfortunately, you can hardly ask them what or who did this to them, for some fall over dead while others make naked sprints into the forest. | A curious sight such as this begs questioning, but the second a word leaves your lips the entire troop of religious men bolt upright, the sudden shuffle of clothes and gear clattering in such uniformity it as if a door was slammed shut. The men drop their things and begin screaming. It is a raspy chorus. They all begin to collapse, either buckling on bony knees or clutching their stomachs in pained hunger.\n\n %randombrother% comes up, shaking his head.%SPEECH_ON%Were they cursed? What could have done this?%SPEECH_OFF%You won\'t ever get an answer for a minute later every single one is dead, looking no better than corpses having recently been thawed out of the mountains. The spell must have forcibly piloted their pilgrimage here, straining the human body while keeping it alive by the mere strand of ethereal malevolence. Although they are all dead, you do not regret freeing them of such a horrid curse.}";
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_59.png[/img]Curious as to where these people are going, you open your mouth, but %monk% the holy one steps forward, cutting you off and going to the man in front of the troop and has quiet counsel with him. There is plenty of nodding, hrrumphing, and other gesticulations of those who dwell long on things well beyond the human realm. Eventually, the monk comes back.%SPEECH_ON%They\'re on a pilgrimage and now our name travels with them. Many shall hear of it.%SPEECH_OFF%You thank the monk for a job well done.";
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				})
			}
		}
	}
})
