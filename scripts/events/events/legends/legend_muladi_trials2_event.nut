this.legend_muladi_trials2_event <- this.inherit("scripts/events/event", {
	m = {
		Muladi = null
	},
	function create() {
		this.m.ID = "event.legends.muladi.trials2";
		this.m.Title = "On the outskirts of %settlement%...";
		this.m.Cooldown = 15.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_141.png[/img]{Walking the sodden fields of %settlement%, you spy a number of your men up ahead running towards something. Following them round the back of a barn, you\'re met with a cluster of mercenaries, farmhands, and in the middle in a heap on the floor, %muladi% the muladi. You can feel the tension as the company quickly backs up the muladi, barking threats and demands, though the peasants offer firm verbal resistance. You push through to see a swelling puddle of blood and %muladi% curled into a fetal ball, holding their hands to their body. Across, peasants brace with farming tools as makeshift weapons of war, striking a most embarrassing defensive formation against the presence of your men. %SPEECH_ON%They farkin\' jumped %them_mualdi%, captain! Ran \'em through with a pitchfork for nothing!%SPEECH_OFF%One of the peasants produces said pitchfork, blood dripping from one of its rusted metal points. They brandish it against you and the others, declaring they\'ll run you through as well if you interfere.%SPEECH_ON%This freak has humiliated us, us good normal folk! They\'ve been living as one of them southern nomad bastards, the same ones who steal our cattle, our food, our children! Now they think they can slink back here and pretend they\'re like us and not some thieving brigand!%SPEECH_OFF%Their fervour and certainty in your brother\'s perceived crime is only tempered when you draw your sword and posture up against this peasant, who by now is shaking and looking to their peers for support. While you know little of your muladi\'s past, the fact stands that a mob of rabble just tried to murder them in an ambush. You have no doubt your company would make a short and brutal example of the now shaking assailants, but such a massacre would certainly harm any goodwill with the locals. Glancing back, you see %muladi% clutching their wound and groaning, as well as the rage in the company\'s eyes for such a slight. The men crave that one command that would sate their anger and promise them justice. With a sigh, you order the company...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Kill them all!",
				getResult = @(_event) "1"
			}, {
				Text = "{Blast it! Grab %muladi% and let\'s go!}",
				getResult = @(_event) "2"
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());

				_event.m.Muladi.getFlags().set("MuladiTrials2", ::World.getTime().Days + 15);
			}
		});

		this.m.Screens.push({
			ID = "1",
			Title = "After the massacre...",
			Text = "[img]gfx/ui/events/event_22.png[/img]{The words had hardly left your mouth before the men descend upon the murderous rabble like waves on rocks. Desperate screams of terror are met with ferocious roars of vengeance and bloodlust as the company gores the peasants before you. One peasant lets out a shrill screech, cut short as their head is swiftly liberated of its body. Another turns to run, but is planted into the very earth they worked with a hideous crunch, as though an unhold had fell onto a stack of bramble. The pitchfork wielding peasant is soundly disembowelled with their own implement as the rest of the company wraps up their bloody work. In only seconds, this mass of men had been turned into a scene of carnage and brutality signed by your company. Whether justified or not, the people of %settlement% will no doubt remember this.\nTurning your attention to your skewered muladi, you order some of the company to check their wounds and patch %them_muladi% up. While certainly gruesome, the pitchfork thankfully wasn\'t lethal, and %muladi% quickly has their wound plugged and bandaged by some of the more healing-inclined men. The contrast between the delicate care taken for your injured man and the barbarous scene around them stirs something within you, and you crouch to speak to the now responsive muladi. They shake their head and glance around as you ask how they\'re feeling.%SPEECH_ON%Like shit, to be honest, captain. I\'ve known some of those farmers for years, before my travels. Played horseshoes with some, drank with others. Some of them were right bastards, but I never thought they\'d do this.%SPEECH_OFF%%They_muladi% gesture to their wound and rise to their feet with your help and a few other brothers to support them. Standing over some of the freshly made bodies, they frown and wipe something from their face before continuing.%SPEECH_ON%They poked fun at first. My trips to the south were a fun topic of ribbing, of me \'sampling the flavours\' of those lands. Nevermind the struggles, the beatings I suffered, the people I hurt. They just saw what they wanted to see of me, whatever made them feel better about their lives wasted toiling on the same soil year by year. Later it turned to suspicion of the new clothes I wore, the accent I picked up, the trinkets I brought back. I suppose this was their breaking point- and mine.%SPEECH_OFF%They survey the peasant with the pitchfork embedded in their stomach, spit on them, then turn back to the company. A bolt of pain sends them doubling over, another punishment from %their_muladi% now dead attacker. Your men support %them_muladi% as they begin their walk back to camp, bloodied and sapped of spirit. Looking back to the corpses, %muladi% sounds off their last defiance to those who estranged %them_muladi% for who they dared to be.%SPEECH_ON%Rot, you bastards.%SPEECH_OFF%}",
			Options = [{
				Text = "Life can be a fickle thing.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());

				this.List.extend([
					::Legends.EventList.changeResolve(_event.m.Muladi, -4),
					::Legends.EventList.changeHitpoints(_event.m.Muladi, ::Math.rand(-8, -4)),
					::Legends.EventList.addHeavyInjury(_event.m.Muladi),
					::Legends.EventList.addInjury(_event.m.Muladi, ::Const.Injury.PiercingBody),
					::Legends.EventList.changeMood(_event.m.Muladi, -2.0, "Was almost killed by my countrymen!"),
				]);

				foreach (bro in ::World.getPlayerRoster().getAll().filter(@(_idx, _bro) _bro.getEthnicity() != 1)) {
					if (bro.getID() == _event.m.Muladi.getID())
						continue;

					if (::Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, 0.5, "Dished out vengeance against violent peasants");
						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							this.List.push(entry);
					}
				}
				::Legends.S.getClosestSettlement().addPlayerRelation(::Const.World.Assets.RelationMinorOffense, "You killed the peasants");
			}
		});

		this.m.Screens.push({
			ID = "2",
			Title = "Back at camp...",
			Text = "[img]gfx/ui/events/event_05.png[/img]{Your command to leave the attackers alive earns audible grumbles from the company, and cocky jeers from the peasants. While some of the rabble make weak attempts to stop you from lifting the muladi, a firm push and whipping of weapons sends the meekest scattering. With your injured man groaning under the stress of being moved, you could almost block out the mocking shouts from behind as you spill back into camp and help %muladi% crash into the medical tent. Some of the men wear pained expressions, others concern for the skewered muladi as they begin to inspect and dress the wound. One mercenary pipes up.%SPEECH_ON%Shoulda killed those farks, captain. Little bastards wouldn\'t be missed, I can tell you that.%SPEECH_OFF%Maybe, but you couldn\'t risk the wrath of %settlement% by slaughtering a pack of their labourers, no matter how venomous they were. You tell the men as much, but the primal urge to avenge their injured brother blocks your reasoning, and many men leave in a dissatisfied huff. One of the impromptu healers declares the wound is grave, but not life threatening, earning relieved sighs and pained smiles from those who remained in the tent. As the muladi begins to come around, you give them a knowing nod and sit beside them, reminding you of your previous encounter in the southern city. The parallel isn\'t lost on %muladi% either, who faintly begins to speak.%SPEECH_ON%We should stop hanging out like this, captain.%SPEECH_OFF%Aye, probably. You tell them how you let the rabble live, and then ask them what the hells happened.%SPEECH_ON%I knew a bunch of those lads from before my travels south. Worked together for a while- thatched roofs, field work in busy seasons, that sort of thing. They were alright enough, but short tempered, some. Always angry at something, or someone, whatever they couldn\'t get or do or be. When I began my journeys to the southern cities, it became a topic of friendly jabbing. \'The local wenches weren\'t good enough\', or \'%they_muladi%\'s got a taste for that southern swill they call booze\'. Later, as I began to see more success in the sands than I did the fields, their amusement turned bitter: suddenly I hated northern food, northern people, northern life. I had become like one of those southern lords looking down on the rest, all despite the fact I was hated by almost all I met and hardly had food to fill my belly, never mind a crown upon my head. This time they took issue with our company, said I was working as one of their \'pet nomads\' and that I\'d finally embraced the savage I\'d been courting in the south for so long. I didn\'t even see what got me, I just felt the shooting pain and fell.%SPEECH_OFF%You offer your skin of drink, but they decline, saying they need to feel this one for a while, and that those pricks have given %them_muladi% something to think on. You think you understand and nod, rising to check on the others and make sure they hadn\'t set fire to the peasant\'s fields - or the peasants themselves. Glancing back, you see the now pensive muladi exploring the wound on their body with their fingertips, perhaps imagining the scars it would produce in time. %SPEECH_ON%A shame as well captain, I was having a nice day before all this mess.%SPEECH_OFF%}",
			Options = [{
				Text = "There will be nicer days to come."
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());

				this.List.extend([
					::Legends.EventList.changeResolve(_event.m.Muladi, -4),
					::Legends.EventList.changeHitpoints(_event.m.Muladi, ::Math.rand(-8, -4)),
					::Legends.EventList.addHeavyInjury(_event.m.Muladi),
					::Legends.EventList.addInjury(_event.m.Muladi, ::Const.Injury.PiercingBody),
					::Legends.EventList.changeMood(_event.m.Muladi, -2.0, "Was almost killed by my countrymen!"),
				]);

				foreach (bro in ::World.getPlayerRoster().getAll().filter(@(_idx, _bro) _bro.getEthnicity() != 1)) {
					if (bro.getID() == _event.m.Muladi.getID())
						continue;

					if (::Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, -1.0, "Denied vengeance against violent peasants");
						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							this.List.push(entry);
					}
				}

			}
		});
	}

	function onUpdateScore() {
		local candidatesMuladi = ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getBackground().getID() == "background.legend_muladi" && !_bro.getFlags().has("MuladiTrials2"));
		if (!candidatesMuladi.len())
			return;

		local currentTile = ::World.State.getPlayer().getTile();
		local nearbyTowns = ::World.EntityManager.getSettlements().filter(@(_, _town) _town.getTile().getDistanceTo(currentTile) <= 4 && !_town.isSouthern());
		if (!nearbyTowns.len())
			return;

		foreach (bro in candidatesMuladi) {
			if (bro.getFlags().getAsInt("MuladiTrials") < ::World.getTime().Days)
				return; // too early for it to happen
		}

		this.m.Muladi = candidatesMuladi[::Math.rand(0, candidatesMuladi.len() - 1)];
		this.m.Score = 50;
	}

	function onPrepareVariables(_vars) {
		_vars.push(["muladi", this.m.Muladi.getNameOnly()]);
	}

	function onClear() {
		this.m.Muladi = null;
	}
});
