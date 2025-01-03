::mods_hookExactClass("events/events/flagellant_vs_monk_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]The campfire shines bright, twisting the company\'s faces in flowing orange as though they themselves were of burning stock.\n\n It is here you find %monk% and %flagellant% talking to one another. Their discussion is, at first, an easy one. The holy figure pleads with the flagellant to set aside his whip. While you don\'t necessarily wish to step in, you can\'t help but agree that destroying your own body on a glorified gore-schedule is not the best way to live. But then the flagellant retorts with something that gives you both pause. It is a phrase so well crafted that to think it might justify the man\'s personal habits has you pushing the notion out of your head as fast as possible. Disturbing, too, was the ease with which he said it. That such a soothing voice could be so warmly bundled in that scarred husk of flesh. What could muster it?\n\n The pious one stammers for a moment, but then puts hands to the flagellant\'s shoulders, holding him to keep their eyes on one another. Whispering words which tickle your ears, but don\'t pronounce themselves loud enough to have real meaning. You can only assume they are meant to, once again, persuade the flagellant to a better, less violent life.\n\n But, again, the flagellant begins to respond and so back and forth they continue to go."
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]Deciding to let them talk, you step away for a time. When you return, you find them sitting together. The two saw back and forth on a log, their hands clasped in prayer as whispers of heavenly words part their lips. You\'ve no urge to get closer to hear what they are saying for it is a comforting sight in and of itself. While you have no dog in what way is best to appease the gods, you can\'t help but feel a little better seeing the flagellant put down his tools of self-torture.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Monk.getImagePath());
					this.Characters.push(_event.m.Flagellant.getImagePath());
					local background = this.new("scripts/skills/backgrounds/pacified_flagellant_background");
					local oldPerkTree = _event.m.Flagellant.getBackground().m.CustomPerkTree;
					_event.m.Flagellant.getSkills().removeByID("background.flagellant");
					_event.m.Flagellant.getSkills().add(background);
					_event.m.Flagellant.m.Background = background;
					background.buildDescription();
					background.rebuildPerkTree(oldPerkTree);
					_event.m.Flagellant.resetPerks();
					this.List = [
					{
						id = 13,
						icon = background.getIcon(),
						text = _event.m.Flagellant.getName() + " is now a Pacified Flagellant"
					}
					];
					_event.m.Monk.getBaseProperties().Bravery += 2;
					_event.m.Monk.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Monk.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
					});
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]Deciding to let the men talk, you step away for a time.\n\nWhen you come back, the religious official is naked and bent over with teary eyes. With a craven shape, but face gutting as though this was always wanted. They straighten up with a gulp of air and a flicked wrist over the shoulder. The flagellant\'s whip is in hand and you hear the leather slap against the clean back. He pulls the tool away and the sound of glass and barbs tearing flesh causes a ringing in your ears. The flagellant himself says nothing. He has set himself down by the religious one\'s side. He stares out across the land, but there is hardly a shimmer of life in his eyes, though you certainly see the blood of his life leaving his backside as he treats himself to a beating.\n\nYou step away once more, but the grass beneath your feet doesn\'t have the same crunch to it and the air carries a copper scent. Little leather snickers follow you all the way back to your tent.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Monk.getImagePath());
					this.Characters.push(_event.m.Flagellant.getImagePath());
					local background = this.new("scripts/skills/backgrounds/monk_turned_flagellant_background");
					local oldPerkTree = _event.m.Flagellant.getBackground().m.CustomPerkTree;
					_event.m.Monk.getSkills().removeByID("background.monk");
					_event.m.Monk.getSkills().add(background);
					_event.m.Monk.m.Background = background;
					background.buildDescription();
					background.rebuildPerkTree(oldPerkTree);
					_event.m.Monk.resetPerks();
					this.List.push({
						id = 13,
						icon = background.getIcon(),
						text = _event.m.Monk.getName() + " is now a Monk turned Flagellant"
					});
					_event.m.Flagellant.getBaseProperties().Bravery += 2;
					_event.m.Flagellant.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Flagellant.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
					});
				}
			}
		}
	}
})
