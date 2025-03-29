this.legend_mummy_enter_event <- this.inherit("scripts/events/event", {
	m = {
		LootTable = [
			"loot/white_pearls_item",
			"loot/jeweled_crown_item",
			"loot/gemstones_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"misc/legend_ancient_scroll_item",
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools"
		]
	},
	function create()
	{
		this.m.ID = "event.location.legend_mummy_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_173.png[/img]{As the sand swallows your feet you scramble to the zenith of the next sand dune, the crest gives way to more of the same — the sands part between the hypnotising peaks between the valleys, occasionally sprinkled with columns, collapsed entrances and skeletons human and animal alike. Further afield you see the apex of a more rigid structure, the faded motifs strike you first, a small smatter of colour in an otherwise desolate landscape.\n\n As you wade closer the colours become more vivid; teals, maroons and jaundiced yellows all wax and wane in stripes, seemingly telling a tale nobody living can still recant. The air is warm, but stale — time seems to have affected this place differently than anywhere else you have seen so far. \n\n Small pots and urns make mickles around the entryways and columns, this place is a shining beacon for graverobbers but remains untouched and orderly.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "More treasure for us then!",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Let\'s not disturb what rests here.",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

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
			Text = "[img]gfx/ui/events/event_89.png[/img]{As you slowly pace inside the main monolith the temperature dramatically drops to a more comfortable level. The shade makes your skin writhe with comfort from the heat outside. \n\n The room is mostly blank, the only distinguishing feature aside from the inscribed walls are stone caskets of varying quality — some depict great battles, a figure whipping servants and others who are partaking in a form of ritual that has been purposely defaced with a weapon or chisel. Others remain blank — either not important enough to be worth more time of the craftsmen or simply unfinished. }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What was that noise?",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_89.png[/img]{As you inch closer you begin to realise that fingers have smudged and flailed against the inside enclosure of the sarcophagus, some caskets have been opened from inside, while others had outside assistance. \n\n However, all of them are empty. \n\n The air begins to feel warm again suddenly, there is more in this chamber than you suspected. A figure of a man catches your eye, it opens its mouth as it plods from the darkness. \n\n Words do not come, only a trickle of sand and skin.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The dead are upon us",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						local p = this.Const.Tactical.CombatInfo.getClone();
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.CombatID = "Mastaba";
						p.TerrainTemplate = "tactical.sinkhole";
						p.LocationTemplate.Template[0] = "tactical.sunken_library";
						p.Music = this.Const.Music.UndeadTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
						p.IsWithoutAmbience = true;
						p.Entities = [];

						for( local i = 0; i < 4; ++i )
						{
							p.Entities.push(clone this.Const.World.Spawn.Troops.LegendMummyHeavy);
						}
						
						for( local i = 0; i < 4; ++i )
						{
							p.Entities.push(clone this.Const.World.Spawn.Troops.LegendMummyPriest);
						}

						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID();

						for( local i = 0; i < p.Entities.len(); ++i )
						{
							p.Entities[i].Faction <- f;
						}

						p.BeforeDeploymentCallback = function ()
						{
							local light = 4;
							local light_tiles = [];
							do
							{
								local x = this.Math.rand(10, 28);
								local y = this.Math.rand(4, 28);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
									continue
								}

								local skip = false;
								foreach( t in light_tiles )
								{
									if (t.getDistanceTo(tile) <= 5)
									{
										skip = true;
										break;
									}
								}

								if (skip)
								{
									continue
								}

								local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_vampire_lord", tile.Coords);
								e.setFaction(f);
								e.assignRandomEquipment();
								light = --light;
								light_tiles.push(tile);
							}
							while (light > 0);

							local toRise = 3;
							do
							{
								local r = this.Math.rand(0, light_tiles.len() - 1);
								local p = light_tiles[r];

								if (p.SquareCoords.X > 14)
								{
									p.Level = 1;
									toRise = --toRise;
								}

								light_tiles.remove(r);
							}
							while (toRise > 0 && light_tiles.len() > 0);

							local queen = 1;
							do
							{
								local x = this.Math.rand(9, 10);
								local y = this.Math.rand(15, 17);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
									continue
								}

								local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_mummy_queen", tile.Coords);
								e.setFaction(f);
								e.assignRandomEquipment();
								queen = --queen;

							}
							while (queen > 0);

							local treasureHunters = 4;
							do
							{
								local x = this.Math.rand(9, 11);
								local y = this.Math.rand(11, 21);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
									continue
								}

								local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_mummy_medium", tile.Coords);
								e.setFaction(f);
								e.assignRandomEquipment();
								treasureHunters = --treasureHunters;

							}
							while (treasureHunters > 0);

							local medium = 12;
							do
							{
								local x = this.Math.rand(9, 14);
								local y = this.Math.rand(8, 20);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
									continue
								}

								local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_mummy_light", tile.Coords);
								e.setFaction(f);
								e.assignRandomEquipment();
								medium = --medium;
							}
							while (medium > 0);

							local heavy = 4;
							do
							{
								local x = this.Math.rand(12, 14);
								local y = this.Math.rand(12, 26);
								local tile = this.Tactical.getTileSquare(x, y);

								if (!tile.IsEmpty)
								{
									continue
								}

								local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_mummy_heavy", tile.Coords);
								e.setFaction(f);
								e.assignRandomEquipment();
								heavy = --heavy;
							}
							while (heavy > 0);
						};
						p.AfterDeploymentCallback = function ()
						{
							this.Tactical.getWeather().setAmbientLightingPreset(5);
							this.Tactical.getWeather().setAmbientLightingSaturation(0.9);
						};
						_event.addLootToScriptedCombat(p);
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_89.png[/img]{The ancient queen crumbles to ash before you, leaving nothing left in the chamber but sand.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What was that?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/weapons/legendary/legend_mage_swordstaff");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.World.Flags.set("IsMastabaDefeated", true);
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_173.png[/img]The mercenaries run out into the blazing sun again.%SPEECH_ON%Perhaps another time?%SPEECH_OFF%One sellsword says. %randombrother% nods.%SPEECH_ON%Another time, aye. Maybe a time far away from now, when I\'m out retired and farkin\' whoors, then y\'all can dip down into the darkness and go gallivanting with dead wizards. Does that time work for y\'all?%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Perhaps one day...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
	}

	function addLootToScriptedCombat( _properties )
	{
		for (local i = 0; i < ::Math.rand(4, 5); ++i)
		{
			_properties.Loot.push("scripts/items" + ::MSU.Array.rand(m.LootTable));
		}
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

