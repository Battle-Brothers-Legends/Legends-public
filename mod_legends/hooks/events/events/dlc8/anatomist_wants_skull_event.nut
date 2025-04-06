::mods_hookExactClass("events/events/dlc8/anatomist_wants_skull_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_16.png[/img]{You come to a remote village to find a few of its peoples crouched before a large, bleached skull decoratively set on a lectern. Passing peasants pause and profess faith to it. As you get closer, you realize the skull itself is extraordinary: a long, thick forehead juts out from the top, its brow quite dominant and ridged, and the jaw of it, still intact, carries enormous and sharp teeth, most of which are in a state of disorder, as if in any ordinary head closing such a mouth would be a danger to itself. What it very well may be is a Nachzehrer\'s skull. Naturally, with this strange skeletal sight before you, you hope to turn the company away before-%SPEECH_ON%We should take that for studying.%SPEECH_OFF%Sighing, you turn to see %anatomist% standing there, ogling the skull. You correct %them_anatomist%, saying instead that what %they_anatomist% really means is %they_anatomist% intends to steal it. The anatomist stares at you.%SPEECH_ON%The vocabulary needn\'t matter, when the studying is done, it will be of better use in our hands than theirs, that much is clear.%SPEECH_OFF%}";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_46.png[/img]{Sighing, you agree to the anatomist\'s fancies, but you tell %them_anatomist% that it will be %they_anatomist% who does the stealing, if it is %they_anatomist% who wishes to do the studying. The man doesn\'t even hesitate and heads off, eyes narrowed to the bony item central to %their_anatomist% scientific fancy. You\'re not going to be responsible for the mayhem that goes down if %they_anatomist% is caught so you leave %them_anatomist% to it, returning instead to count inventory while keeping your ears perked for sounds of religion wrecking chaos. A few moments later, %anatomist% returns, a fat skull cradled under an arm and a bit of sweat on %their_anatomist% brow.%SPEECH_ON%It\'s a Nachzehrer\'s skull and should be of great value to our studies.%SPEECH_OFF%Curious, you ask %them_anatomist% how it was that %they_anatomist% managed to get the skull in the first place. %anatomist% raises an eyebrow.%SPEECH_ON%You weren\'t watching? I thought the endeavor was quite impressive, but alas so impressive that I believe telling it second hand will make you susceptible to believing me to tell a tall tale. A fable, if you will. Just know that we should probably get out of here soon. Perhaps sooner than soon, and quicker than quick. Do you understand?%SPEECH_OFF%A din of shouting grows in the distance. The anatomist wipes %their_anatomist% brow and turns and walks away. The back of %their_anatomist% shirt is clawed apart and there are little darts or arrows sticking out of %their_anatomist% back - and those distant shouts are getting louder.}";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img]{You tell %anatomist% %they_anatomist% can take the skull. %They_anatomist% stares at you for a time, then says %they_anatomist% thought you were the one that was going to do it. You tell %them_anatomist% there\'s no way you\'re taking a skull from local peasants who worship said skull. If %they_anatomist% wishes to do the studying, then it is %they_anatomist% who should do the stealing. %anatomist% draws a hand to %their_anatomist% chest.%SPEECH_ON%I\'m a %their_anatomist% of science, and no ordinary scribe, I could not deign myself to a task of such lowness. It requires someone of knowhow, one who understands the grit and grime of daily life, to steal this skull.%SPEECH_OFF%The anatomist clenches a fist, so certain that %their_anatomist% speech is not an insult to you, and %their_anatomist% eyes staring off with determined ferocity that could only be vicarious at best.%SPEECH_ON%What the fark you two strangers talkin\' about?%SPEECH_OFF%You both turn around to see a peasant holding a pitchfork, and as a few more join %them_anatomist% %they_anatomist% motions toward you.%SPEECH_ON%These fellas were aimin\' to steal the skull!%SPEECH_OFF%You hold your hands out, explaining that- before you finish, %anatomist% turns and sprints away. Thinking fast, you call %them_anatomist% a thief and promise to have %their_anatomist% head, making a grand show of drawing out your sword and waving it at the peasants. You pretend to accidentally drop a purse of crowns, turning the peasants\' anger into greed, and giving you enough time to escape.}";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_65.png[/img]{Sighing, you agree to the idea of stealing the skull. Before you can say anything more, %thief% the thief appears. %They_thief% comes up chewing grass and walking with swagger.%SPEECH_ON%So you wanna steal something, hm? Just point at whatcha need and I\'ll go and fetch it for you. Is it gold? A weapon?%SPEECH_OFF%%anatomist% points at the skull. The thief stares at it for a time before turning back.%SPEECH_ON%Oh, uh, alright.%SPEECH_OFF%The thief and would be skull stealer wanders off. You go and count inventory, giving %them_thief% time to do %their_thief% job. %They_thief% later returns with the skull in tow, as well as a bevy of weapons and armor which you know %they_thief% didn\'t buy. As you stare at the clearly lifted goods, the man shrugs.%SPEECH_ON%What? I had to make it worth my time.%SPEECH_OFF%The anatomist takes the skull away without saying a word, carrying it off while staring into its emptied eyesockets as though it were a lover, muttering that many things will be learned from its vacant stare. The thief does the same, but instead with a satchel of crowns and other goodies, %themselves_thief% muttering that %they_thief%\'ll finally be able to afford two whores at the same time, an apparent long held dream of %their_thief%. You take the weapons and armor to inventory, and in the distance you hear the wailing of peasants looking for the relic.}";
				s.start <- function ( _event ) {
					_event.m.Anatomist.improveMood(1.0, "Acquired an unusual skull to study");
					_event.m.Thief.improveMood(1.0, "Successfully stole from the peasantry");

					if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
							text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
						});
					}

					if (_event.m.Thief.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Thief.getMoodState()],
							text = _event.m.Thief.getName() + this.Const.MoodStateEvent[_event.m.Thief.getMoodState()]
						});
					}

					_event.m.Anatomist.addXP(100, false);
					_event.m.Anatomist.updateLevel();
					this.List.push({
						id = 16,
						icon = "ui/icons/xp_received.png",
						text = _event.m.Anatomist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+100[/color] Experience"
					});
					local initiativeBoost = this.Math.rand(2, 4);
					_event.m.Thief.getBaseProperties().Initiative += initiativeBoost;
					_event.m.Thief.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/initiative.png",
						text = _event.m.Thief.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiativeBoost + "[/color] Initiative"
					});
					local item;
					local weaponList = [
						"militia_spear",
						"militia_spear",
						"militia_spear",
						"shortsword",
						"falchion",
						"light_crossbow"
					];
					local itemAmount = this.Math.rand(1, 2);

					for( local i = 0; i < itemAmount; i = ++i ) {
						item = this.new("scripts/items/weapons/" + weaponList[this.Math.rand(0, weaponList.len() - 1)]);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You gain " + item.getName()
						});
						this.World.Assets.getStash().add(item);
					}

					local armorList = this.Const.World.Common.pickArmor([
						[1, "leather_tunic"],
						[1, "leather_tunic"],
						[1, "thick_tunic"],
						[1, "thick_tunic"],
						[1, "padded_surcoat"],
						[1, "padded_leather"]
					]);
					itemAmount = this.Math.rand(1, 2);

					for( local i = 0; i < itemAmount; i = ++i ) {
						item = this.new(armorList[this.Math.rand(0, armorList.len() - 1)]);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You gain " + item.getName()
						});
						this.World.Assets.getStash().add(item);
					}

					this.Characters.push(_event.m.Anatomist.getImagePath());
					this.Characters.push(_event.m.Thief.getImagePath());
				}
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_43.png[/img]{You decide that if the anatomists can make some grand use of the skull, then you\'ll abide by giving them the chance to study it. The question is how does one go about stealing a hideous skull from a group so insane they\'d worship it? Almost as if on cue, %wildman% the wild%person_wildman% appears, chowing down on a handful of worms. %Their_wildman% nature-rinsed face and cruelly shaped skull seem almost kin to the monstrosity which resides on the village\'s town center lectern. %anatomist% snaps %their_anatomist% fingers and claims to have an idea. %They_anatomist% pulls the wild%person_wildman% forward, and the two walk straight toward the village\'s beloved skull.\n\nThe anatomist pushes the wild%person_wildman% before the praying folk, and claims that they have murdered one who is cousin to %their_wildman% being. %They_anatomist% states that by stealing the skull of %their_wildman% kin, they have doomed %them_wildman% to a life of being cursed. The crowd is horrified, not realizing the error of their ways. The wild%person_wildman% eats another worm. You continue to watch as the anatomist picks up the skull, lofts it over %their_anatomist% head, and says that with this %they_anatomist% may finally heal %wildman% of what ails %them_wildman%, and through %them_wildman% also lift any curses which have befallen the village itself. By this point the crowd is arisen, taken to the anatomist like a tentpole priest, and they clap as %they_anatomist% leaves, cheering the theft as it were, the skull lofted above %their_anatomist% head. The two men return to you. %anatomist% grins.%SPEECH_ON%To study the body, one shouldn\'t forget to study the mind, and in studying the mind, one shouldn\'t forget to study minds, plural! For many minds put together are a creature to study in and of themselves.%SPEECH_OFF%The anatomist walks off. A group of peasants approach carrying goods of all sorts. They throw them at the feet of %wildman% in apology. The wild%person_wildman% eats another worm.}";
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Anatomist.getGender(), "anatomist");
		if (this.m.Thief != null)
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Thief.getGender(), "thief");
		if (this.m.Wildman != null)
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Wildman.getGender(), "wildman");
	}
})
