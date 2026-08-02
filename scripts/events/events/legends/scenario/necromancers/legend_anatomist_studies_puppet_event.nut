this.legend_anatomist_studies_puppet_event <- this.inherit("scripts/events/event", {
	m = {
		Puppet = null,
		Anatomist = null
	},

	function create() {
		this.m.ID = "event.legend_anatomist_studies_puppet";
		this.m.Title = "Too Curious...";
		this.m.Cooldown = 48.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]As you check in on your supplies, you overhear a commotion — someone is arguing loudly but receiving no response. Fearing the worst, you hurry to investigate and find %anatomist% and %puppet% in a one-sided standoff. The anatomist is circling the thrall with great interest, making notes within notes to a small stained ledger. %puppet% seems completely unamused, lolling %their_puppet% jaw and only briefly tracking %their_puppet% observer when %they_anatomist% moves slightly too fast and comes across more as prey.%SPEECH_ON%Can you PLEASE just stay still? If only for a moment!?%SPEECH_OFF%%They_anatomist% frustratingly turns and circles counter-clockwise, stopping to see you.%SPEECH_ON%I have never been able to get this close to something like this before! At least not... well...%SPEECH_OFF%You get the strong impression a request is about to follow.%SPEECH_ON%I just need to do a little examination. Just something very small to prove a theory of mine.%SPEECH_OFF%%They_anatomist% subsequently trails off. Another thought has crossed %their_anatomist% mind. %Their_anatomist% eyes light up as %puppet% tracks a bird.%SPEECH_ON%You could let me... you know... 'examine' it further. It won\'t survive of course — but it is already dead, no?%SPEECH_OFF% ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You can look, but best not touch.", //study and get a little xp for anatomist
					getResult = @(_event) "B"
				},
				{
					Text = "I'm not sacrificing a thrall. Go ahead and touch but don\'t blame me if you get hurt.", //more xp but could lose a finger
					getResult = @(_event) ::Math.rand(1, 100) <= 45 ? "C" : "D"
				},
				{
					Text = "Do whatever you want with it. Kill it — take it apart.", //dissect thrall, large xp for everyone but thrall bro dies
					getResult = @(_event) "E"
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Puppet.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B", //study and get a little xp for anatomist
			Text = "[img]gfx/ui/events/event_63.png[/img]Dejected, %anatomist% brings to bear a second, larger, heavier book. Pulling up a chair, %they_anatomist% makes great pains in sketching out the form of %puppet%, including noting down pre and post damage to their condition. The frenzied scribbling lasts an hour and %anatomist% never gets within a few feet of %puppet%. %They_anatomist% ends %their_anatomist% frenzied state with numerous angry question marks over some of their larger notes. %SPEECH_ON%That\'ll have to do.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Curiosity sated.",
					getResult = @(_event) 0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.List.extend([
					::Legends.EventList.changeMood(_event.m.Anatomist, 0.5, "Studied a living cadaver"),
					::Legends.EventList.changeBroExperience(_event.m.Anatomist, ::Math.rand(30, 200))
				]);
			}
		});
		this.m.Screens.push({
			ID = "C", //more xp but lose a finger
			Text = "[img]gfx/ui/events/event_19.png[/img]%anatomist% begins at once — clearly well prepared for this situation. %They_anatomist% begins with poking and prodding %puppet% with a cane. Methodically testing the reaction times and effects of the stick on the cadaver. Nothing much happens as the corpse simply daydreams the punishment away.\n\nA new tool comes out, this one with a pronounced point. The anatomist stabs into the shoulder of %puppet%, provoking a mild response but nothing more. Suddenly, something catches %their_anatomist% eye between changing tools. Something you didn\'t notice. %They_anatomist% moves towards %puppet% and casts an eye down %their_puppet% lolling jaw. %SPEECH_ON%I think... I think I see something!%SPEECH_OFF% Before you can intercede, %anatomist% sticks a finger down the throat of %puppet%. Suddenly there is screaming. Blood — with a slow, gentle crunching sound from %puppet%.\n%anatomist% quickly bandages %their_anatomist% finger and douses it with a foul smelling liquid. But between gasps and gritted curses quickly commits what %they_anatomist% saw to parchment.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Have you had enough now?",
					getResult = @(_event) 0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Puppet.getImagePath());		
				this.List.extend([
					::Legends.EventList.changeMood(_event.m.Anatomist, -1.0, "Lost a finger in search of knowledge"),
					::Legends.EventList.addInjury(_event.m.Anatomist, "injury.missing_finger"),
					::Legends.EventList.changeBroExperience(_event.m.Anatomist, ::Math.rand(280, 550))
				]);
			}

		});
		this.m.Screens.push({
			ID = "D", //more xp but don't lose a finger
			Text = "[img]gfx/ui/events/event_15.png[/img]%anatomist% begins at once — clearly well prepared for this situation. %They_anatomist% begins with poking and prodding %puppet% with a cane. Methodically testing the reaction times and effects of the stick on the cadaver. Nothing much happens as the corpse simply daydreams the punishment away.\n\nA new tool comes out, this one with a pronounced point. The anatomist stabs into the shoulder of %puppet%, provoking a mild response but nothing more. Suddenly, something catches %their_anatomist% eye between changing tools. Something you didn\'t notice. %They_anatomist% moves towards %puppet% and casts an eye down %their_puppet% lolling jaw. %SPEECH_ON%I think... I think I see something!%SPEECH_OFF% Before you can intercede, %anatomist% sticks a finger down the throat of %puppet%. Initially, the puppet seems to resist, but eventually calms down and stares in response with pallid eyes. The anatomist withdraws %their_anatomist% fingers, producing a black mucus dripping from the ends. %They_anatomist% quickly bottles the substance and keenly observes it outside under the sun. %They_anatomist% stays transfixed as a cat by a bird — occasionally tapping the vial for any reaction and making frantic, yet methodical notes.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s enough for one day.",
					getResult = @(_event) 0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.List.extend([
					::Legends.EventList.changeMood(_event.m.Anatomist, 1.5, "Performed a study on the living dead"),
					::Legends.EventList.changeBroExperience(_event.m.Anatomist, ::Math.rand(280, 550)),
				]);
			}

		});
		this.m.Screens.push({
			ID = "E", //kill zombie but get a ton of xp for everyone
			Text = "[img]gfx/ui/events/event_63.png[/img]%anatomist%, with a sudden spring in their step, unfurls an array of tools of unclear purpose - be it medical or torture. %They_anatomist% retreat to %their_anatomist% tent, only to emerge with thin gloves, a face covering and what you can only surmise as a butcher\'s apron. %They_anatomist% finds a spare table and sets out an open air surgery in the middle of the camp. The rest of %companyname% originally pays no notice, but keeps a curious eye on the excitement. You order %puppet% to shed it\'s armour and climb onto the table. To no surprise %anatomist% does not make any effort to put the creature out of it\'s misery for what comes next.\n\n%anatomist% starts at the legs, mumbling to %themselves_anatomist% as %their_anatomist% carpenter\'s saw bites into the dead flesh. %SPEECH%_ON%...and here, the damage from the weight of the armour is starting to show. The amount of weight needed to hold itself up and all that metal has caused the bone to come under tremendous stress...%SPEECH_OFF%%randombro% passes by, and is pulled into observing what is going on with a morbid curiosity. The surgeon does not pause. %SPEECH_ON%...over here — a similar story in the upper arms. In some places broken but still functional enough to swing or grab...%SPEECH_OFF%%anatomist% hands a part of %puppet%, who is calmly observing %their_puppet% own vivisection, to the now growing crowd, who are nodding along.%SPEECH_ON%...and now...%SPEECH_OFF%The anatomist stops in %their_anatomist% tracks as %they_anatomist% cuts open the chest. To you, all you see is a putrid mass of decayed organs in a slurry or jellied state. But to the trained eye, something seems amiss here. The silence is broken by a cleaver hacking violently at the neck of %puppet%, who offers no resistance aside from a gurgle. %anatomist% severs the head on the third swing, which curiously refuses to die. After inspecting the still-living head as a washerwoman would a melon, the anatomist scoops out a black mucus from inside the throat from the wrong end. In doing this, the head spasms and falls silent. As %they_anatomist% commit some notes, you see quite a crowd has formed, all of which seem to be visually dissecting the remains on the table.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Crisis averted.",
					getResult = @(_event) 0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Anatomist.getImagePath());

				_event.m.Puppet.getItems().transferToStash(::World.Assets.getStash());
				::World.getPlayerRoster().remove(_event.m.Puppet);
				this.List.extend([
					::Legends.EventList.changeMood(_event.m.Anatomist, 3.0, "Vivisected and thoroughly studied the living dead")
				]);
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (::Math.rand(1, 100) <= 50) {
						this.List.extend([
							::Legends.EventList.changeBroExperience(bro, ::Math.rand(390, 1700)),
						]);
						local trait = ::Legends.Trait.FearUndead;
						if(::Legends.Traits.has(bro, trait))
						{
							this.List.extend([{
								id = 10,
								icon = trait.getIcon(),
								text = _event.m.Casualty.getName() + " no longer fears undead"
							}]);
							::Legends.Traits.remove(bro, trait);
						}
					}
				}
				this.List.push({
					id = 11,
					icon = "ui/icons/kills.png",
					text = _event.m.Puppet.getName() + " [color=%negative%]has been dismembered and met %their% final death.[/color]"
				});
			}
		});
	}

	function onUpdateScore() {
		if (!::World.getTime().IsDaytime) {
			return;
		}

		if (::Stash.getNumberOfEmptySlots() < 8) { //must have 8 stash spaces free or more, due to the fact that when the puppet is killed, we need to account for all possible gear slots (1h, offhand, head, body, x2 bag, ammo & accessory) being filled so these items are not destroyed.
			return;
		}

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 5) { //must have at least 5 fighters or more, to pad against sacrificing a fighter too early on
			return;
		}
		
		local candidates_puppet = [];
		local candidates_anatomist = [];

		foreach (bro in brothers) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Player)) {
				continue;
			}
			//puppet must be lvl 7 or higher to justify the cost of the sacrifice
			if (bro.getLevel() < 7
				&& ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendPuppet))
			{
				candidates_puppet.push(bro);
			}
			//Anatomist cannot have missing finger already
			else if (::Legends.Backgrounds.has(bro, ::Legends.Background.Anatomist)
				&& !bro.getSkills().hasSkill("injury.missing_finger"))
			{
				candidates_anatomist.push(bro);
			}
		}

		if (candidates_puppet.len() == 0 || candidates_anatomist.len() == 0) {
			return;
		}

		this.m.Puppet = candidates_puppet[::Math.rand(0, candidates_puppet.len() - 1)];
		this.m.Anatomist = candidates_anatomist[::Math.rand(0, candidates_anatomist.len() - 1)];

		this.m.Score = candidates_puppet.len() * 8;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"puppet",
			this.m.Puppet.getName()
		]);
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
	}

	function onClear() {
		this.m.Puppet = null;
		this.m.Anatomist = null;
	}
});
