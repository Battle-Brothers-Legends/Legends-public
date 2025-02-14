::mods_hookExactClass("events/events/dlc4/kings_guard_2_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_82.png[/img]{You find %guard% stretching about with surprising limberness, and looks nothing at all like the freezing, frigid figure you found abandoned in the ice by those barbarians. Spotting you, the mercenary nods and comes over with a quiet voice.%SPEECH_ON%I\'m glad you trusted in me, captain. Perhaps you did it out of the kindness of your heart, but I need to show you something.%SPEECH_OFF%He flashes an emblem you have heard referenced many times, but have never seen: it carries the sigil of the King\'s Guard and its pristineness is such that there is no way it could have been a farce. The mercenary smiles at you.%SPEECH_ON%I think I am in good health and ready to serve you as I did my liege.%SPEECH_OFF%The kings of these lands have long since fallen, replaced by squabbling lords and nobles. If this mercenary can fight for you as well as for the kings, then the %companyname% has brighter days ahead surely.}";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Dude.getImagePath());
					local bg = this.new("scripts/skills/backgrounds/kings_guard_background");
					bg.m.IsNew = false;
					local oldPerkTree = _event.m.Dude.getBackground().m.CustomPerkTree;
					_event.m.Dude.getSkills().removeByID("background.cripple");
					_event.m.Dude.getSkills().add(bg);
					_event.m.Dude.getBackground().m.RawDescription = "You found %name% frozen half to death in the north. With your help, the former King\'s Guard regained strength and now fights for you.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.getBackground().rebuildPerkTree(oldPerkTree);
					_event.m.Dude.resetPerks();
					_event.m.Dude.improveMood(1.0, "Is his former self again");

					if (_event.m.Dude.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Dude.getMoodState()],
							text = _event.m.Dude.getName() + this.Const.MoodStateEvent[_event.m.Dude.getMoodState()]
						});
					}

					_event.m.Dude.getBaseProperties().MeleeSkill += 12;
					_event.m.Dude.getBaseProperties().MeleeDefense += 7;
					_event.m.Dude.getBaseProperties().RangedDefense += 7;
					_event.m.Dude.getBaseProperties().Hitpoints += 15;
					_event.m.Dude.getBaseProperties().Stamina += 10;
					_event.m.Dude.getBaseProperties().Initiative += 10;
					_event.m.Dude.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.Dude.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+7[/color] Melee Defense"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/ranged_defense.png",
						text = _event.m.Dude.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+7[/color] Ranged Defense"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.Dude.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+12[/color] Melee Skill"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/fatigue.png",
						text = _event.m.Dude.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] Max Fatigue"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/initiative.png",
						text = _event.m.Dude.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] Initiative"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/health.png",
						text = _event.m.Dude.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+15[/color] Hitpoints"
					});
				}
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		onUpdateScore();
		if (this.m.Dude == null)
			return;

		this.m.Score = this.Math.floor(this.m.Dude.getDaysWithCompany() / 3);
	}
})
