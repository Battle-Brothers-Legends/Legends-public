this.legend_swordmaster_fav_enemy_event <- this.inherit("scripts/events/event", {
	m = {
		Stats = null,
		MinStrength = 100,
		Candidates = null,
		Champion = null,
		Flags = null,
		Perk = ::Legends.Perks.getID(::Legends.Perk.LegendFavouredEnemySwordmaster),
		ValidTypes = this.Const.LegendMod.FavoriteSwordmaster,
		WasInReserves = [],
		isValidForEncounter = false
	},
	function create()
	{
		this.m.ID = "event.legend_swordmaster_fav_enemy";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A1",
			Text = "[img]gfx/ui/events/event_144.png[/img]{You discover a cave in the ice with its maw shielded by a gate of thick icicles. Looking through the icy bars, you find the cave quickly declines down a steep slope and toward what may be an underground riverbank that has long since frozen. Something is huddled beside it hitting the ice with a pickaxe over and over again. The wind whistles as it grates against the teeth of the cave. You call out to the huddled man, but there is no response.\n\nIt will take some time to chop through this thick ice and get in there. Fortunately, one of the sellswords reports that there may be a rear entrance. It is blocked just as well, but a strong enough man just might be able to squeeze through and face any dangers within.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Title = "As you approach...";

				foreach( bro in _event.m.Candidates )
				{
					_event.m.Candidates.sort(function ( _a, _b )
					{
						if (_a.getXP() > _b.getXP())
						{
							return -1;
						}
						else if (_a.getXP() < _b.getXP())
						{
							return 1;
						}

						return 0;
					});
				}

				local e = this.Math.min(4, _event.m.Candidates.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = _event.m.Candidates[i];
					this.Options.push({
						Text = "I need you to scout ahead, " + bro.getName() + ".",
						function getResult( _event )
						{
							_event.m.Champion = bro;
							return "B";
						}

					});
				}

				this.Options.push({
					Text = "We should leave this place.",
					function getResult( _event )
					{
						return 0;
					}

				});
				_event.m.Champion = _event.m.Candidates[this.Math.rand(0, _event.m.Candidates.len() - 1)];
				_event.m.Flags.set("EnemyChampionName", this.Const.Strings.BarbarianNames[this.Math.rand(0, this.Const.Strings.BarbarianNames.len() - 1)] + " " + this.Const.Strings.BarbarianTitles[this.Math.rand(0, this.Const.Strings.BarbarianTitles.len() - 1)]);
			}

		});
		this.m.Screens.push({
			ID = "A2",
			Text = "[img]gfx/ui/events/event_134.png[/img]{Marching through countryside. Your feet are still tired from the strain of the last few days. Your marching is interrupted by a lean, young and eager looking fellow.%SPEECH_ON%Stop right there, rabble!%SPEECH_OFF% He shouts to you and your company. Slightly confused, your mercenaries throw glances to each other, raising their shoulders. %randombrother% replies, slightly amused.%SPEECH_ON%What in the hells do you think you´re doing, little wanker? Those rabble you\'re talking to will cut your throat just for fun. Didn\'t your parents teach you any common sense?%SPEECH_OFF%Carelessly, the young fellow proceeds. %SPEECH_ON%My name is %enemyname%. Looks like it is I who will have to teach you some common sense. It is I who decide which throats get cut! One more insolent comment like that from any of you, and I\'ll have you all hanged!%SPEECH_OFF% Your mercenaries start to fall in laughter. %randombrother2% replies with an angry voice. %SPEECH_ON% Ha. You? I don\'t see your army. Or is it the lordship himself, which wants to do all the dirty work, hm? Come here and try me.%SPEECH_OFF% %enemyname% answers. %SPEECH_ON% It is not you I want to fight. It is %chosen%. I heard he\'s a good fighter. I want to beat him. In the glory of my name, I demand a fight to life or death!%SPEECH_OFF% The haughty juvenile raises his weapon, pointing it toward %chosen%. \n\n Despite the fact that a couple meters separates the %enemyname% and %chosen%, you can feel the tension in the air.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Title = "While marching...";

				foreach( bro in _event.m.Candidates )
				{
					_event.m.Candidates.sort(function ( _a, _b )
					{
						if (_a.getXP() > _b.getXP())
						{
							return -1;
						}
						else if (_a.getXP() < _b.getXP())
						{
							return 1;
						}

						return 0;
					});
				}

				local e = this.Math.min(4, _event.m.Candidates.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = _event.m.Candidates[i];
					this.Options.push({
						Text = "Alright, teach this little wanker a lesson " + bro.getName() + ".",
						function getResult( _event )
						{
							_event.m.Champion = bro;
							return "N";
						}

					});

				}

				this.Options.push({
					Text = "Leave him alone. Slaughtering a kid wont bring us any fame.",
					function getResult( _event )
					{
						return 0;
					}

				});
				_event.m.Champion = _event.m.Candidates[this.Math.rand(0, _event.m.Candidates.len() - 1)];
				_event.m.Flags.set("EnemyChampionName", this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]);
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_144.png[/img]{%chosen% heads off while you and the rest work on the front of the cave. You knock a few of the thick icicles out letting you see into the cave with better eyes. Just as you do, %chosen% comes tumbling down an adjacent slope and lands right in the middle of the cave and slides across the frozen river and rides up its embankment. He hops to his feet and dusts himself off with a childish grin.\n\n In a flash the huddled man slams the pickaxe into the ice with unhinted power and the shards splinter from one side of the embankment to the other. The clank of the metal and shattered ice reverberates as though lightning itself had struck. Now you can finally see the stranger: he is a barbarian shelled in broken armor that rattles as he moves. The icy walls mirror his steps, scattering his presence all around the cave in transient sheens. Jittery and jutting, his walk is seemingly going backwards despite his advance as though his shadow were his true self and his flesh the afterimage. Despite being in a cave, his loud voice echoes not at all.%SPEECH_ON%An interloper in my midst, a mere moment from the mist, these things I shall not miss.%SPEECH_OFF%He approaches the sellsword like a cold spider unfurling from its trapdoor. You see that his face is half-frozen, and a wry smile squeezes across the half that could still be called flesh.%SPEECH_ON%I long to leave this body, my dear fighter. Will you help guide me out and to something higher?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "",
					function getResult( _event )
					{
						local name = _event.m.Flags.get("EnemyChampionName");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.BarbarianTracks;
						properties.Entities = [];
						properties.Entities.push({
							ID = this.Const.EntityType.BarbarianChampion,
							Variant = 1,
							Row = 0,
							Name = name,
							Script = "scripts/entity/tactical/humans/barbarian_champion",
							Faction = this.Const.Faction.Enemy,
							function Callback( _entity, _tag )
							{
								_entity.setName(name);
							}

						});

						if (_event.m.Champion.isInReserves())
						{
							_event.m.WasInReserves.push(_event.m.Champion);
							_event.m.Champion.setInReserves(false);

						}

						properties.Players.push(_event.m.Champion);
						properties.IsUsingSetPlayers = true;
						properties.IsFleeingProhibited = true;
						properties.IsAttackingLocation = true;
						properties.BeforeDeploymentCallback = function ()
						{
							local size = this.Tactical.getMapSize();

							for( local x = 0; x < size.X; x = x )
							{
								for( local y = 0; y < size.Y; y = y )
								{
									local tile = this.Tactical.getTileSquare(x, y);
									tile.Level = this.Math.min(1, tile.Level);
									y = ++y;
								}

								x = ++x;
							}
						};
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(properties, false, false, false);
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "As you approach...";
				this.Options[0].Text = "You can take him, %chosen%!";
				this.Characters.push(_event.m.Champion.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "N",
			Text = "[img]gfx/ui/events/event_35.png[/img]{%chosen% heads off to confront %enemyname% while the rest of the company observes from a distance.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "",
					function getResult( _event )
					{
						local r = this.Math.rand(0, 2);
						local name = _event.m.Flags.get("EnemyChampionName");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.NobleTracks;
						properties.Entities = [];

						if (r == 0)
						{
							properties.Entities.push({
								ID = this.Const.EntityType.Swordmaster,
								Variant = 1,
								Row = 0,
								Name = name,
								Script = "scripts/entity/tactical/humans/swordmaster",
								Faction = this.Const.Faction.Enemy,
								function Callback( _entity, _tag )
								{
									_entity.setName(name);
								}

							});
						}

						if (r == 1)
						{
							properties.Entities.push({
								ID = this.Const.EntityType.BanditLeader,
								Variant = 1,
								Row = 0,
								Name = name,
								Script = "scripts/entity/tactical/enemies/bandit_leader",
								Faction = this.Const.Faction.Enemy,
								function Callback( _entity, _tag )
								{
									_entity.setName(name);
								}

							});
						}

						if (r == 2)
						{
							properties.Entities.push({
								ID = this.Const.EntityType.HedgeKnight,
								Variant = 1,
								Row = 0,
								Name = name,
								Script = "scripts/entity/tactical/humans/hedge_knight",
								Faction = this.Const.Faction.Enemy,
								function Callback( _entity, _tag )
								{
									_entity.setName(name);
								}

							});
						}

						if (_event.m.Champion.isInReserves())
						{
							_event.m.WasInReserves.push(_event.m.Champion);
							_event.m.Champion.setInReserves(false);
						}

						properties.Players.push(_event.m.Champion);
						properties.IsUsingSetPlayers = true;
						properties.IsFleeingProhibited = true;
						properties.IsAttackingLocation = true;
						properties.BeforeDeploymentCallback = function ()
						{
							local size = this.Tactical.getMapSize();

							for( local x = 0; x < size.X; x = x )
							{
								for( local y = 0; y < size.Y; y = y )
								{
									local tile = this.Tactical.getTileSquare(x, y);
									tile.Level = this.Math.min(1, tile.Level);
									y = ++y;
								}

								x = ++x;
							}
						};
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(properties, false, false, false);
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "The duel!";
				this.Options[0].Text = "You can take him, %chosen%!";
				this.Characters.push(_event.m.Champion.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_96.png[/img]{%chosen% stands victorious over a badly wounded %enemyname%. The defeated nobleman can barely catch his breath. Every gasp of air comes with great pain for him. Bleeding and shaking, he is soon to depart from the world of the living. The duel was meant to be to the death but %chosen% does not deliver a final blow. The rest of your mercenaries gather around the winner. Most of the company is cheering the now glorious %chosen%, but some are more concerned about the unfinished business laying on the ground in a pool of his own blood. %randombrother% speaks up with strong contempt for the loser of this duel. %SPEECH_ON%What you waiting for %chosen%? You think this whipster would show you mercy?%SPEECH_OFF% The company champion answers. %SPEECH_ON%I will take his equipment as a reward, he's no good to me dead.%SPEECH_OFF% }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You did well, %chosen%.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				this.Characters.push(_event.m.Champion.getImagePath());
				this.World.Assets.addBusinessReputation(50);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/special.png",
						text = "The company gained renown"
					}
				];

				if (_event.m.Champion.getBaseProperties().MeleeSkill < 100)
				{
					_event.m.Champion.improveMood(0.5, "Improved his skills though duel");
					this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.Champion, ::Math.rand(1, 3)));
				}

				if (_event.m.Champion.getBaseProperties().MeleeDefense < 50)
				{
					_event.m.Champion.improveMood(0.5, "Improved his skills though duel");
					::Legends.EventList.changeMeleeDefense(_event.m.Champion, ::Math.rand(1, 3));
				}

				if (_event.m.Champion.getMoodState() >= this.Const.MoodState.Neutral) {
					this.List.push(::Legends.EventList.changeMood(_event.m.Champion));
				}

				_event.m.Champion.getSkills().update();
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat) && this.Math.rand(1, 100) <= 33) {
						bro.improveMood(0.5, "The company\'s champion won an impressive duel");
					}

					if (bro.getMoodState() > this.Const.MoodState.Neutral) {
						this.List.push(::Legends.EventList.changeMood(bro));
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_58.png[/img]{%enemyname% emerges victorious from the duel. Winning this fight made him even more eager and confident. Looks like he wants to fight everybody in the company, one by one. With a voice full of pride he shouts to your men. %SPEECH_ON%Who\'s  next ?!%SPEECH_OFF% }",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				foreach( bro in _event.m.Candidates )
				{
					_event.m.Candidates.sort(function ( _a, _b )
					{
						if (_a.getXP() > _b.getXP())
						{
							return -1;
						}
						else if (_a.getXP() < _b.getXP())
						{
							return 1;
						}

						return 0;
					});
				}

				local e = this.Math.min(4, _event.m.Candidates.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = _event.m.Candidates[i];
					this.Options.push({
						Text = "I need you to avenge us, " + bro.getName() + ".",
						function getResult( _event )
						{
							_event.m.Champion = bro;
							return "N";
						}

					});
				}

				this.Options.push({
					Text = "This isn\'t worth it. We should leave.",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_144.png[/img]{As you depart the cave, a local northerner covered in bear furs stands across the company. He looks at you and then the cave entrance. He asks.%SPEECH_ON%Do you speak the southern or native tongue?%SPEECH_OFF%Keeping your guard, you confirm the former. He nods.%SPEECH_ON%And what did you see in that cave? Did you see it?%SPEECH_OFF%You tell him you found nothing, only a madman. The stranger smirks.%SPEECH_ON%A madman. A madman, that is what you think you saw. It is within us all to speak warily of the unnatural, but not within us to recognize when nature herself takes a step back. Horrors are easier said than seen. That was no ordinary man, you fool, but the Ijirok, a transient spirit that shifts from one vessel to another. No one really knows what it looks like, the whole world is simply a series of masks and it will happily go from one to the other, usually taking the shape of animals, sometimes a man if he is so weak. It is a being of absolute malice. It cannot be killed, no, it sees death, even its own, as entertainment. It remembers those who escape it, it remembers those it wishes to play with. I pray you\'ve a face worth forgetting.%SPEECH_OFF%You put your hand on the pommel of your sword and tell him that whatever mysticism and mythmaking he\'s got left he can keep to himself. You saw the madman in the cave, and that\'s all he was, a man. The stranger nods again and backs off.%SPEECH_ON%As you wish, and may you travel well.%SPEECH_OFF%} ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Travel well.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 8 && !t.isIsolated()) // WAS 10
			{
				town = t;
				break;
			}
		}

		if (town == null)
		{
			return;
		}

		local candidates = [];

		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			if (!bro.getSkills().hasPerk(::Legends.Perk.LegendFavouredEnemySwordmaster)) // perk check
				continue;

			if (bro.getLevel() < 11) // level check
				continue;

			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(bro, this.Const.LegendMod.FavoriteSwordmaster);

			for( ; stats.Strength < this.m.MinStrength;  )
			{
				this.logInfo("BRO " + bro.getName() + " Min strength < m.MinStrength : " + stats.Strength);
			}

			this.m.Stats = this.Math.floor(stats.Strength);
			candidates.push(bro);
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Candidates = candidates;
		this.m.Score = 9999 + this.m.Stats * 0.1;

		this.m.isValidForEncounter = this.m.Score > 0 && this.Time.getVirtualTimeF() > this.m.CooldownUntil;
		this.m.Score = 0; // this disables event from happening normally
	}

	function onPrepare()
	{
		this.m.Flags = this.new("scripts/tools/tag_collection");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"chosen",
			this.m.Champion != null ? this.m.Champion.getName() : ""
		]);
		_vars.push([
			"enemyname",
			this.m.Flags != null ? this.m.Flags.get("EnemyChampionName") : ""
		]);
	}

	function onDetermineStartScreen()
	{
		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y > this.World.getMapSize().Y * 0.7)
			return "A2";
		return "A2";
	}

	function onClear()
	{
		this.m.Stats = null;
		this.m.Champion = null;
		this.m.MinStrength = null;
		this.m.Perk = null;
		this.m.ValidTypes = null;
		foreach (bro in this.m.WasInReserves)
		{
			bro.setInReserves(true);
		}

		this.m.WasInReserves.clear();
	}

});
