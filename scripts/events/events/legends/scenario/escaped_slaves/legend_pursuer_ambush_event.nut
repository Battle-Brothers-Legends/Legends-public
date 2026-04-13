this.legend_pursuer_ambush_event <- this.inherit("scripts/events/event", {
	m = {
		BribeAmount = 0.0,
		DifficultyMult = 0.0,
		DifficultyMultScale = 0.0,
		ChampionChance = 0,
		NemesisCityState = null,
		ResourceBoost = 0
	},
	function create()
	{
		local ManhuntersText1 = "An unnatural quiet takes hold, and the hairs on the back of your neck prick up. It seems %nemesisviziername% has not forgotten about you or your escape. You\'re surrounded by manhunters!";
		local ManhuntersText2 = "Two men come out from behind a thicket, standing directly in your path. More materialize behind you. One of them brandishes a pair of manacles and jeers at you. Your heart sinks as you realize their true purpose: Manhunters from the %nemesiscityname%, here to capture or kill you! You have no choice but to defend yourselves!";
		local ManhuntersText3 = "A group of mean looking men filter out into the path in front of you. You glance over your shoulder and see more of them there, too.%SPEECH_ON%%nemesisviziername% sends his regards, slave.%SPEECH_OFF%One of the men in front of you spits out. Manhunters, then. You order the company to defend themselves as the hunters close in...";
		this.m.ID = "event.legend_pursuer_ambush";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 6.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "Manhunters",
			Text = "[img]gfx/ui/events/event_172.png[/img]{" + ManhuntersText1 + " | " + ManhuntersText2 + " | " + ManhuntersText3 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						this.World.Statistics.getFlags().set("LegendLastAmbushType", "Manhunters");
						_event.m.NemesisCityState.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "You evaded capture");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.OrientalBanditTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.LegendManhunters, (100 + _event.m.ResourceBoost) * _event.m.DifficultyMult * _event.m.DifficultyMultScale, this.Const.Faction.Enemy, _event.m.ChampionChance);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		local ManhuntersBribeText1 = "A band of men suddenly materialize all around you, stepping out of brush, climbing down from perches, even popping out of holes in the ground.%SPEECH_ON%I see you\'ve main a bit of a name for yourself, Indebted. %nemesisviziername% will pay well for your heads, but you lot clearly know how to handle yourselves in a fight. You make it worth my while, and we can forget we ever saw each other, yeah?%SPEECH_OFF%The manhunter who spoke jeers at you, but the group keeps their distance awaiting your response.";
		local ManhuntersBribeText2 = "You\'re stopped by a man cheerfully swinging a pair of manacles around.%SPEECH_ON%Hold there, good sir! It seems that you\'ve gotten the attention of the %nemesiscityname%, and they\'re quite displeased with you. Seems they think you\'re some sort of Indebted who escaped before the Gilder had his due, and me and my men have been hired to bring you back in, or kill the lot of you if that\'s what it takes.%SPEECH_OFF%More men appear behind the speaker, some with weapons already drawn, but he puts his manacle down and gives you a friendly smile.%SPEECH_ON%Of course, it seems they\'ve clearly made a mistake. After all, you lot are all a professional mercenary company, aren\'t you? Escaped slaves, indeed. Ha! I daresay we have nothing to fight over at all. Of course, seeing as how my group here has come all this way, we\'ll need some money for the return trip, and the vizier will hardly pay us for coming back empty handed. If you catch my drift, sir.%SPEECH_OFF%";
		this.m.Screens.push({
			ID = "ManhuntersBribe",
			Text = "[img]gfx/ui/events/event_172.png[/img]{" + ManhuntersBribeText1 + " | " + ManhuntersBribeText2 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You\'ll regret crossing our path, manhunter.",
					function getResult( _event )
					{
						this.World.Statistics.getFlags().set("LegendLastAmbushType", "ManhuntersBribe");
						return "ManhuntersBribeBattle";
					}

				},
				{
					Text = "Perhaps we can work this out. Will %bribe% crowns do?",
					function getResult( _event )
					{
						this.World.Statistics.getFlags().set("LegendLastAmbushType", "ManhuntersBribe");
						return "ManhuntersBribeSuccess";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "ManhuntersBribeBattle",
			Text = "[img]gfx/ui/events/event_172.png[/img]The man in front snarls.%SPEECH_ON%So be it, slave.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						_event.m.NemesisCityState.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "You evaded capture");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.OrientalBanditTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.LegendManhunters, (115 + _event.m.ResourceBoost) * _event.m.DifficultyMult * _event.m.DifficultyMultScale, this.Const.Faction.Enemy, _event.m.ChampionChance);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "ManhuntersBribeSuccess",
			Text = "[img]gfx/ui/events/event_172.png[/img]The man flashes you a vicious smile as he counts out the coin.%SPEECH_ON%A pleasure doing business with you, \'Crownling\'. Ha! Maybe we\'ll cross paths again some day, eh?%SPEECH_OFF%His smile disappears and his voice drops to a growl.%SPEECH_ON%Now get out of my sight.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "At least we avoided a fight...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-_event.m.BribeAmount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.BribeAmount + "[/color] Crowns"
				});
			}

		});
		local AssassinsText1 = "It seems that the %nemesiscityname% is no longer content to send mere manhunters after you - assassins descend upon you from the shadows! Defend yourselves!";
		local AssassinsText2 = "%nemesisviziername% has a long memory for grudges. You knew this, having dealt with his manhunters before, but somehow you never expected him to go so far as to hire assassins to hunt you down! You order the company to defend themselves as cloaked figures menacingly advance upon you from all directions...";
		this.m.Screens.push({
			ID = "Assassins",
			Text = "[img]gfx/ui/events/event_165.png[/img]{" + AssassinsText1 + " | " + AssassinsText2 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						this.World.Statistics.getFlags().set("LegendLastAmbushType", "Assassins");
						_event.m.NemesisCityState.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "You evaded capture");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.OrientalCityStateTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Assassins, 90 * _event.m.DifficultyMult * _event.m.DifficultyMultScale, this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		local BountyHunterText1 = "A group of armed men step out onto the road.%SPEECH_ON%Sorry to do this to ya, friend. Us bounty hunters usually leave slave hunting to the southerners, but the vizier said he didn\'t care if you was dead or alive, and we need that money.%SPEECH_OFF%The man who spoke looks almost apologetic as he draws his weapon.";
		local BountyHunterText2 = "A voice from the brush hails you.%SPEECH_ON%What could a bunch of sorry wenches like you do to piss off the %nemesiscityname% so bad they put a bounty on your head, anyway?%SPEECH_OFF%The voice is followed by a group of nasty looking men who spill out onto the path before you. The leader levels his weapon at you and spits.%SPEECH_ON%They don\'t care if we bring you in dead or alive, though, so I guess I\'ll just hafta keep on wondering.%SPEECH_OFF%";
		this.m.Screens.push({
			ID = "BountyHunters",
			Text = "[img]gfx/ui/events/event_07.png[/img]{" + BountyHunterText1 + " | " + BountyHunterText2 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						this.World.Statistics.getFlags().set("LegendLastAmbushType", "BountyHunters");
						_event.m.NemesisCityState.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "You evaded capture");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.OrientalCityStateTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.BountyHunters, 125 * _event.m.DifficultyMult * _event.m.DifficultyMultScale, this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return false;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.legend_escaped_slaves")
		{
			return;
		}

		if (this.World.getTime().Days < 12)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= 3)
			{
				nearTown = true;
				break;
			}
		}

		if (nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.slave")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local slaveModifier = this.Math.min(candidates.len(), 12 + this.World.Assets.getCombatDifficulty());
		this.m.Score = this.Math.max(slaveModifier * 7, 15);
	}

	function onDetermineStartScreen()
	{
		local canBeAssassins = false;
		local canBeBountyHunters = false;
		local canBeBribed = false;
		local currentTile = this.World.State.getPlayer().getTile();
		local days = this.World.getTime().Days;
		local renown = this.World.Assets.getBusinessReputation();
		local lastAmbush = this.World.Statistics.getFlags().get("LegendLastAmbushType");

		if (renown >= 2350 && !this.World.getTime().IsDaytime && lastAmbush != "Assassins")
		{
			canBeAssassins = true;
		}

		if (renown >= 1850 && currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills && lastAmbush != "BountyHunters")
		{
			canBeBountyHunters = true;
		}

		if (this.World.Assets.getMoney() >= this.m.BribeAmount + 500 && lastAmbush != "ManhuntersBribe")
		{
			canBeBribed = true;
		}

		local eventRoll = this.Math.rand(1, 100);

		if (eventRoll >= 80 && canBeAssassins)
			return "Assassins";
		if (eventRoll >= 67 && canBeBountyHunters)
			return "BountyHunters";
		if (eventRoll >= 50 && canBeBribed)
			return "ManhuntersBribe";
		return "Manhunters";
	}

	function onPrepare()
	{
		this.calcDifficultyMult();
		this.m.ResourceBoost = this.calcResourceBoost();
		this.m.DifficultyMultScale = this.getScaledDifficultyMult();

		if (this.m.DifficultyMult > 1.05)
		{
			this.m.BribeAmount = this.Math.round(this.Math.rand(1200, 3000) * 0.01) * 100.0;
		}
		else if (this.m.DifficultyMult > 0.85)
		{
			this.m.BribeAmount = this.Math.round(this.Math.rand(1000, 2500) * 0.01) * 100.0;
		}
		else
		{
			this.m.BribeAmount = this.Math.round(this.Math.rand(800, 2000) * 0.01) * 100.0;
		}

		this.m.NemesisCityState = this.World.FactionManager.getFaction(this.World.Statistics.getFlags().get("NemesisCityStateID"));
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"nemesiscityname",
			this.m.NemesisCityState.getName()
		]);
		_vars.push([
			"nemesisviziername",
			this.m.NemesisCityState.getRandomCharacter().getName()
		]);
		_vars.push([
			"bribe",
			this.m.BribeAmount
		]);
	}

	function onClear()
	{
		this.m.BribeAmount = 0.0;
		this.m.DifficultyMult = 0.0;
		this.m.DifficultyMultScale = 0.0;
		this.m.ResourceBoost = 0;
		this.m.NemesisCityState = null;
	}

	function calcDifficultyMult()
	{
		local r;

		if (this.World.getTime().Days < 20)
		{
			r = this.Math.rand(1, 30);
		}
		else if (this.World.getTime().Days < 40)
		{
			r = this.Math.rand(1, 80);
		}
		else
		{
			r = this.Math.rand(1, 100);
		}

		if (r <= 30)
		{
			this.m.ChampionChance = 0;
			this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		}
		else if (r <= 80)
		{
			this.m.ChampionChance = 0;
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.ChampionChance = 1;
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}

		this.m.ChampionChance += getAdditionalChampionChance();
	}

	function getAdditionalChampionChance()
	{
		if (this.World.getTime().Days < 50)
		{
			return 0;
		}
		else if (this.World.getTime().Days < 90)
		{
			return 1;
		}
		else
		{
			return 3;
		}
	}

	function getScaledDifficultyMult()
	{
		local s = this.Math.maxf(0.75, 0.90 * this.Math.pow(0.01 * this.World.State.getPlayer().getStrength(), 0.85));
		local d = this.Math.minf(5.0, s);
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	function calcResourceBoost()
	{
		local defaultBoost = -10;
		local dayModifier = this.Math.min(this.World.getTime().Days / 5, 30);

		return defaultBoost + dayModifier;
	}

});

