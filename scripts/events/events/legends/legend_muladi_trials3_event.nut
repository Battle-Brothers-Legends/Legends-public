this.legend_muladi_trials3_event <- this.inherit("scripts/events/event", {
	m = {
		Muladi = null
	},
	function create() {
		this.m.ID = "event.legends.muladi.trials3";
		this.m.Title = "At Camp...";
		this.m.Cooldown = 15.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "Start",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You\'re consulting your ledgers in your tent when %muladi% strides in. They\'re looking much better since their myriad injuries from southern bandits and northern peasants alike, and you invite them to sit across from you. Closing your books and meeting the muladi\'s gaze, you see the distress and uncertainty in %their_muladi% expression; they look both deep in thought and completely listless, like a scribe doing battle with their own mind. You ask them what\'s going on, and for a moment energy returns to their eyes.%SPEECH_ON%Captain. I\'ve been thinking a lot lately. About me, my place in the company. About who I am- what I am.%SPEECH_OFF%You can\'t hide your concern as the mercenary-muladi across fidgets and searches their mind for answers they know aren\'t there. %SPEECH_ON%The truth is, I don\'t really know anymore. Before I became what the southerners call \'muladi\', I felt empty, directionless. Like a ship without sails, just swaying to the winds of whatever came its way. In wandering the south of the world, I thought I would discover that purpose, but only found prejudice, anger, fear, and more questions. Whether ploughing fields or hunting hyenas, everything I did felt like an imitation of what I should be doing, of who I should be. Wandering felt like I would make my own path, but I just felt more lost, caught in a storm of confusion where I never felt myself, never felt at home. Then I saw your company recruiting and thought maybe I could get enough crowns to buy my place somewhere, to purchase my own mind back from doubt and unknowing: to figure out who I was.%SPEECH_OFF%You worry perhaps they have and are here to announce their departure from the %company%, but they continue before you can dwell on such concerns.%SPEECH_ON%But I found something else whilst here. I found people who don\'t mock my past, who don\'t fear me for what I am. With the others, I don\'t fear that my life between two worlds dooms me to live amongst neither, because here we are, fighting and living and bleeding in a world of our own making. The longer I spend here, the more I see of the pain in the lands I traverse, the more I feel at peace with my own being, as though my existence isn\'t some aberration or mockery of the life I could or should be leading. And yet, whilst it makes me feel more secure in who I am, it makes me wonder if my life was never amongst the sands or in the settlements of the north, but here, amongst friends who I would fight and die for, and who in turn would fight and die for me. I\'m not sure, captain. To be muladi or mercenary or both, I feel certain my place is here amongst the company, but I don\'t know what that makes me anymore. Does that make sense?%SPEECH_OFF%The place of any man within the world is a scary thing to grapple with, and you understand %them_muladi% all too well. You consider their growth in your band of mercenaries, their skills honed both in battle and across their travels. Thoughtfully, you respond...}",
			Title = "At Camp..."
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Your life is no farce - seize your muladi identity, wear it as armour!",
				getResult = @(_event) "1"
			}, {
				Text = "The company can be your home, if you want it to be",
				getResult = @(_event) "2"
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());
				_event.m.Muladi.getFlags().set("MuladiTrials3", true);
			}
		});
		this.m.Screens.push({
			ID = "1"
			Title = "An Identity Affirmed"
			Text = "[img]gfx/ui/events/event_170.png[/img]{You tell the muladi about how they sound like they have in fact discovered themself amongst your company, and that they know their worth as muladi is no less than yours as captain, or any of the men in the company. You tell them to use the labels the world puts upon them as their armour- to wield their reputation as a %person_muladi% between worlds as a mighty weapon. A brief period of silence follows, quickly broken as %muladi% rises, steeled in themself and their purpose. %SPEECH_ON%Alright then. I will. Thank you, captain.%SPEECH_OFF%You fear you had offended the normally talkative %person%, but a sly smile and confident stride out of your tent tell you your words struck true. In the coming days, the muladi would lean back into the teachings and skills that helped them thrive amongst the deserts and plains of the south, reforged in their outlook and self-value. At the moment though, you merely return to your ledgers, reflecting on the conversation, and cursing that you forgot what page you were using.}",
			Options = [{
				Text = "To know oneself is the most important thing in this world.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());

				_event.m.Muladi.getBackground().m.RawDescription += this.buildText("\nHaving struggled and bled for their life between two worlds, %muladi% has reaffirmed who they are, spitting in the faces of those who would decry and denounce %them_muladi%. Assured in the path they walk, this muladi promises a most fierce retribution that fuses the calculated cunning of the south, and raw strength of the north.");

				local entry = ::Legends.EventList.changeMood(_event.m.Muladi, 3.0, "Despite everything, It\'s still me.");
				if (_event.m.Muladi.getMoodState() >= this.Const.MoodState.Neutral)
					this.List.push(entry);

				local bonusStats = 0;
				if (::Legends.Traits.has(_event.m.Muladi, ::Legends.Trait.LegendSlack)) {
					::Legends.Traits.remove(_event.m.Muladi, ::Legends.Trait.LegendSlack);
				} else if (::Legends.Traits.has(_event.m.Muladi, ::Legends.Trait.LegendAmbitious)) {
					bonusStats += 2;
				} else {
					::Legends.Traits.grant(_event.m.Muladi, ::Legends.Trait.LegendAmbitious);
				}

				this.List.extend([
					::Legends.EventList.changeHitpoints(_event.m.Muladi, 22),
					::Legends.EventList.changeResolve(_event.m.Muladi, 14 + bonusStats),
					::Legends.EventList.changeInitiative(_event.m.Muladi, 8 + bonusStats),
					::Legends.EventList.changeMeleeSkill(_event.m.Muladi, 2),
					::Legends.EventList.changeRangedSkill(_event.m.Muladi, 2)
				]);
			}
		});
		this.m.Screens.push({
			ID = "2"
			Title = "A %Person_muladi% Remade"
			Text = "[img]gfx/ui/events/event_134.png[/img]{You recount the problems the muladi has experienced just in your company: the beatings from southerners, the stabbings from northerners, the suspicion they attract simply for who they are. You remark how the company could be the home they\'re seeking- the purpose they crave. To fight amongst their brothers could be their calling, if they wanted it. A moment passes, and %muladi% speaks with a confident nod.%SPEECH_ON%Aye. I think that is what I want! This life has given me nothing but spite for too long, now I have the company, I feel things can be better.%SPEECH_OFF%They rise and give you a confident smile, then leaves without another word. You know the mercenary has found a good place here amongst the others, and are certain they will fight to give the company all they\'ve got going forward. In the coming days, the mercenary would shed their muladi habits in favour of regular sparring and training with the others, laughing and learning with the rest of the men as a new %person_muladi%. At the moment though, you merely return to your ledgers, reflecting on the conversation, and cursing that you forgot what page you were using.}",
			Options = [{
				Text = "%Company% stands a little stronger with %muladi% in the ranks",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());

				local bg = this.new("scripts/skills/backgrounds/legend_companion_ranged_background");
				bg.m.IsNew = false;
				local oldPerkTree = _event.m.Muladi.getBackground().m.CustomPerkTree;
				_event.m.Muladi.getSkills().removeByID("background.legend_muladi");
				_event.m.Muladi.getSkills().add(bg);
				_event.m.Muladi.getBackground().m.RawDescription = "Having suffered at the hands of the fearful and ignorant for too long, %name% has left their life as a wayfaring muladi behind, instead fully dedicating their spirit to the company and its continued success. No longer just an extra warm body to fill the ranks, this bro considers the company family, and will use their skills - both new and old - to protect it, or die trying.";
				_event.m.Muladi.getBackground().buildDescription(true);
				_event.m.Muladi.getBackground().rebuildPerkTree(oldPerkTree);
				_event.m.Muladi.resetPerks();

				local entry = ::Legends.EventList.changeMood(_event.m.Muladi, 3.0, "Excited to carve out a new life with the company!");
				if (_event.m.Muladi.getMoodState() >= this.Const.MoodState.Neutral)
					this.List.push(entry);

				local bonusStats = 0;
				if (::Legends.Traits.has(_event.m.Muladi, ::Legends.Trait.LegendSlack)) {
					::Legends.Traits.remove(_event.m.Muladi, ::Legends.Trait.LegendSlack);
				} else if (::Legends.Traits.has(_event.m.Muladi, ::Legends.Trait.LegendAmbitious)) {
					bonusStats += 2;
				} else {
					::Legends.Traits.grant(_event.m.Muladi, ::Legends.Trait.LegendAmbitious);
				}

				this.List.extend([
					::Legends.EventList.changeHitpoints(_event.m.Muladi, 6),
					::Legends.EventList.changeResolve(_event.m.Muladi, 3 + bonusStats),
					::Legends.EventList.changeFatigue(_event.m.Muladi, 8),
					::Legends.EventList.changeInitiative(_event.m.Muladi, 6 + bonusStats),
					::Legends.EventList.changeMeleeSkill(_event.m.Muladi, 6),
					::Legends.EventList.changeRangedSkill(_event.m.Muladi, 6),
					::Legends.EventList.changeMeleeDefense(_event.m.Muladi, 6),
					::Legends.EventList.changeRangedDefense(_event.m.Muladi, 6),
				]);
			}
		});
	}

	function onUpdateScore() {
		local candidatesMuladi = ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getBackground().getID() == "background.legend_muladi" && !_bro.getFlags().has("MuladiTrials3"));
		if (!candidatesMuladi.len())
			return;

		local currentTile = ::World.State.getPlayer().getTile();
		local nearbyTowns = ::World.EntityManager.getSettlements().filter(@(_, _town) _town.getTile().getDistanceTo(currentTile) <= 8);
		if (nearbyTowns.len())
			return;

		foreach (bro in candidatesMuladi) {
			if (bro.getFlags().getAsInt("MuladiTrials2") < ::World.getTime().Days)
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
