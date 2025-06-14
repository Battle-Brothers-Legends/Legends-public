::mods_hookExactClass("events/events/dlc8/anatomist_helps_blighted_guy_2_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_58.png[/img]{The supposedly diseased %person_militiacaptain% the anatomists had rescued from the literal grave comes forward. %They_militiacaptain%\'s looking better than ever. %They_militiacaptain% thanks the anatomists for their work, though they regard %them_militiacaptain% with barely any notice at all. It seems %they_militiacaptain% was of more interest to them when %they_militiacaptain% was ill, and they could poke and prod and learn from that which ailed %them_militiacaptain%, and there was some unspoken hope that %they_militiacaptain% would in fact die so they could learn even more. Seeing this, the %person_militiacaptain% then turns to you.%SPEECH_ON%It\'s all much appreciated, I hope at least you know that. You don\'t know what hells I\'ve been through with that lot who tried to bury me alive. I think they knew I wasn\'t no blight, they just wanted my property. See, I used to head the local militia, but that position comes with the weight of conspiracy and jealousy.%SPEECH_OFF%%They_militiacaptain% rubs the back of %their_militiacaptain% head, then comes out with it.%SPEECH_ON%I\'ve nothing else after those gravediggers done taken it all so regardless of whether I\'m alive or dead, I may well be of the latter. So, well, let me just say I\'m glad to be fighting for you and making myself a new living out here.%SPEECH_OFF%}";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.MilitiaCaptain.getImagePath());
					local bg = this.new("scripts/skills/backgrounds/militia_background");
					bg.m.IsNew = false;
					local oldPerkTree = _event.m.MilitiaCaptain.getBackground().m.CustomPerkTree;
					_event.m.MilitiaCaptain.getSkills().removeByID("background.vagabond");
					_event.m.MilitiaCaptain.getSkills().add(bg);
					_event.m.MilitiaCaptain.getBackground().m.RawDescription = "You found %name% being buried alive for carrying some unknown blight. The anatomists took interest in %them% and rescued %them%, nursing %them% back to health. Now, %they% fights for you, putting to use the skills that made %them% captain of the guard in a previous life.";
					_event.m.MilitiaCaptain.getBackground().buildDescription(true);
					_event.m.MilitiaCaptain.getBackground().rebuildPerkTree(oldPerkTree);
					_event.m.MilitiaCaptain.resetPerks();
					_event.m.MilitiaCaptain.improveMood(1.0, "Recovered from the blight afflicting him");

					if (_event.m.MilitiaCaptain.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.MilitiaCaptain.getMoodState()],
							text = _event.m.MilitiaCaptain.getName() + this.Const.MoodStateEvent[_event.m.MilitiaCaptain.getMoodState()]
						});
					}

					_event.m.MilitiaCaptain.getBaseProperties().MeleeDefense += 4;
					_event.m.MilitiaCaptain.getBaseProperties().RangedDefense += 4;
					_event.m.MilitiaCaptain.getBaseProperties().MeleeSkill += 8;
					_event.m.MilitiaCaptain.getBaseProperties().RangedSkill += 7;
					_event.m.MilitiaCaptain.getBaseProperties().Stamina += 3;
					_event.m.MilitiaCaptain.getBaseProperties().Initiative += 6;
					_event.m.MilitiaCaptain.getBaseProperties().Bravery += 12;
					_event.m.MilitiaCaptain.getBaseProperties().Hitpoints += 5;
					_event.m.MilitiaCaptain.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+4[/color] Melee Defense"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/ranged_defense.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+4[/color] Ranged Defense"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+8[/color] Melee Skill"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/ranged_skill.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+7[/color] Ranged Skill"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/fatigue.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] Max Fatigue"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/initiative.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+6[/color] Initiative"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+12[/color] Resolve"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/health.png",
						text = _event.m.MilitiaCaptain.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+5[/color] Hitpoints"
					});
				}
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.MilitiaCaptain.getGender(), "militiacaptain");
	}
})
