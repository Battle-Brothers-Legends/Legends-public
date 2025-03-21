::mods_hookExactClass("contracts/contracts/free_greenskin_prisoners_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Rescue Mission";
		this.m.DescriptionTemplates = [
			"Sometimes the greenskins take prisoners for cruel sport. Time is of the essence, for greenskins are easily bored.",
			"The cruelty of greenskins knows no bounds, as they revel in the suffering of their victims, delighting in their agony.",
			"Those taken captive by greenskins often endure unspeakable horrors, their bodies and spirits broken by relentless cruelty.",
			"Prisoners of the greenskins are stripped of dignity and humanity, reduced to little more than chattel in their eyes.",
			"Nobody has volunteered for this noble cause, as nobody wants to die in an orc slave-pit.",
			"Unwilling to risk their own men on a futile rescue mission, the nobility is more than happy to risk yours instead.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = "Rescue Mission";
			}
			if (s.ID == "Battlesite2")
			{
				foreach (option in s.Options)
				{
					option.getResult <- function()
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						local playerTile = this.World.State.getPlayer().getTile();
						local nearest_goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(playerTile);
						local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(playerTile);
						local camp;

						if(nearest_goblins == null)
						{
							camp = nearest_orcs;
						}
						else if (nearest_orcs == null)
						{
							camp = nearest_goblins;
						}
						else
						{
							if (nearest_goblins.getTile().getDistanceTo(playerTile) <= nearest_orcs.getTile().getDistanceTo(playerTile))
							{
								camp = nearest_goblins;
							}
							else
							{
								camp = nearest_orcs;
							}
						}


						if (this.Flags.get("IsEnemyParty"))
						{
							local tile = this.Contract.getTileToSpawnLocation(playerTile, 10, 15);
							local party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHorde, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
							party.getSprite("banner").setBrush(camp.getBanner());
							party.setDescription("A horde of greenskins marching to war.");
							party.setFootprintType(this.Const.World.FootprintsType.Orcs);
							this.Contract.m.UnitsSpawned.push(party);
							party.getLoot().ArmorParts = this.Math.rand(0, 25);
							party.getLoot().Ammo = this.Math.rand(0, 10);
							party.addToInventory("supplies/strange_meat_item");
							this.Contract.m.Destination = this.WeakTableRef(party);
							party.setAttackableByAI(false);
							party.setFootprintSizeOverride(0.75);
							local c = party.getController();
							c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
							local wait = this.new("scripts/ai/world/orders/wait_order");
							wait.setTime(15.0);
							c.addOrder(wait);
							local roam = this.new("scripts/ai/world/orders/roam_order");
							roam.setPivot(camp);
							roam.setMinRange(5);
							roam.setMaxRange(10);
							roam.setAllTerrainAvailable();
							roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
							roam.setTerrain(this.Const.World.TerrainType.Shore, false);
							roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
							c.addOrder(roam);
						}
						else
						{
							this.Contract.m.Destination = this.WeakTableRef(camp);
							camp.clearTroops();

							if (this.Flags.get("IsEmptyCamp"))
							{
								camp.setResources(0);
								this.Contract.m.Destination.setLootScaleBasedOnResources(0);
							}
							else
							{
								this.Contract.m.Destination.setLootScaleBasedOnResources(120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

								if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
								{
									this.Contract.m.Destination.getLoot().clear();
								}

								camp.setResources(this.Math.min(camp.getResources(), 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
								this.Contract.addUnitsToEntity(camp, this.Const.World.Spawn.GreenskinHorde, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}
						}

						this.Const.World.Common.addFootprintsFromTo(playerTile, this.Contract.m.Destination.getTile(), this.Const.OrcFootprints, this.Const.World.FootprintsType.Orcs, 0.75, 10.0);
						this.Contract.setState("Pursuit");
						return 0;
					}
				}
			}
			if (s.ID == "Scouts")
			{
				foreach (option in s.Options)
				{
					option.getResult <- function()
					{
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "Scouts";
						p.Music = this.Const.Music.GoblinsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						local nearest_goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(tile);
						local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(tile);
						local camp;

						if(nearest_goblins == null)
						{
							camp = nearest_orcs;
						}
						else if (nearest_orcs == null)
						{
							camp = nearest_goblins;
						}
						else
						{
							if (nearest_goblins.getTile().getDistanceTo(tile) <= nearest_orcs.getTile().getDistanceTo(tile))
							{
								camp = nearest_goblins;
							}
							else
							{
								camp = nearest_orcs;
							}
						}

						p.EnemyBanners.push(camp.getBanner());
						p.Entities = [];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.GreenskinHorde, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}
				}
			}
			if (s.ID == "LuckyFind")
			{
				s.start <- function ()
				{
					local item;
					local r = this.Math.rand(1, 12);

					if (r == 1)
					{
						item = this.new("scripts/items/weapons/greatsword");
					}
					else if (r == 2)
					{
						item = this.new("scripts/items/weapons/greataxe");
					}
					else if (r == 3)
					{
						item = this.new("scripts/items/weapons/billhook");
					}
					else if (r == 4)
					{
						item = this.new("scripts/items/weapons/noble_sword");
					}
					else if (r == 5)
					{
						item = this.new("scripts/items/weapons/warbrand");
					}
					else if (r == 6)
					{
						item = this.new("scripts/items/weapons/two_handed_hammer");
					}
					else if (r == 7)
					{
						item = this.new("scripts/items/weapons/greenskins/orc_axe_2h");
					}
					else if (r == 8)
					{
						item = this.new("scripts/items/weapons/greenskins/orc_cleaver");
					}
					else if (r == 9)
					{
						item = this.new("scripts/items/weapons/named/named_orc_cleaver");
					}
					else if (r == 10)
					{
						item = this.new("scripts/items/weapons/named/named_orc_axe");
					}
					else if (r == 9)
					{
						item = this.new("scripts/items/weapons/named/legend_named_orc_axe_2h");
					}
					else if (r == 10)
					{
						item = this.new("scripts/items/weapons/named/legend_named_orc_flail_2h");
					}

					this.World.Assets.getStash().makeEmptySlots(1);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
		}
	}
});
