this.legend_necro_vs_witchhunters_event <- this.inherit("scripts/events/event", {
	m = {
		Witch = null,
		OtherBro = null
	},
	function create()
	{
		this.m.ID = "event.legend_necro_vs_witchunters"; //necromancer origins run into witchunter + mercs. Can try and pay them off or threaten them with low moral value
		this.m.Title = "Along the road...";
		this.m.Cooldown = 65.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //— \n |
			ID = "A",
			Text = "[img]gfx/ui/events/event_07.png[/img]While on the road, you pass by a caravan. They gawk as the caravan guards ready their weapons for impending attack, but seem rather surprised as you pass on by with little more than a prying gaze. Some time later, you are much less lucky — %companyname% finds themselves blocked on the road by several mercenaries and some rather interesting hooded figures. A younger man approaches, leveling and finger of scrutiny at the company. %SPEECH_ON%YOU THERE! WITCH!%SPEECH_OFF% The hooded figures ready their crossbows, some stuff cloth into their ears and another older man douses the tips of his bolts in a jar of liquid.%SPEECH_ON%YOUR TIME HERE IS UP, SURRENDER AND YOU MAY FIND MERCY%SPEECH_OFF% The rest of the cohort seems more reserved. A grizzled rotund man sporting a missing hand and full plate seems disinterested until the younger witch hunter shoots him a fiery look, to which he begrudgingly raises his good hand for the rest of mercenaries, a parity of leather and metal in comparison, to make ready. \n\nInstead of drawing his weapon, he reaches into a pack and resumes eating an apple as a spectator.",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "A fight it is!",
					function getResult( _event )
					{
						return "Fight";
					}

				}
			],
			function start( _event )
			{
				if (this.World.Assets.getMoney() >= 2500)
				{
					this.Options.push({
						Text = "Surely this isn\'t something that can\'t be solved with a fat purse of crowns?",
						function getResult( _event )
						{
							return "Bribe";
						}

					});
				}

				if (this.World.Assets.getMoralReputation() > 12) // Roughly two thirds in the lower end of the scale 'Cruel'
				{
					this.Options.push({
						Text = "You know who it is you\'re threatening? %companyname%!",
						function getResult( _event )
						{
							return "Intimidate";
						}

					});
				}

				if (this.World.Assets.getMoralReputation() > 84) // Roughly two thirds in the higher end of the scale 'Chivalrous'
					{
					this.Options.push({
						Text = "You know who it is you\'re threatening? %companyname%!",
						function getResult( _event )
						{
							return "Fight2";
						}

					});
				}

				this.Characters.push(_event.m.Witch.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Fight", //— \n |
			Text = "[img]gfx/ui/events/event_78.png[/img]The mercenaries, now with a clear signal of intent, respond by drawing up into a battle line as the witch hunters fall back behind them.",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "Charge!",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.UndeadTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.WitchunterMercenaries, this.Math.rand(80, 100) * _event.getReputationToDifficultyLightMult(), _event.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witch.getImagePath());
			}

		});
		this.m.Screens.push({ //easier fight
			ID = "Fight2", //— \n |
			Text = "[img]gfx/ui/events/event_75.png[/img]The fat man tosses his apple and strides across the soon-to-be battlefield. The witchunters get more anxious as the mercenaries become more ready to fight — edging closer to make up the distance between them and their commander slipping away. Stopping with a practiced halt, standing almost six foot tall and maybe half that lengthways, his armour is clean, but used. A crest adorns his shoulderplate of a noble house you can't quite place.%SPEECH_ON%I thought I recognised you. Witch. Mercenary. Whichever you prefer — I have seen some of your work and, just this once, I am willing to walk away. You have brought some honour to our work...%SPEECH_OFF%He looks %witch% up and down, and his tone shifts downwards.%SPEECH_ON%...origins.%SPEECH_OFF%With that, the captain of the mercenaries departs. He strides back to his mercenaries and speaks to a woman driving a cart, who whips the horses and turn around to leave. There is little confusion in the matter, some mercenaries jump onto the cart, while others take a brisk pace at each side of it. The retinue proceeds down the road and out of sight. \nThe witchunters do not share the same level of cohesion — they shout and yell at the departing mercenaries. Now quickly realising you have not done the same, and their hired help just abandoned them on this very quiet road...",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "Charge!",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.UndeadTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Witchunters, this.Math.rand(80, 100) * _event.getReputationToDifficultyLightMult(), _event.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witch.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Intimidate", //— \n |
			Text = "[img]gfx/ui/events/event_75.png[/img]There is an interlude after the name is shouted across the battlefield. The mercenaries whisper behind their shields as their hounds bark murder. The captain remains unphased, but after a few moments pulls aside a witchunter. The standoff happens for some time, but with little else said, both parties leave without incident. \n\nIt seems your cruel reputation, on this occasion, has preceded you.",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "And it should!",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witch.getImagePath());
			}

		});
		this.m.Screens.push({ //— \n |
			ID = "Bribe",
			Text = "[img]gfx/ui/events/event_04.png[/img]Tossing a bag of crowns, then another — and another. The mercenaries muddle with interest. The captain signals a man to go out there, and they quickly retrieve your bags of crowns. The captain speaks with a witch hunter, the conversation is brief but results in the mercenary band departing. The witchunters take their hounds and vigour with them as they slink into the gloom of the forest, bitterness in every step and action.",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "Phew.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witch.getImagePath());
				this.World.Assets.addMoney(-2000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + 2000 + "[/color] Crowns"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 15)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.FactionManager.isGreaterEvil())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		if (brothers.len() < 2)
		{
			return;
		}

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == [::Legends.Background.LegendCommanderNecro] || bro.getBackground().getID() == [::Legends.Background.LegendPreserver] || bro.getBackground().getID() == [::Legends.Background.LegendWarlockSummoner] || bro.getBackground().getID() == [::Legends.Background.LegendPuppetMaster])
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Witch = candidates[this.Math.rand(0, candidates.len() - 1)];

		do
		{
			this.m.OtherBro = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
		while (this.m.OtherBro == null || this.m.OtherBro.getID() == this.m.Witch.getID());

		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"witch",
			this.m.Witch.getName()
		]);
		_vars.push([
			"other_bro",
			this.m.OtherBro.getName()
		]);
		_vars.push([
			"bribe",
			"2000"
		]);
	}

	function onClear()
	{
		this.m.Witch = null;
		this.m.OtherBro = null;
	}

});

