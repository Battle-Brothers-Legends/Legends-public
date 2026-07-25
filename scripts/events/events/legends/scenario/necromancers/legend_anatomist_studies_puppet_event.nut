this.legend_anatomist_studies_puppet_event <- this.inherit("scripts/events/event", {
	m = {
		Puppet = null,
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.legend_anatomist_studies_puppet";
		this.m.Title = "Too Curious...";
		this.m.Cooldown = 48.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //— \
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]As you check in on your supplies, you overhear a commotion — someone is arguing loudly but receiving no response. Fearing the worst, you hurry to investigating and find %anatomist% and %puppet% in a one-sided standoff. The anatomist is circling the thrall with great interest, making notes within notes to a small stained ledger. %puppet% seems completely unamused, lolling their jaw and only briefly tracking their observer when they move slightly too fast and come across more as prey.%SPEECH_ON%Can you PLEASE just stay still? If only for a moment!?%SPEECH_OFF%They frustratingly turn and circle counter-clockwise, stopping to see you.%SPEECH_ON%I have never been able to get this close to something like this before! At least not... well...%SPEECH_OFF% You get the strong impression a request is about to follow.%SPEECH_ON%I just need to do a little examination. Just something very small to prove something of mine.%SPEECH_OFF%They subsequently trail off. Another thought has crossed their mind. Their eyes light up as %puppet% tracks a bird.%SPEECH_ON%You could let me... you know... 'examine' it further. It won\'t survive of course — but it is already dead, no?%SPEECH_OFF% ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You can look, but best not touch.", //study and get a little xp for anatomist
					function getResult( _event )
					{
						return "B";
					}
				},
				{
					Text = "I'm not sacrificing a thrall. Go ahead and touch but don\'t blame me if you get hurt.", //more xp but could lose a finger
					function getResult( _event )
					{
						return ::Math.rand(1, 100) <= 45 ? "C" : "D";
					}
				},
				{
					Text = "Do whatever you want with it. Kill it — take it apart.", //dissect thrall, large xp for everyone but thrall bro dies
					function getResult( _event )
					{
						return "E";
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Puppet.getImagePath());
			}

		});
		this.m.Screens.push({ //— \
			ID = "B", //study and get a little xp for anatomist
			Text = "[img]gfx/ui/events/event_63.png[/img]Dejected, %anatomist% brings to bear a second, larger, heavier book. Pulling up a chair, they make great pains in sketching out the form of %puppet%, including noting down pre and post damage to their condition. The frenzied scribbling lasts an hour and %anatomist% never gets within a few feet of %puppet%. They end their frenzied state with numerous angry question marks over some of their larger notes. %SPEECH_ON%That\'ll have to do.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Curiosity sated.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.Characters.push(_event.m.Anatomist.getImagePath());

				local entry = ::Legends.EventList.changeMood(_event.m.Anatomist, 0.5, "Studied a living cadaver")
				local brothers = this.World.getPlayerRoster().getAll();
				local xp = this.Math.rand(30, 200)
				foreach( bro in brothers )
				{
					_event.m.Anatomist.addXP(xp);
					_event.m.Anatomist.updateLevel();
					this.List.push({
						id = 16,
						icon = "ui/icons/xp_received.png",
						text = Anatomist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]"+ xp +"[/color] Experience"
					});
				}
			}

		});
		this.m.Screens.push({ //— \
			ID = "C", //more xp but lose a finger
			Text = "[img]gfx/ui/events/event_19.png[/img]%anatomist% begins at once — clearly well prepared for this situation. They begin with poking and prodding %puppet% with a cane. Methodically testing the reaction times and effects of the stick on the cadaver. Nothing much happens as the corpse simply daydreams the punishment away. \n\nA new tool comes out, this one with a pronounced point. The anatomist stabs into the shoulder of %puppet%, provoking a mild response but nothing more. Suddenly, something catches their eye between changing tools. Something you didn\'t notice. They move towards %puppet% and cast an eye down their lolling jaw. %SPEECH_ON%I think... I think I see something!%SPEECH_OFF% Before you can intercede, %anatomist% sticks a finger down the throat of %puppet%. Suddenly there is screaming. Blood — with a slow, gentle crunching sound from %puppet%.\n%anatomist% quickly bandages their finger and douses it with a foul smelling liquid. But between gasps and gritted curses quickly commits what they saw to parchment.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Have you had enough now?",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Puppet.getImagePath());
				this.Characters.push(_event.m.Anatomist.getImagePath());

				local brothers = this.World.getPlayerRoster().getAll();
				local xp = this.Math.rand(280, 550)
				local entry = ::Legends.EventList.changeMood(_event.m.Anatomist, -1.0, "Lost a finger in search of knowledge")
				foreach( bro in brothers )
				{
					_event.m.Anatomist.addXP(xp);
					_event.m.Anatomist.updateLevel();
					this.List.push({
						id = 16,
						icon = "ui/icons/xp_received.png",
						text = Anatomist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]"+ xp +"[/color] Experience"
					});

					this.List.push({
						id = 16,
						icon = "ui/icons/damage_received.png",
						text = Anatomist.getName() + " [color=" + this.Const.UI.Color.NegativeEventValue + "]"lost a finger"[/color]"
					});
				}
			}

		});
		this.m.Screens.push({ //— \
			ID = "D", //more xp but don't lose a finger
			Text = "[img]gfx/ui/events/event_15.png[/img]%anatomist% begins at once — clearly well prepared for this situation. They begin with poking and prodding %puppet% with a cane. Methodically testing the reaction times and effects of the stick on the cadaver. Nothing much happens as the corpse simply daydreams the punishment away. \n\nA new tool comes out, this one with a pronounced point. The anatomist stabs into the shoulder of %puppet%, provoking a mild response but nothing more. Suddenly, something catches their eye between changing tools. Something you didn\'t notice. They move towards %puppet% and cast an eye down their lolling jaw. %SPEECH_ON%I think... I think I see something!%SPEECH_OFF% Before you can intercede, %anatomist% sticks a finger down the throat of %puppet%. Initially, the puppet seems to resist, but eventually calms down and stares in response with pallid eyes. The anatomist withdraws his fingers, producing a black mucus dripping from the ends. They quickly bottle the substance and keenly observe it outside under the sun. They stay transfixed as a cat would a bird — occasionally tapping the vial for any reaction and making frantic, yet methodical notes.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s enough for one day.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local entry = ::Legends.EventList.changeMood(_event.m.Anatomist, 1.5, "Performed a study on the living dead")
				local brothers = this.World.getPlayerRoster().getAll();
				local xp = this.Math.rand(280, 550)
				foreach( bro in brothers )
				{
					_event.m.Anatomist.addXP(xp);
					_event.m.Anatomist.updateLevel();
					this.List.push({
						id = 16,
						icon = "ui/icons/xp_received.png",
						text = Anatomist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]"+ xp +"[/color] Experience"
					});
				}
			}

		});
		this.m.Screens.push({ //— \
			ID = "E", //kill zombie but get a ton of xp for everyone
			Text = "[img]gfx/ui/events/event_63.png[/img]%anatomist%, with a sudden spring in their step, unfurls an array of tools that mix between medical and torture. They retreat to their tent, only to emerge with think gloves, a face covering and what you can only surmise as a butcher\'s apron. They find a spare table and set out an open air surgery in the middle of the camp. The rest of %companyname% orginally pays no notice, but keeps a curious eye on the excitement. You order %puppet% to shed it\'s armour and onto the table. To no surprise %anatomist% does not make any effort to put the creature out of it\'s misery for what comes next. \n\n%anatomist% starts at the legs, mumbling to themselves as a carpenter\'s saw bites into the dead flesh. %SPEECH%_ON%...and here, the damage from the weight of the armour is starting to show. The amount of weight needed to hold up itself and all that metal has caused the bone to come under stress...%SPEECH_OFF%%randombro% passes by, and is pulled into observing what is going on with a morbid curiosity. The surgeon does not pause. %SPEECH_ON%...over here — a similar story in the upper arms. In some places broken but still functional enough to swing or grab...%SPEECH_OFF%%anatomist% hands a part of %puppet%, who is calmly observing their own vivisection, to thr now growing crowd, who are nodding along.%SPEECH_ON%...and now...%SPEECH_OFF%The anatomist stops in their tracks as they cut open the chest. To you, all you see is a putrid mass of decayed organs in a slurry or jellied state. But to the trained eye, something seems amiss here. The silence is broken by a cleaver hacking violently at the neck of %puppet%, who offers no resistance aside from a gurgle. %anatomist% severs the head on the third swing which, still, refuses to die. After insepcting the still-living head as a washerwoman would a melon, the anatomist scoops out a black mucus from inside the throat from the wrong end. In doing this, the head spasams and falls silent. As they commit some notes, you see quite a crowd has formed, all of which seem to be visually dissecting the remains on the table.",
			Image = "",
			List = [],n
			Characters = [],
			Options = [
				{
					Text = "Crisis averted.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());

				_event.m.Puppet.getItems().transferToStash(this.World.Assets.getStash());
				this.World.getPlayerRoster().remove(_event.m.Puppet)
				local entry = ::Legends.EventList.changeMood(_event.m.Anatomist, 3.0, "Vivisected and throughly studied the living dead")
				local xp = ::Math.rand(390, 1700); //gain this xp
				foreach (bro in ::World.getPlayerRoster().getAll())
				{
					if (::Math.rand(1, 100) <= 50)
					{
						this.List.push(::Legends.EventList.changeBroExperience(bro, xp));
						::Legends.Traits.remove(::Legends.Trait.FearUndead);
					}
					this.List.push({
						id = 11,
						icon = "ui/icons/kills.png",
						text = Puppet.getName() + " [color=" + this.Const.UI.Color.NegativeEventValue + "]" has been dismembered and met final death "[/color] "
					});
					this.List.push({
						id = 11,
						icon = "ui/icons/xp_received.png",
						text = "Some of your company learned something."
					});
				}
			}
		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.Stash.getNumberOfEmptySlots() < 8) //must have 8 stash spaces free or more, due to the fact that when the puppet is killed, we need to account for all possible gear slots (1h, offhand, head, body, x2 bag, ammo & accessory) being filled so these items are not destroyed.
	 	{
			return;
		}

		if (brothers.len() < 5) //must have at least 5 fighters or more, to pad against sacrificing a fighter too early on
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_puppet = [];
		local candidates_anatomist = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}
					//puppet must be lvl 7 or higher to justify the cost of the sacrifice
			if (bro.getLevel() < 7 && bro.getBackground().getID() ==(::Legends.Background.LegendPuppet))
			{
				candidates_puppet.push(bro);
			}
					//Anatomist cannot have missing finger already
			else if (bro.getBackground().getID() == (::Legends.Background.Anatomist)) && (!bro.getSkills().hasSkill("injury.missing_finger"))
			{
				candidates_anatomist.push(bro);
			}
		}

		if (candidates_puppet.len() == 0)
		{
			return;
		}

		this.m.Puppet = candidates_puppet[this.Math.rand(0, candidates_puppet.len() - 1)];

		if (candidates_anatomist.len() != 0)
		{
			this.m.Anatomist = candidates_anatomist[this.Math.rand(0, candidates_anatomist.len() - 1)];
		}

		this.m.Score = candidates_puppet.len() * 8;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"puppet",
			this.m.Puppet.getName()
		]);
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
	}

	function onClear()
	{
		this.m.Puppet = null;
		this.m.Anatomist = null;
	}
});
