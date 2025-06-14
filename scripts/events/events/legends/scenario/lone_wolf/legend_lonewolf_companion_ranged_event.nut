this.legend_lonewolf_companion_ranged_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legend_lonewolf_companion_ranged";
		this.m.Title = "Like minds and simple hearts";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_36.png[/img]{A figure comes into sight, sitting on a low rock and carefully sharpening their weapon and patching any holes in their armour. Strangely enough, they speak first.%SPEECH_ON%I\'m %recruit%, and there\'s talk across the land of you runnin\' around looking to prove \'urself%SPEECH_OFF%Your hand steadily crawls towards your weapon but the stranger takes note of this.%SPEECH_ON%No — not like that. In fact, I\'m interested in joining. The arenas in the south only have so many things to kill and the north can be...somewhat empty at times.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{How good is your aim? | How accurate are you?}",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "{Can you dodge an arrow? | How well do you do under pressure?}",
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
			Text = "[img]gfx/ui/events/event_76.png[/img]{%recruit% picks up their crossbow and loads a bolt. You place 3 bottles in a line on a nearby stone wall. They take aim as soon as you are clear and shoot the bottom out of one of the bottles. As they reload, they don\'t dare take their eye of their second target - effectively reloading blind.\n\n The next shot is a snap shot that grazes the second bottle, which causes it to tumble and smash from the top of the wall. %recruit% curses under their breath and this time reloads their weapon while looking down, quickly placing a new bolt into the groove.\n The third shot perfectly crowns the bottle neck and leaves the belly standing on the wall like a crow perches on a railing. The fourth bolt smashes directly through the middle of what remains a second or two later.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{A good shot, mostly. | A good shot but lacking awareness. | Now we\'ll all be safe when the bottles invade.}",
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
				_event.m.Dude.getBaseProperties().Stamina += 0;
				_event.m.Dude.getBaseProperties().MeleeSkill += 0;
				_event.m.Dude.getBaseProperties().RangedSkill += 10;
				_event.m.Dude.getBaseProperties().MeleeDefense += 0;
				_event.m.Dude.getBaseProperties().RangedDefense += 0;
				_event.m.Dude.getBaseProperties().Initiative += 5;
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_76.png[/img]{%recruit% hands you their bow, then walks several paces away from you until you are both a good distance apart. You ready the bow and let loose an arrow that would hit, but is a bit wide off the mark. %recruit% does not flinch.\n\nYou ready another arrow, this time aiming for center mass. Despite the speed of the projectile, your target casually steps to one side as so the arrow barely brushes off their shoulder.\n\nFrustrated, you notch another arrow and aim for the head. As you release, your target does not move as they did before. Instead the arrow brushes past their left ear and they remain unflinching. Their voice echos across the distance between the two of you. %SPEECH_ON%You had me worried there - I thought you were really trying to hit me for a moment!%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Get in line. | It was the wind. | I\'d like to see how they fare against more than one arrow.}",
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
				_event.m.Dude.getBaseProperties().Stamina += 5;
				_event.m.Dude.getBaseProperties().MeleeSkill += 0;
				_event.m.Dude.getBaseProperties().RangedSkill += 0;
				_event.m.Dude.getBaseProperties().MeleeDefense += 0;
				_event.m.Dude.getBaseProperties().RangedDefense += 8;
				_event.m.Dude.getBaseProperties().Initiative += 10;
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_76.png[/img]{%SPEECH_ON%I like to take my time with my shots - let me show you...%SPEECH_OFF%%recruit% brings their weapon up and finds a suitable target. They aim.\n\nAnd aim.\n\nAnd aim.\n\nYou stay silent, wondering if this is part of some elaborate act, but after some more moments in passing %recruit% looses their shot well past what you thought they were aiming for and into a bush\n\nYou both hear a distant thud as %recruit% calmly walks in the direction of the noise and the bolt.\n After clearing the brush, you see a small deer that has their projectile lodged firmly into their eye socket. Killing it near instantly.%SPEECH_ON%I\'ve been huntin\' that deer all day. Finally got the bastard.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Well, you hit it at least... | I hope they don\'t take as long to piss. | Deadly. You almost killed it from boredom.}",
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
				_event.m.Dude.getBaseProperties().Bravery += 0;
				_event.m.Dude.getBaseProperties().Stamina += 5;
				_event.m.Dude.getBaseProperties().MeleeSkill += 0;
				_event.m.Dude.getBaseProperties().RangedSkill -= 5;
				_event.m.Dude.getBaseProperties().MeleeDefense += 0;
				_event.m.Dude.getBaseProperties().RangedDefense += 2;
				_event.m.Dude.getBaseProperties().Initiative -= 15;
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendSureshot);
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

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		if (this.m.Dude == null)
		{
			local roster = this.World.getTemporaryRoster();
			this.m.Dude = roster.create("scripts/entity/tactical/player");
			this.m.Dude.setStartValuesEx([
				"legend_companion_ranged_background"
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

