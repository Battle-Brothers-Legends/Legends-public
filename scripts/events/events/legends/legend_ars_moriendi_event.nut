this.legend_ars_moriendi_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		DeathwishBro = null,
		DoubleTonguedBro = null,
		Optimist = null,
		Pessimist = null,
		Scholar = null
	},

	function create() {
		this.m.ID = "event.legend_ars_moriendi";
		this.m.Title = "During camp...";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //— \n
			ID = "A",
			Text = "[img]gfx/ui/events/event_39.png[/img]Ambling through the camp, you hear a raised voice syllabizing words forcibly as to give a lecture. Your pace quickens as you locate the noise.\n\nOnly a few moments later, you spot %scholar% holding court before a flickering fire. In %their_scholar% hands is a crumbling, leather-bound tome, its pages thick with age.%SPEECH_ON%...and so the fourth failing is despair! When the veil tears and the blood runs cold — the mind will try to convince you that your struggles were for naught! You must not let the abyss break your spirit before your heart stops!%SPEECH_OFF%You notice the book is filled with macabre woodcuts: skeletal hands dragging men into the earth, towering greenskins standing over broken bodies...and terrified mercenaries surrounded by creeping, formless shadows.\n\nSpotting you, %scholar% quickly explains the tome as a salvaged text from the days of the Old Empire — a treatise on how to die well, and how to best prepare for it. The company looks uneasy, glancing at the flickering shadows beyond the firelight, acutely aware of their own mortality.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A man's true measure is displayed in his final moments.",
					getResult = @(_event)"B"
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				if (_event.m.Pessimist != null) {
					this.Options.push({
						Text = "What is %pessimist% groaning about now?",
						getResult = @(_event)"D"
					});
				}
				if (_event.m.Optimist != null) {
					this.Options.push({
						Text = "%optimist% seems entirely unbothered.",
						getResult = @(_event)"E"
					});
				}
				if (_event.m.DoubleTonguedBro != null) {
					this.Options.push({
						Text = "Let's hear %doubletonguedbro%'s take on this.",
						getResult = @(_event)"F"
					});
				}
				if (_event.m.DeathwishBro != null) {
					this.Options.push({
						Text = "%deathwishbro% is staring intently at the woodcuts.",
						getResult = @(_event)"G"
					});
				}
				if (_event.m.Cultist != null) {
					this.Options.push({
						Text = "%cultist% is shaking %their_cultist% head.",
						getResult = @(_event)"H"
					});
				}
				this.Options.push({
					Text = "This has to be stopped.",
					getResult = @(_event)"C"
				});
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_39.png[/img]Stepping into the centre you nod, visibly.%SPEECH_ON%We sell our lives for coin, and eventually, that debt may come due. If your time comes, meet it with a steady hand. Let whatever gods are watching know that you died a proud mercenary of this company!%SPEECH_OFF%%scholar% looks pleased to have your backing, and a stoic quiet falls over the company. A few men don't seem to be too keen on the idea though — they may not like the thought, but they will respect the grim truth of it.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Rest now. Tomorrow we march.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				local entry = ::Legends.EventList.changeMood(_event.m.Scholar, 1.0, "Felt validated by the commander");
				if (_event.m.Scholar.getMoodState() > ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					local skills = bro.getSkills();
					if (skills.hasTrait(::Legends.Trait.Pessimist)
						&& this.Math.rand(1, 100) <= 75)
					{
						entry = ::Legends.EventList.changeMood(bro, -1.0, "Didn't like the sermon about death");
						if (bro.getMoodState() < ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					} else if (skills.hasTrait(::Legends.Trait.Optimist)
						&& this.Math.rand(1, 100) <= 75)
					{
						entry = ::Legends.EventList.changeMood(bro, 1.0, "Felt reassured by captain's words");
						if (bro.getMoodState() > ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					} else if (this.Math.rand(1, 100) <= 25) {
						entry = ::Legends.EventList.changeMood(bro, 0.25, "Felt reassured by captain's words");
						if (bro.getMoodState() > ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					} else if (this.Math.rand(1, 100) <= 50) {
						entry = ::Legends.EventList.changeMood(bro, -0.5, "Didn't like the sermon about death");
						if (bro.getMoodState() < ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_39.png[/img]You step forward and snatch the book out of the preacher's hands, snapping it shut with a thunderclap. %They_scholar% stumbles back with a glint of fear in %their_scholar% eyes. %SPEECH_ON%We're paid to kill and survive, not to romanticize lying down in the mud! I'll have no man in this company accepting death with open arms. Save the sermons for the worms.%SPEECH_OFF%With that, you give the preacher one final look before throwing the book to the fire. The flames are grateful, and with a roar begin to consume the book greedily. A few of the men let out a cheer, some visibly relax, relieved to have the oppressive atmosphere broken. %scholar% looks devastated and hangs %their_scholar% head in silence.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Get back to sharpening your steel. Tomorrow we fight!",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				local entry = ::Legends.EventList.changeMood(_event.m.Scholar, -2.0, "Felt humiliated in front of the company");
				if (_event.m.Scholar.getMoodState() < ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					local skills = bro.getSkills();
					if (skills.hasTrait(::Legends.Trait.Optimist) && this.Math.rand(1, 100) <= 75) {
						entry = ::Legends.EventList.changeMood(bro, 1.0, "Felt reassured by captain's words");
						if (bro.getMoodState() > ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					} else if (this.Math.rand(1, 100) <= 25) {
						entry = ::Legends.EventList.changeMood(bro, 0.25, "Felt reassured by captain's words");
						if (bro.getMoodState() > ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_39.png[/img]%pessimist% sighs heavily and gets up. %SPEECH_ON%Look at that drawing \'ere! That massive farkin\' greenskin loomin\' \'ver the broken man? That's goin\' to be me! I can already feel me bones snappin\'! %They're_scholar% readin\' that book because %they_scholar% knows our luck has run out, and no amount of resolve is going to stop a heavy cleaver from separating me \'ead from me shoulders!%SPEECH_OFF%The grim reality of %pessimist%'s words settles over the men like a wet blanket, suffocating whatever comfort the book might have offered.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Always a joy to have %pessimist% around.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.Pessimist.getImagePath());

				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (this.Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, -0.75, "Felt troubled by the pessimist's outlook on dying well");
						if (bro.getMoodState() < ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_39.png[/img]%optimist% breaks into a coarse laugh, slapping %their_optimist% hand against %their_optimist% thigh. %SPEECH_ON%I don't need no guide to know that I'd rather die fighting and farking and drinking in this here company than shivering from the bloody flux in some darn hovel. Let those who wish to take us on try, I say! I'd spit in their eyes and dance on their graves before death takes me!%SPEECH_OFF%The sheer bravado of the claim breaks the tension immediately. The men chuckle, shaking their heads at the %optimist%'s defiance, and the morbid mood brought on by the text is entirely dispelled...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That's the spirit.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.Optimist.getImagePath());

				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (this.Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, 0.75, "Felt reinvigorated by the optimist's outlook on dying well");
						if (bro.getMoodState() > ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_39.png[/img]%doubletonguedbro% flashes a crooked smile and leans in close to the preacher. %SPEECH_ON%You know, %scholar%, men usually only study death when they know something is coming their way. Did you shortchange a merchant recently? Or mayhaps you are simply expecting a dagger in the back from one of us, hmm?%SPEECH_OFF%%scholar% pales instantly, their fingers fumbling as the book falls onto the ground from their trembling hands. %They_scholar% scurries to pick it up and backs up, suddenly aware that %they_scholar% is surrounded by professional killers.\n\nThe sermon ends abruptly.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Heh. That should put an end to this.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.DoubleTonguedBro.getImagePath());
				local entry = ::Legends.EventList.changeMood(_event.m.Scholar, -2.0, "Felt threatened by the company");
				if (_event.m.Scholar.getMoodState() < ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}
				::Legends.Effects.grant(_event.m.Scholar, ::Legends.Effect.Afraid, function (_effect) {
					this.List.push({
						id = 10,
						icon = _effect.getIcon(),
						text = _event.m.Scholar.getName() + " is afraid"
					});
				}.bindenv(this));
			}
		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_39.png[/img]Rather than looking away, %deathwishbro% leans closer to the tome, practically burying %their_deathwishbro% face in the grim illustrations.%SPEECH_ON%Look at the size of the beast in this drawing...\n\n...and the sheer volume of the dead tearing at that man's armor! To be torn apart by such insurmountable forces, fighting until your sword shatters and your lungs give out... now that is what I call a true death...%SPEECH_OFF%%Their_deathwishbro%'s eyes glow maddeningly. %They_deathwishbro% traces the outlines of the monstrous figures with a strange reverence. The rest of the men slowly inch away, unsettled.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Try to restrain yourself until the battle actually starts.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.DeathwishBro.getImagePath());
				local entry = ::Legends.EventList.changeMood(_event.m.DeathwishBro, 1.5, "Felt inspired by depictions of death");
				if (_event.m.DeathwishBro.getMoodState() > ::Const.MoodState.Neutral) {
					this.List.push(entry);
				}
			}
		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_39.png[/img]%cultist% gets up, not letting %their_cultist% gaze avert from the campfire, completely ignoring the book. %They_cultist% speaks up, %their_cultist% voice cutting resolutely through the crackling flames. %SPEECH_ON%Old hag's hogwash and lies — there is no 'art' to the end. The darkness comes, and Davkul takes all. Resolve nor unbroken spirit make no difference — we are simply to be swallowed.%SPEECH_OFF%A profound silence washes over the camp, the only sounds coming from the campfire and the animals. %scholar% slowly closes the book, the words within suddenly unremarkable against the grim pall of %cultist%'s words.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Enough of this macabre.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.AffectedBro.getImagePath());

				local brothers = this.World.getPlayerRoster().getAll();
				foreach (bro in brothers) {
					local bg = bro.getBackground();
					if (this.Math.rand(1, 100) <= 25) {
						if (bg.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Cultist) || bg.getID() == ::Legends.Backgrounds.getID(::Legends.Background.ConvertedCultist))	{
							local entry = ::Legends.EventList.changeMood(bro, 0.5, "Felt good about being in the flock");
							if (bro.getMoodState() > ::Const.MoodState.Neutral) {
								this.List.push(entry);
							}
						} else {
							local entry = ::Legends.EventList.changeMood(bro, -0.5, "Felt uneasy about the talk of death");
							if (bro.getMoodState() < ::Const.MoodState.Neutral) {
								this.List.push(entry);
							}
						}
					}
				}
			}
		});
	}

	function onUpdateScore() {
		this.m.Score = 0;
		local brothers = this.World.getPlayerRoster().getAll();
        local candidates_scholar = [];

        foreach( bro in brothers ) {
			local bg = bro.getBackground();
            if (bg.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Monk) || bg.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Historian) || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar)) {
                candidates_scholar.push(bro);
            }
        }

        if (candidates_scholar.len() == 0) {
            return;
        }
		this.m.Scholar = candidates_scholar[this.Math.rand(0, candidates_scholar.len() - 1)];

		local candidates_cultist = [];
		local candidates_deathwish = [];
		local candidates_doubletongued = [];
		local candidates_optimist = [];
		local candidates_pessimist = [];

        foreach( bro in brothers ) {
            if (bro.getID() == this.m.Scholar.getID()) {
                continue;
            }

            local skills = bro.getSkills();
            local bg = bro.getBackground();

            if (skills.hasTrait(::Legends.Trait.Pessimist)) {
				candidates_pessimist.push(bro);
			} else if (skills.hasTrait(::Legends.Trait.Optimist)) {
				candidates_optimist.push(bro);
			} else if (skills.hasTrait(::Legends.Trait.LegendDoubleTongued)) {
				candidates_doubletongued.push(bro);
			} else if (skills.hasTrait(::Legends.Trait.Deathwish)) {
				candidates_deathwish.push(bro);
			} else if (bg.getID() == ::Legends.Backgrounds.getID(::Legends.Background.Cultist) || bg.getID() == ::Legends.Backgrounds.getID(::Legends.Background.ConvertedCultist)) {
				candidates_cultist.push(bro);
			}
        }

		this.m.Score = 10;

        if (candidates_cultist.len() > 0) {
            this.m.Cultist = candidates_cultist[this.Math.rand(0, candidates_cultist.len() - 1)];
			this.m.Score += 2;
        }
		if (candidates_deathwish.len() > 0) {
            this.m.DeathwishBro = candidates_deathwish[this.Math.rand(0, candidates_deathwish.len() - 1)];
			this.m.Score += 2;
        }
		if (candidates_doubletongued.len() > 0) {
            this.m.DoubleTonguedBro = candidates_doubletongued[this.Math.rand(0, candidates_doubletongued.len() - 1)];
			this.m.Score += 2;
        }
		if (candidates_optimist.len() > 0) {
            this.m.Optimist = candidates_optimist[this.Math.rand(0, candidates_optimist.len() - 1)];
			this.m.Score += 2;
        }
		if (candidates_pessimist.len() > 0) {
            this.m.Pessimist = candidates_pessimist[this.Math.rand(0, candidates_pessimist.len() - 1)];
			this.m.Score += 2;
        }
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
            "scholar",
            this.m.Scholar.getName()
        ]);
        _vars.push([
            "cultist",
            this.m.Cultist != null ? this.m.Cultist.getName() : ""
        ]);
		_vars.push([
            "deathwishbro",
            this.m.DeathwishBro != null ? this.m.DeathwishBro.getName() : ""
        ]);
		_vars.push([
            "doubletonguedbro",
            this.m.DoubleTonguedBro != null ? this.m.DoubleTonguedBro.getName() : ""
        ]);
		_vars.push([
            "optimist",
            this.m.Optimist != null ? this.m.Optimist.getName() : ""
        ]);
		_vars.push([
            "pessimist",
            this.m.Pessimist != null ? this.m.Pessimist.getName() : ""
        ]);
	}

	function onClear() {
		this.m.Cultist = null;
		this.m.DeathwishBro = null;
		this.m.DoubleTonguedBro = null;
		this.m.Optimist = null;
		this.m.Pessimist = null;
		this.m.Scholar = null;
	}
});
