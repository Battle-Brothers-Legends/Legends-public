::mods_hookExactClass("events/events/flagellant_vs_monk_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]The campfire shines bright, twisting the company\'s faces in flowing orange as though they themselves were of burning stock.\n\n It is here you find %monk% and %flagellant% talking to one another. Their discussion is, at first, an easy one. The holy figure pleads with the flagellant to set aside %their_flagellant% whip. While you don\'t necessarily wish to step in, you can\'t help but agree that destroying your own body on a glorified gore-schedule is not the best way to live. But then the flagellant retorts with something that gives you both pause. It is a phrase so well crafted that to think it might justify the %person_flagellant%\'s personal habits has you pushing the notion out of your head as fast as possible. Disturbing, too, was the ease with which %they_flagellant% said it. That such a soothing voice could be so warmly bundled in that scarred husk of flesh. What could muster it?\n\n %monk% stammers for a moment, but then puts %their_monk% hands to the flagellant\'s shoulders, holding %them_flagellant% to keep their eyes on one another. %They_monk% whispers, words which tickle your ears, but don\'t pronounce themselves loud enough to have real meaning. You can only assume they are meant to, once again, persuade the flagellant to a better, less violent life.\n\n But, again, the flagellant begins to respond and so back and forth they continue to go.";
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]Deciding to let them talk, you step away for a time. When you return, you find them sitting together. The two saw back and forth on a log, their hands clasped in prayer as whispers of heavenly words part their lips. You\'ve no urge to get closer to hear what they are saying for it is a comforting sight in and of itself. While you have no dog in what way is best to appease the gods, you can\'t help but feel a little better seeing the flagellant put down his tools of self-torture.";
			_screen.start <- function (_event) {
				this.Characters.push(_event.m.Monk.getImagePath());
				this.Characters.push(_event.m.Flagellant.getImagePath());
				local background = ::Legends.Backgrounds.new(::Legends.Background.PacifiedFlagellant);
				local oldPerkTree = _event.m.Flagellant.getBackground().m.CustomPerkTree;
				_event.m.Flagellant.getSkills().removeByID(::Legends.Backgrounds.getID(::Legends.Background.Flagellant));
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
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]Deciding to let them talk, you step away for a time.\n\nWhen you come back, %monk% is naked and bent over with tears in %their_monk% eyes. %Their_monk% shape is craven, but %their_monk% face is gutting as though this is always what %they_monk% wanted. With a gulp of air %they_monk% straightens up and flicks %their_monk% wrist over %their_monk% shoulder. The flagellant\'s whip is in hand and you hear the leather slap against the flogged's back. %they_flagellant% pulls the tool away and the sound of glass and barbs tearing flesh causes a ringing in your ears. The flagellant %themselves_flagellant% says nothing. %they_flagellant% has set %themselves_flagellant% down by %their_flagellant% companion\'s side. %They_flagellant% stares out across the land, but there is hardly a shimmer of life in %their_flagellant% eyes, though you certainly see the blood of %their_flagellant% life leaving %their_flagellant% backside as %they_flagellant% treats %themselves_flagellant% to a beating.\n\nYou step away once more, but the grass beneath your feet doesn\'t have the same crunch to it and the air carries a copper scent. Little leather snickers follow you all the way back to your tent.";
			_screen.start <- function (_event) {
					this.Characters.push(_event.m.Monk.getImagePath());
					this.Characters.push(_event.m.Flagellant.getImagePath());
					local background = ::Legends.Backgrounds.new(::Legends.Background.MonkTurnedFlagellant);
					local oldPerkTree = _event.m.Flagellant.getBackground().m.CustomPerkTree;
					_event.m.Monk.getSkills().removeByID(::Legends.Backgrounds.getID(::Legends.Background.Monk));
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
		});
	}
});
