::mods_hookExactClass("contracts/contracts/slave_uprising_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Slave Uprising";
		this.m.DescriptionTemplates = [
			"Some of the indebted slaves have uprisen, casting off their shackles! The Viziers desire a swift and cruel response.",
			"The rebel slaves are weak and malnourished, there will be no glory in this action.",
			"After years of cruelty, some of the slaves are rebelling. Help crush this uprising before it spreads.",
			"The desert skies darken with the smoke of rebellion. Restore law and order with brutal sellsword efficiency.",
			"Some of the indebted have cast off their chains in defiance. Ensure the revolution is short-lived.",
			"The Viziers desire you to make an example of some striking workers. A very violent example.",
		];
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				s.end <- function ()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local r = this.Math.rand(1, 100);

					if (r <= 20)
					{
						this.Flags.set("IsOutlaws", true);
						this.Contract.m.Destination.setActive(false);
						this.Contract.m.Destination.spawnFireAndSmoke();
					}
					else if (r <= 40)
					{
						this.Flags.set("IsSpartacus", true);
					}
					else if (r <= 60)
					{
						this.Flags.set("IsFleeing", true);
					}
					else
					{
						this.Flags.set("IsFightingBack", true);
					}

					this.Contract.setScreen("Overview");

					if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves")
					{
						local brothers = this.World.getPlayerRoster().getAll();
						foreach( bro in brothers )
						{
							if (bro.getBackground().getID() == "background.slave")
							{
								bro.worsenMood(3.0, "You took a contract to put down a slave uprising");
							}
						}
					}
					this.World.Contracts.setActiveContract(this.Contract);
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
			if (s.ID == "FightingBack1")
			{
				s.Text = "[img]gfx/ui/events/event_71.png[/img]{The slaves at %location% see you coming and you hope the presence of your weapons will help deter them from continuing whatever freedom seeking they\'ve undertaken. Shockingly, they do not lay down their arms but merely come together to stand against you. They are a crude lot, an arrangement of those whom enforced labor and recruitment has put the number on. | You find the indebted and they stare back with a very clear understanding of why you are there. The arrangement of participants, yourself armed to the teeth, coming by way of town, the indebted, armed with whatever they scavenged, far from their chains. They are a motley, sad assembly, but you know well that whatever they lack in weaponry they more than make up for in desire. A taste of freedom is nothing if not a sharpening effect. | As described, the indebted have taken over the %location% and armed themselves with whatever they could find. Upon seeing you, they hurry to some notion of formation, but they lack training, discipline, food, and much else. What they have, though, is no desire to return to whence they came which can be as sharp and dangerous a steel as any.}";
				s.Options = [
					{
						Text = "Destroy them!",
						function getResult()
						{
							local tile = this.World.State.getPlayer().getTile();
							local p = this.Const.Tactical.CombatInfo.getClone();
							p.Music = this.Const.Music.OrientalBanditTracks;
							p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
							p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
							p.LocationTemplate.Template[0] = "tactical.desert_camp";
							p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
							p.LocationTemplate.CutDownTrees = true;
							p.Tile = tile;
							p.CombatID = "SlaveUprisingContract";
							p.TerrainTemplate = "tactical.desert";
							p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
							p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
							this.Const.World.Common.addHostileUnitsToCombat(p.Entities, this.Const.World.Spawn.NomadRaiders, 30 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
							this.Const.World.Common.addHostileUnitsToCombat(p.Entities, this.Const.World.Spawn.Slaves, 55 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
							this.World.Contracts.startScriptedCombat(p, false, true, true);
							return 0;
						}

					}
				]
			}
			if (s.ID == "Outlaws1")
			{
				s.start <- function ()
				{
					local cityTile = this.Contract.m.Home.getTile();
					local nearest_nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(cityTile);
					local tile = this.Contract.getTileToSpawnLocation(this.Contract.m.Home.getTile(), 9, 15);
					local party = this.World.FactionManager.getFaction(nearest_nomads.getFaction()).spawnHostileEntity(tile, "Indebted", false, this.Const.World.Spawn.NomadRaiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("A group of indebted that turned to banditry.");
					party.setFootprintType(this.Const.World.FootprintsType.Nomads);
					party.getSprite("banner").setBrush(nearest_nomads.getBanner());
					party.getSprite("body").setBrush("figure_nomad_03");
					this.Contract.m.UnitsSpawned.push(party);
					this.Contract.m.Target = this.WeakTableRef(party);
					party.setVisibleInFogOfWar(true);
					party.setImportant(true);
					party.setDiscovered(true);
					party.setAttackableByAI(false);
					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local roam = this.new("scripts/ai/world/orders/roam_order");
					roam.setPivot(this.Contract.m.Home);
					roam.setMinRange(8);
					roam.setMaxRange(12);
					roam.setAllTerrainAvailable();
					roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
					roam.setTerrain(this.Const.World.TerrainType.Shore, false);
					roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
					c.addOrder(roam);
				}
			}
			if (s.ID == "Spartacus3")
			{
				s.Options = [
					{
						Text = "To Arms!",
						function getResult()
						{
							local tile = this.World.State.getPlayer().getTile();
							local p = this.Const.Tactical.CombatInfo.getClone();
							p.Music = this.Const.Music.OrientalBanditTracks;
							p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
							p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
							p.LocationTemplate.Template[0] = "tactical.desert_camp";
							p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
							p.LocationTemplate.CutDownTrees = true;
							p.Tile = tile;
							p.CombatID = "SlaveUprisingContract";
							p.TerrainTemplate = "tactical.desert";
							p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
							p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
							this.Const.World.Common.addHostileUnitsToCombat(p.Entities, this.Const.World.Spawn.NomadRaiders, 30 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
							this.Const.World.Common.addHostileUnitsToCombat(p.Entities, this.Const.World.Spawn.Slaves, 55 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
							this.World.Contracts.startScriptedCombat(p, false, true, true);
							return 0;
						}

					}
				]
			}
			if (s.ID == "Fleeing1")
			{
				s.start <- function ()
				{
					local cityTile = this.Contract.m.Home.getTile();
					local nearest_nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(cityTile);
					local tile = this.Contract.getTileToSpawnLocation(this.Contract.m.Home.getTile(), 9, 15);
					local party = this.World.FactionManager.getFaction(nearest_nomads.getFaction()).spawnHostileEntity(tile, "Indebted", false, this.Const.World.Spawn.Slaves, 90 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("A group of indebted.");
					party.setFootprintType(this.Const.World.FootprintsType.Nomads);
					party.getSprite("banner").setBrush("banner_deserters");
					this.Contract.m.UnitsSpawned.push(party);
					this.Contract.m.Target = this.WeakTableRef(party);
					party.setVisibleInFogOfWar(true);
					party.setImportant(true);
					party.setDiscovered(true);
					party.setAttackableByAI(false);
					party.setFootprintSizeOverride(0.75);
					local c = party.getController();
					local randomVillage;
					local northernmostY = 0;

					for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
					{
						local v = this.World.EntityManager.getSettlements()[i];

						if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
						{
							northernmostY = v.getTile().SquareCoords.Y;
							randomVillage = v;
						}
					}

					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(randomVillage.getTile());
					c.addOrder(move);
					local wait = this.new("scripts/ai/world/orders/wait_order");
					wait.setTime(9000.0);
					c.addOrder(wait);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Destination.getTile(), party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Nomads, 0.75);
				}
			}
		}
	}

	o.onClear = function ()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnEnterCallback(null);
			}

			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
				this.m.Target.setVisibleInFogOfWar(false);
				this.m.Target.setImportant(true);
				this.m.Target.setAttackableByAI(true);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(3);
			}
		}

		// Transfer any remaining units from dummy faction to nomads (in case spawnHostileEntity had to use the dummy faction)
		::World.FactionManager.getDummyFaction().reset();
	}
});
