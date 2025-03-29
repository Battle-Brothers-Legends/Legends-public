::mods_hookExactClass("events/events/hedgeknight_vs_hedgeknight_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%nonhedgeknight% sprints into your tent, nearly taking out one of the stakes and bringing the whole thing down. Sweat flies off the intruder\'s face and onto your maps. You look at the mercenary with a stare that demands a good answer. The mercenary explains that the hedge knights %hedgeknight1% and %hedgeknight2% are getting into it. They\'ve both picked up weapons and look about ready to kill each other. Having the two largest soldiers in the company do battle probably isn\'t best for the health of... well, everyone. You quickly rush to the scene.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]You find %hedgeknight1% with a great sword in hand and %hedgeknight2% is twirling a giant axe around like a child would a stick. Most of the company have cleared out. %nonhedgeknight% explains that the two {have unfinished business from a jousting tournament | met before on the battlefield, on opposite sides, and now look to continue a battle long past | seek to end a dispute between them by the old tradition of mortal combat}. Another comrade steps forward, begging that the hedge knights put their differences aside, but %hedgeknight2% throws the mediator out of the way. Golems of might and terror that they are, perhaps it is wise to seek an end to this confrontation?";
				s.Options[0].Text = "May the strongest win."
			}
			if (s.ID == "C1") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]%nonhedgeknight% calls out to you, asking you to stop the fight. The two hedge knights look over, each breath heaving their massive chests. You throw a dismissive hand. The knights nod and charge one another. The clash is loud, metal-shattering, bone-crunching. Growls follow every attempt to kill, so sonorous become the weapon swings. The sword catches the shaft of the giant axe and the two blades snap against one another. The hedge knights exchange cruel stares over the crossing, then quickly disarm and pull daggers, stabbing each other repeatedly as they fall to the ground. Neither seems the least bit bothered by the wounds. They give up on the pitiful daggers and turn to using their own mitts, punching each other so fiercely you see teeth scattering amongst the bloodsprays.\n\nAgain, the company looks to you for guidance as it is becoming readily obvious that these two seek to fight to a finish.";
			}
			if (s.ID == "C3") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]The two hedge knights stand there, eyes only on their opponent and with no regard to your words, each breath heaving their massive chests. A short moment and they charge one another. The clash is loud, metal-shattering, bone-crunching. Growls follow every attempt to kill, so sonorous become the weapon swings. The sword catches the shaft of the giant axe and the two blades snap against one another. The hedge knights exchange cruel stares over the crossing, then quickly disarm and pull daggers, stabbing each other repeatedly as they fall to the ground. Neither man seems the least bit bothered by the wounds. They give up on the pitiful daggers and turn to using their own mitts, punching each other so fiercely you see teeth scattering amongst the bloodsprays.\n\nThe company looks to you for guidance as it is becoming readily obvious that these two seek to fight to a finish.";
			}
			if (s.ID == "C2") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]%nonhedgeknight% calls out to you, asking you to stop the fight. The two hedge knights look over, each breath heaving their massive chests. You throw a dismissive hand. The knights nod and charge one another. The clash is loud, metal-shattering, bone-crunching. Growls follow every attempt to kill, so sonorous become the weapon swings. The sword catches the shaft of the giant axe and the two blades snap against one another. The hedge knights exchange cruel stares over the crossing, then quickly disarm and pull daggers, stabbing each other repeatedly as they fall to the ground. Neither man seems the least bit bothered by the wounds. They give up on the pitiful daggers and turn to using their own mitts, punching each other so fiercely you see teeth scattering amongst the bloodsprays.\n\nAgain, the company looks to you for guidance as it is becoming readily obvious that these two seek to fight to a finish.";
			}
			if (s.ID == "C4") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]The two hedge knights stand there, eyes only on their opponent and with no regard to your words, each breath heaving their massive chests. A short moment and they charge one another. The clash is loud, metal-shattering, bone-crunching. Growls follow every attempt to kill, so sonorous become the weapon swings. The sword catches the shaft of the giant axe and the two blades snap against one another. The hedge knights exchange cruel stares over the crossing, then quickly disarm and pull daggers, stabbing each other repeatedly as they fall to the ground. Neither man seems the least bit bothered by the wounds. They give up on the pitiful daggers and turn to using their own mitts, punching each other so fiercely you see teeth scattering amongst the bloodsprays.\n\nThe company looks to you for guidance as it is becoming readily obvious that these two seek to fight to a finish.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img]You bring out a satchel heavy with coins. The two hedge knights look over, the sound of gold clinking against itself hard to miss.%SPEECH_ON%A thousand crowns to each of you, yeah?%SPEECH_OFF%The two exchange a glance. They shrug. You nod.%SPEECH_ON%Alright, but this isn\'t happening again, understand?%SPEECH_OFF%The men nod too, walking over and accepting the crowns with shameless ease. Some comrades look a little miffed that these mercenaries just got free money for essentially choosing not to fight. The hedge knights begrudgingly find peace amongst themselves, being more concerned with counting money than killing each other. You just hope they got an equal amount lest the \'festivities\' resume.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.HedgeKnight1.getImagePath());
					this.Characters.push(_event.m.HedgeKnight2.getImagePath());

					this.World.Assets.addMoney(-2000);
					this.List = [{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]2000[/color] Crowns"
					}];
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getID() == _event.m.HedgeKnight1.getID() || bro.getID() == _event.m.HedgeKnight2.getID())
							continue;

						if (bro.getSkills().hasTrait(::Legends.Trait.Greedy))
							bro.worsenMood(2.0, "Angry about you bribing mercenaries to stop their fight");
						else if (this.Math.rand(1, 100) <= 50)
							bro.worsenMood(1.0, "Concerned about you bribing mercenaries to stop their fight");

						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]Having seen enough, you order the company to intervene. They hesitate, but you quickly remind them of their contractual duties. The mercenaries grab great tarps of leather and blankets and some pots and pans and a few carry buckets. Their strategy is sound: buckets are slammed over the heads of the hedge knights, blinding them just long enough to throw everything else over them. As someone would wrestle a bull, the company tangle with the hedge knights, occasionally being thrown into the air, and one mercenary eats a kick to the face, suffering a black-gapped smile for the troubles. Another is swallowed up in the mass of blankets, being smashed in between the growling hedge knights like an amorphous blob of anger.\n\nEventually, the two knights cool down and the battle is over. They begrudgingly make peace, lest you have the rest of your company pick up real weapons to end the scuffle. The rest of the company recovers, picking themselves up as though a great tornado had just torn through the camp. You take account of the injuries and begin distributing aid.";
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]You set yourself down on a stump and watch the rest of the fight. The two roll around on the ground, smashing each other in the face with punches that would kill a horse. Eventually, %hedgeknight1% squats on %hedgeknight2%\'s shoulders. Seeing a rock nearby, %hedgeknight1% grabs it and cracks it over the opponent\'s skull. A bit of flesh is sheared off, revealing a slop of red and white beneath. The rock is brought down again. The brain pan splinters, shards of bone rupturing into fragments. %hedgeknight2% goes a bit limp, showing only a modicum of fight left in him. %hedgeknight1% punches a fist into the brainbox and rips out the namesake in one big gush of crimson. You gag at the sight, and a few of the company turn and vomit.\n\n%hedgeknight1% gets to his feet and throws the trophy into the tall grass. Wiping the forehead and saying only one word.%SPEECH_ON%Finished.%SPEECH_OFF%";
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.Characters.push(_event.m.HedgeKnight1.getImagePath());
					local dead = _event.m.HedgeKnight2;
					::Legends.addFallen(dead, "Killed in a duel by " + _event.m.HedgeKnight1.getName());
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.HedgeKnight2.getName() + " has died"
					});
					_event.m.HedgeKnight2.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.HedgeKnight2.getSkills().onDeath(this.Const.FatalityType.None);
					this.World.getPlayerRoster().remove(_event.m.HedgeKnight2);
					local injury = _event.m.HedgeKnight1.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.HedgeKnight1.getName() + " suffers " + injury.getNameOnly()
					});

					if (this.Math.rand(1, 2) == 1)
					{
						local v = this.Math.rand(1, 2);
						_event.m.HedgeKnight1.getBaseProperties().MeleeSkill += v;
						this.List.push({
							id = 16,
							icon = "ui/icons/melee_skill.png",
							text = _event.m.HedgeKnight1.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] Melee Skill"
						});
					}
					else
					{
						local v = this.Math.rand(1, 2);
						_event.m.HedgeKnight1.getBaseProperties().MeleeDefense += v;
						this.List.push({
							id = 16,
							icon = "ui/icons/melee_defense.png",
							text = _event.m.HedgeKnight1.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] Melee Defense"
						});
					}

					_event.m.HedgeKnight1.getSkills().update();
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
			if (s.ID == "G") {
				s.start <- function ( _event )
				{
					this.World.Assets.addMoralReputation(-1);
					this.Characters.push(_event.m.HedgeKnight2.getImagePath());
					local dead = _event.m.HedgeKnight1;
					::Legends.addFallen(dead,  "Killed in a duel by " + _event.m.HedgeKnight2.getName());
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.HedgeKnight1.getName() + " has died"
					});
					_event.m.HedgeKnight1.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.HedgeKnight1.getSkills().onDeath(this.Const.FatalityType.None);
					this.World.getPlayerRoster().remove(_event.m.HedgeKnight1);
					local injury = _event.m.HedgeKnight2.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.HedgeKnight2.getName() + " suffers " + injury.getNameOnly()
					});

					if (this.Math.rand(1, 2) == 1)
					{
						local v = this.Math.rand(1, 2);
						_event.m.HedgeKnight2.getBaseProperties().MeleeSkill += v;
						this.List.push({
							id = 16,
							icon = "ui/icons/melee_skill.png",
							text = _event.m.HedgeKnight2.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] Melee Skill"
						});
					}
					else
					{
						local v = this.Math.rand(1, 2);
						_event.m.HedgeKnight2.getBaseProperties().MeleeDefense += v;
						this.List.push({
							id = 16,
							icon = "ui/icons/melee_defense.png",
							text = _event.m.HedgeKnight2.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] Melee Defense"
						});
					}

					_event.m.HedgeKnight2.getSkills().update();
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
			if (s.ID == "H") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]The monk nods, stepping forward and calmly walking between the two fighters. With hands raised, the fingers trailing to and fro as they mimic the shapes of old religious rites. the holy one speaks of the gods and how they judge folks for what they are and what they do. Some gods might find this battle favorable, but most would not. Most of all, though, the holy one says that if they truly wish to fight, then there is plenty of room for that after they die. However, if they kill one another, the loser is given great prestige in the afterlife, and the winner will not, for this violence serves no purpose than to give the victor pride. Surprisingly, this oddity in religious rules calms the fighters down. The monk invites them to talk more and they do so, the three walking off, hands gesticulating, backs arching in bellowing laughter. As for the rest of the company, they just seem happy nobody got killed.";
				s.start <- function ( _event )
				{
					this.World.Assets.addMoralReputation(2);
					this.Characters.push(_event.m.Monk.getImagePath());

					if (!_event.m.Monk.getFlags().has("resolve_via_hedgeknight"))
					{
						_event.m.Monk.getFlags().add("resolve_via_hedgeknight");
						_event.m.Monk.getBaseProperties().Bravery += 2;
						_event.m.Monk.getSkills().update();
						this.List = [{
							id = 16,
							icon = "ui/icons/bravery.png",
							text = _event.m.Monk.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] Resolve"
						}];
					}
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
		}
	}
})
