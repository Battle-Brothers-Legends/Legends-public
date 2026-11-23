::mods_hookExactClass("events/events/dlc8/anatomist_helps_blighted_guy_1_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_53.png[/img]{You come across a %person_dude% being buried alive, an inference you take from the fact that %they're_dude% bound like a dead %person_dude% yet still screaming about the whole affair. You ask what is going on and one of the diggers turns and holds a hand out.%SPEECH_ON%Keep yer distance. This %person_dude% is blighted and anyone %they_dude% touches becomes blighted. We don\'t want no disease, and neither should you.%SPEECH_OFF%The %person_dude% cries out for help as another clump of soil lands on %them_dude%. %They_dude% tries to climb back out of the grave but one of the diggers kicks %them_dude% back in, the kicker himself complaining he\'ll have to burn his favorite boot. %anatomist% comes over with a quieted voice. %They_anatomist% says the %person_dude% has a skin disease which might look like leprosy or a plague, but is in fact benign. You ask if %they're_anatomist% sure of it, and %they_anatomist% nods, albeit with a finger of reluctance held up.%SPEECH_ON%I may be wrong, of course. And if I am, then %their_dude% very real disease might spawn itself upon us all. But to bury a %person_dude% alive is not something I find, how do you say, scientifically compelling.%SPEECH_OFF%}";
			_screen.Options[0].Text = "In that case we\'re going to help %them_dude%.";
			_screen.start = function (_event) {
				local roster = ::World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx(["vagabond_background"], false);
				_event.m.Dude.setTitle("");
				_event.m.Dude.getFlags().set("IsSpecial", true);
				_event.m.Dude.getBackground().m.RawDescription = "" + _event.m.Anatomist.getNameOnly() + " the Anatomist rescued %name% from being buried alive for carrying some strange disease. Now %they% has the unique pleasure of both bearing the plague AND being a lab rat for some researchers. Stay over there, please.";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(::Const.Attributes.COUNT, 0);
				talents[::Const.Attributes.MeleeSkill] = 2;
				talents[::Const.Attributes.MeleeDefense] = 2;
				talents[::Const.Attributes.Bravery] = 2;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

				if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null) {
					_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Offhand) != null) {
					_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Head) != null) {
					_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Head).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Body) != null) {
					_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Body).removeSelf();
				}

				_event.m.Dude.worsenMood(1.5, "Was almost buried alive for bearing a disease");
				local i = ::new("scripts/skills/injury/sickness_injury");
				i.addHealingTime(8);
				_event.m.Dude.getSkills().add(i);
				_event.m.Dude.getFlags().set("IsMilitiaCaptain", true);
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_88.png[/img]{You draw out your sword and order the diggers to stop. They look at you with incredulous stares. One points at the %person_dude% in the grave.%SPEECH_ON%Did you not hear? This one is blighted. What we\'re doing here might not look right but-%SPEECH_OFF%With a point of your sword, the digger falls quiet. You tell the %person_dude% in the grave to hop on out, and as %they_dude% does the diggers drop their shovels and back off. They tell you %they're_dude% all yours. The supposedly diseased %person_dude% ambles over, still frightened and no doubt unsure if %their_dude% rescuers have anything better in mind for %them_dude% than those who would bury %them_dude% alive. %anatomist% takes %them_dude% under %their_anatomist% wing and you slowly fall back. The anatomist states that the %person_dude% is ill, but it\'s not serious and %they_dude% will recover in good time. For now, though, %they_dude% needs rest.}";
			_screen.start = function (_event) {
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_18.png[/img]{In the most reluctant rescue ever, you sigh and draw out your sword, ordering the diggers to stop immediately. They look over at you, their hands on their shovels, their eyebrows far up their brows.%SPEECH_ON%What? Did ye you not hear us? This one\'s blighted!%SPEECH_OFF%%anatomist% comes forward and waves them off. You nod and gesture for the diggers to do as told. The anatomist helps the %person_dude% out of the grave, though you notice %they're_anatomist% doing it with %their_anatomist% own sleeve and hand covered. %They_dude% is helped back to the company. As the %person_dude% turns to thank you, %anatomist% drives a hammer into the back of %their_dude% head, knocking %them_dude% out cold. The anatomist follows %them_dude% to the ground and begins to cut up the %person_dude%\'s arm, removing a slab of flesh before backing away.%SPEECH_ON%This should be good enough for our studies, I believe.%SPEECH_OFF%You ask if the %person_dude% was indeed sick. The anatomist nods.%SPEECH_ON%Of course, but it\'s better if %they're_dude% at least useful while sick instead of just dead in the ground like some worm. %They_dude% may, of course, go die now. There is not much left for %them_dude% in this world.%SPEECH_OFF%The %person_dude% moans as %they_dude% writhes on the ground. There\'s a bit of a jangle in %their_dude% boots which you remove to find stowed away crowns. You briefly consider putting %them_dude% out of %their_dude% misery, but decide that now %they're_dude% free of the grave %they_dude% may %themselves_dude% decide how %they_dude% wishes to return to it. You do, however, take %their_dude% money.}";
			_screen.Options[0].Text = "Good luck out there, %person_dude%.";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]{You tell the %person_dude that the %companyname% doesn\'t need anymore sellswords. You also imply that, before %they_dude% goes, %they_dude% should maybe consider compensating you for the help. %They_dude% nods and takes off %their_dude% boot, revealing %they_dude% had gold stashed in there. Not trusting what illness %they_dude% has, you tell %them_dude% to rub the coins on the grass and then kick it over with %their_dude% feet. %They_dude% does as told. %They_dude% nods.%SPEECH_ON%Well. I appreciate it. You take care out there.%SPEECH_OFF%}";
			_screen.start = function (_event) {
				::World.Assets.addMoney(65);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]65[/color] Crowns"
				});

				if (::Math.rand(1, 100) < 75) {
					_event.m.Anatomist.worsenMood(0.75, "Was denied the study of an unusual illness");
				} else {
					_event.m.Anatomist.worsenMood(0.5, "Was denied the chance to help a sick %person_dude%");
				}
			}
		});
	}
});
