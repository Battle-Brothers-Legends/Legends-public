this.legend_ardent_admirer_event <- this.inherit("scripts/events/event", {
	m = {
		Fan = null,
		Gunner = null
	},
	function create() {
		this.m.ID = "event.legend_ardent_admirer";
		this.m.Title = "On the Road...";
		this.m.Cooldown = 9999 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_12.png[/img]Almost out of nowhere, a peculiar looking figure catches your eye. Clearly, you caught his too, because he smiles like he knows you and eagerly approaches, though if he did he would surely reconsider. Reflexively palming your sword with one hand and halting them with another, you call out and ask what on earth they want.%SPEECH_ON%It\'s - it\'s you! It really IS you! I thought it was, but now I\'m here I can see you up close in all your glory!%SPEECH_OFF%His voice immediately forces an involuntary wince: it harbours an enthusiasm only seen in naive children and the hopelessly lovestruck, though he doesn\'t seem to be either. He\'s practically slack-jawed as he admires %randombrother%, all but worshipping the very ground %they_randombrother% occupies. You ask him who exactly \'we\' are, to which he jolts forward with a burst of sickening glee.%SPEECH_ON%Well, you\'re... I don\'t know your name, actually. That\'s %randombrother% the mighty, over there is %randombrother2% the invincible! But you\'re the captain of the %companyname%, only the most heroic and noble warriors in all the lands, and now you\'re here, standing before me!%SPEECH_OFF%Right. While you wouldn\'t phrase it quite so poetically, the fool is correct about who you are. A number of the men are visibly upset by their presence, his whiny voice and unnaturally upbeat tone clearly triggering some primal unease, like looking at a corpse or someone very, very ill. Mercilessly, his grating voice begins again, this time enchanted with some gross mix of admiration and pleading. He remarks how he could clean and carry some of your equipment, but quickly abandons the prospect when seeing the lethal scowls of the company.%SPEECH_ON%I know! I can spread the word of your glorious deeds to the people of the world! People need to hear of the %companyname%\'s brilliant exploits. Your name will live on through the ages when I regale people of your achievements!%SPEECH_OFF%A useful idiot is still useful, and you could let them go to spread the word of your \'glorious deeds\'. That said, some of the company already resemble hungry wolves, seemingly pushed by the fool\'s hideous voice and energy to a violent boil.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Yes, spread the word of our prowess. Far away from here.",
				getResult = @(_event) "B"
			}, {
				Text = "Can someone kill this fool already?",
				getResult = @(_event) "C"
			}],
			function start(_event) {
				local roster = ::World.getTemporaryRoster();
				_event.m.Fan = roster.create(::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legend_risen_legion") ?
					"scripts/entity/tactical/employer/legend_legion_adoring_fan":
					"scripts/entity/tactical/employer/legend_adoring_fan"
				);
				_event.m.Fan.assignRandomEquipment();
				this.Characters.push(_event.m.Fan.getImagePath());

				if (_event.m.Gunner != null) {
					this.Options.push({
						Text = "Our handgonner seems itching to introduce themself...",
						getResult = @(_event) "D"
					})
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_64.png[/img]Your eagerness to shoo away this gnat of a man is met with groans by the company, quickly drowned out by an eager gasp from the starstruck fool. He moves to shake your hand, and it takes all your willpower to resist breaking the outstretched fingers like so much bramble. Catching the hint, he recoils his hand and punishes your mercy with more of his grating voice.%SPEECH_ON%Very well! I will travel, far and wide across all these lands to share the story of your troop and your legendary exploits. Soon, the whole world will call your name, uhhh... captain. Safe travels, my champion!%SPEECH_OFF%With that, he turns and runs away to only gods know where. His peculiar gait and frankly absurd appearance marks him out as almost otherworldly, though you try not to dwell on it as you strive to put him out of your mind. It\'s only a matter of time before they end up with a knife between the ribs, or so you hope. Turning to the company, it\'s apparent many of the men wished it to be their knives repeatedly slotted between his ribs, but that opportunity quickly disappears with the strange man. %randombrother% rubs their forehead and thanks seemingly every god there is that they\'re gone. Blinking away the absurdity of the past few minutes, you order the men back on the road.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "I\'ve always wanted a fan club.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Fan.getImagePath());
				this.List.push(::Legends.EventList.changeRenown(50));
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (::Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, -0.5, "Had to suffer the blabbering of a starstruck fool");
						if (bro.getMoodState() <= this.Const.MoodState.Neutral) this.List.push(entry);
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_46.png[/img]%SPEECH_ON%Very well! I will- wait, wha-%SPEECH_OFF%Mercifully, the fool\'s theatrical monologue is cut short with a swift jab from %randombrother% which launches him to the ground in a frankly absurd movement. Unfortunately, the strange man\'s rehearsed speech is replaced with twisted yelps and wails of pain which only invite more abuse from some of the company, who has fallen in around the crumpled mess of a man to offer him kicks and punches. One of the men loudly groans \'fark this\', and pulls a knife, looking to finish the job. A few deliberately messy stabs later, and the fool lays dead, their limbs splayed in almost every direction as their body takes on a bizarre form. Beside them, a pool of oozing crimson grows, and a few of the company sign their handiwork with a few hocks of spit and markedly unkind remarks, after relieving him of his belongings of course. %randombrother% rubs %their_randombrother% pate and says to no one in particular.%SPEECH_ON%Gods, man. Even killing him was irritating, it almost wasn\'t worth it. Almost.%SPEECH_OFF%Almost indeed. While some of the men are simply relieved to be rid of such a blight on their ears, you catch a few with mean smirks, glancing back to the fresh body of their making. Either way, with the company\'s bloodlust satisfied and a pestering fool dispatched, you order the men back on to the road, content to let the vultures and wildlife clean up your mess.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Never meet your heroes, I guess...",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Fan.getImagePath());
				this.List.extend(::Legends.EventList.addItems([
					::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legend_risen_legion") ?
						::Const.World.Common.pickArmor([[1, ::Legends.Armor.Ancient.ancient_breastplate]]):
						::new("scripts/items/legend_armor/cloth/legend_tunic"),
					::new("scripts/items/weapons/dagger")
				], ::World.Assets.getStash()));
				this.List.push(::Legends.EventList.changeMoney(69));
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (::Math.rand(1, 100) <= 50) {
						local entry = ::Legends.EventList.changeMood(bro, 1.0, "Satisfied to see an annoying fool gutted");
						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							this.List.push(entry);
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_24.png[/img]%handgonner% the company gunner steps up, handgonne in tow. %They_handgonner%\'s sizing up the irritating little man before %them_handgonner%, perhaps questioning how someone so offensively annoying has managed to survive to such an age, or perhaps just daydreaming about what their handgonne would do to them. With a menacing tone, %they_handgonner% ask the pest.%SPEECH_ON%Have you ever wanted to fly, little man?%SPEECH_OFF%Just as the fool primed to assault your ears again with his answer, your gunner quickly swings his handgonne into firing position, primes, and... Oh fuck.  You wince as the thunder of the gun assaults your every sense- your ears ring, your eyes pulse, your bones rattle as though the earth itself was splitting beneath you. Between scrunched up eyes, you can just make out the vague image of the fool as they shatter and rip apart, the force of the hand cannon proving too much for their feeble form. Flesh and hair is shredded and made to resemble autumn leaves as they are ejected from the mass of what was once human. An eye and ear and arm succumb to the torrent of shrapnel and blasting powder, seemingly racing to escape the onslaught before them as they\'re launched in almost every direction. Nearby, leaves rustle as birds make flight at the sudden disturbance to their rest.\nThe handgonner has hardly moved from their firing stance, the primal thunder of their tool of war revealing itself a familiar sensation to %them_handgonner%. Instead, %they_handgonner% surveys %their_handgonner% handiwork, mapping the viscera that soaks the once-tranquil scene around them: limbs and chunks of bone are sprinkled in a cone from the gunner, sizzling flesh and boiling blood carpet the ground, a testament to the destructive power of their terrible weapon. What remains of the fool is a caricature of gore and barbarity, though between the shock, you can\'t help but feel a tad amused at the excessive display of cruel obliteration. Clearly, the handgonner agrees.%SPEECH_ON%Well, I\'d say he flew pretty well, captain! It certainly beats his endless prattling, eh?%SPEECH_OFF%You suppose it does, as does much of the company as they whoop and clap at the gunner\'s impromptu execution of someone who\'s ultimate crime was being an annoying prat in the wrong place. A couple of the company approach a tree in the wake of the blast, claiming to spy brain matter and skull fragments amongst the branches, others make poor attempts at hiding their amusement by covering their smirks. Ultimately, you order the men back on the road, as you surely wouldn\'t want to be here to explain this... mess to any other passers by.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "They had it coming... I think.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Fan.getImagePath());
				this.Characters.push(_event.m.Gunner.getImagePath());

				this.List.push(::Legends.EventList.changeMood(_event.m.Gunner, 2.0, "Introduced an annoying whelp to my boomstick"));
				this.List.push(::Legends.EventList.changeBroExperience(_event.m.Gunner, 100));

				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (_event.m.Gunner.getID() == bro.getID())
						continue;
					if (::Math.rand(1, 100) <= 75) {
						local entry = ::Legends.EventList.changeMood(bro, 1.0, "Witnessed an annoying fool get blown up");
						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
							this.List.push(entry);
					}
				}
			}
		});
	}

	function onUpdateScore() {
		if (!::World.getTime().IsDaytime)
			return;

		if (::World.Assets.getBusinessReputation() < 2250)
			return;

		if (::World.getPlayerRoster().getAll().len() < 3)
			return;

		local playerTile = ::World.State.getPlayer().getTile();
		local settlement = ::Legends.S.getClosestSettlement();

		if (!(playerTile.HasRoad || settlement.getTile().getDistanceTo(playerTile) <= 3))
			return;

		local candidates_gunner = ::World.getPlayerRoster().getAll().filter(@(_idx, _bro) _bro.getMainhandItem() != null && ::Legends.S.oneOf(_bro.getMainhandItem(), "weapon.handgonne", "weapon.named_handgonne"));
		if (candidates_gunner.len() > 0) {
			this.m.Gunner = candidates_gunner[::Math.rand(0, candidates_gunner.len() - 1)];
		}

		this.m.Score = 9999;
	}

	function onPrepareVariables( _vars )
	{
		if (this.m.Gunner != null) {
			_vars.push(["handgonner", this.m.Gunner.getName()]);
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Gunner.getGender(), "handgonner");
		}
	}


	function onClear() {
		this.m.Fan = null;
		this.m.Gunner = null;
		::World.getTemporaryRoster().clear();
	}

});
