this.legend_lonewolf_companion_melee_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legend_lonewolf_companion_melee";
		this.m.Title = "Like minds and simple hearts";
		this.m.Cooldown = 22.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_36.png[/img]{A figure comes into sight, sitting on a low rock and carefully sharpening their weapon and patching any holes in their armour. Strangely enough, they speak first.%SPEECH_ON%I\'m %recruit%, and there\'s talk across the land of you runnin\' around looking to prove \'urself%SPEECH_OFF%Your hand steadily crawls towards your weapon but the stranger takes note of this.%SPEECH_ON%No — not like that. In fact, I\'m interested in joining. The arenas in the south only have so many things to kill and the north can be...somewhat empty at times.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Show me your swingin\' arm. | How good is your swing? | Try to hit me.}",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "{Can you hold a shield? | How well can you block? | Ever been in a shieldwall?}",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "{You don\'t seem very remarkable to me... | You don\'t stand out to me... | You seem rather ordinary...}",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "Not interested.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_76.png[/img]{%recruit% smiles and picks up their weapon. At first their attacks are random and clumsy but gradually pick up in speed and precision as they probe the weak points of your defence. You deflect an incoming thrust only to be kicked in the shin and subsequently punched in the face by a fist tightly gripped around the handle of their weapon.%SPEECH_ON%You should look down more, friend. You keep your eyes up high and around my shoulders but you reacted far too slowly to all those low hits I tried to get in on you.%SPEECH_OFF%You brush the blood from around your nose. Your eyes water a little but you managed to regain your composure.%SPEECH_ON%Fine, you\'re in.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{More killing power is always a good thing... | A good arm will get you far in this business. | Now for the real thing...}",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
				_event.m.Dude.getBaseProperties().Hitpoints += 0;
				_event.m.Dude.getBaseProperties().Bravery += 5;
				_event.m.Dude.getBaseProperties().Stamina += 3;
				_event.m.Dude.getBaseProperties().MeleeSkill += 4;
				_event.m.Dude.getBaseProperties().RangedSkill += 0;
				_event.m.Dude.getBaseProperties().MeleeDefense -= 5;
				_event.m.Dude.getBaseProperties().RangedDefense += 0;
				_event.m.Dude.getBaseProperties().Initiative += 0;
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_76.png[/img]{%recruit% brings their weapon to bare and nods to indicate they are ready to be tested — you start to play with them at first, little, lazily stabs and swinging to see if they flinch, but every attack you make is met by their defence.\n After a few more blows a sense of self doubt begins to set in. You gradually try harder and harder to make your weapon connect with anything but their own blade, eventually resorting to elaborate feints and chambers to try and land any hit worthy of merit.\n\n You begin to tire and the recruit speaks up again. %SPEECH_ON%Done?%SPEECH_OFF% You take a long inhale %SPEECH_ON%Done. Fall in line.%SPEECH_OFF% %recruit% gleefully packs their bags and waits for your orders.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Fighting in the front is never easy. | At least you can take a few hits. | The real thing will be much different.}",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
				_event.m.Dude.getBaseProperties().Hitpoints += 5;
				_event.m.Dude.getBaseProperties().Bravery += 0;
				_event.m.Dude.getBaseProperties().Stamina += 8;
				_event.m.Dude.getBaseProperties().MeleeSkill += 0;
				_event.m.Dude.getBaseProperties().RangedSkill += 0;
				_event.m.Dude.getBaseProperties().MeleeDefense += 5;
				_event.m.Dude.getBaseProperties().RangedDefense += 5;
				_event.m.Dude.getBaseProperties().Initiative += 0;
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_76.png[/img]%recruit% shrugs. %SPEECH_ON%Truth be told, I\'m new to all of this. My old master died a few months ago and {he | she} left everything to me — I\'ve been lookin\' to fill their boots but so far i/'m struggling to keep up with all the tournaments and areas.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Worth a tryout I guess. | You can improve. | We\'ll make a master out of you yet...}",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
				_event.m.Dude.getBaseProperties().Hitpoints += 0;
				_event.m.Dude.getBaseProperties().Bravery += 5;
				_event.m.Dude.getBaseProperties().Stamina += 3;
				_event.m.Dude.getBaseProperties().MeleeSkill += 0;
				_event.m.Dude.getBaseProperties().RangedSkill += 0;
				_event.m.Dude.getBaseProperties().MeleeDefense += 0;
				_event.m.Dude.getBaseProperties().RangedDefense += 0;
				_event.m.Dude.getBaseProperties().Initiative += 0;
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Bright);
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_76.png[/img]The figure goes back to whatever it is they were doing before as you pass.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I\'m not recruiting everyone from here to the coast.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			]
		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf")
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 15;
	}

	function onPrepareVariables( _vars )
	{
		if (this.m.Dude == null)
		{
			local roster = this.World.getTemporaryRoster();
			this.m.Dude = roster.create("scripts/entity/tactical/player");
			this.m.Dude.setStartValuesEx([
				"legend_companion_melee_background"
			]);
			this.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
		}

		_vars.push([
			"recruit",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

