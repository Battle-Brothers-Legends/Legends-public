::mods_hookExactClass("entity/world/party", function(o)
{
	o.m.StashInventory <- false;

	o.getStashInventory <- function ()
	{
		return this.m.StashInventory;
	}

	o.setOrigin <- function ( _origin )
	{
		this.getFlags().set("CaravanOrigin", _origin.getID());
	}

	o.getOrigin <- function ()
	{
		return this.getFlags().has("CaravanOrigin") ? this.World.getEntityByID(this.getFlags().get("CaravanOrigin")) : null;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();

		local f = this.World.FactionManager.getFaction(this.getFaction());

		if (this.getFlags().has("CaravanOrigin") && f != null)
		{
			local town = this.World.getEntityByID(this.getFlags().get("CaravanOrigin"));

			if (town != null)
			{
				ret.push({
					id = 50,
					type = "hint",
					icon = f.getUIBanner(),
					text = "A caravan from " + town.getName()
				});
			}
		}

		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue() && this.World.Assets.m.IsBrigand && this.m.Flags.get("IsCaravan"))
		{
			local inv = this.getStashInventory().getItems();

			if (inv.len() == 0)
			{
				ret.push({
					id = 51,
					type = "text",
					text = "[color=%negative%][u]Inventory is empty[/u][/color]"
				});
			}
			else
			{
				local num = ::Math.min(inv.len(), ::Const.World.Common.WorldEconomy.Trade.AmountOfLeakedCaravanInventoryInfo);

				ret.push({
					id = 51,
					type = "text",
					text = "[u]Transporting:[/u]"
				});

				for (local i = 0; i < num; ++i)
				{
					ret.push({
						id = 52 + i,
						type = "text",
						icon = "ui/items/" + inv[i].getIcon(),
						text = inv[i].getName()
					});
				}

				if (inv.len() > ::Const.World.Common.WorldEconomy.Trade.AmountOfLeakedCaravanInventoryInfo)
				{
					ret.push({
						id = 53 + num,
						type = "text",
						text = "And " + (inv.len() - ::Const.World.Common.WorldEconomy.Trade.AmountOfLeakedCaravanInventoryInfo) + " more item(s)"
					});
				}
			}
		}

		if (this.Const.LegendMod.DebugMode)
		{
			ret.extend([
				{
					id = 6,
					type = "hint",
					text = "Resources: " + this.getResources()
				},
				{
					id = 6,
					type = "hint",
					text = "Goods: " + this.getInventory().len()
				}
			]);
		}

		return ret;
	}

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.StashInventory = this.new("scripts/items/stash_container");
		this.m.StashInventory.setResizable(true);
		this.m.StashInventory.setID("caravan");
	}

	o.onUpdate = function ()
	{
		this.world_entity.onUpdate();
		local delta = this.Math.maxf(0.0, this.Time.getVirtualTimeF() - this.m.LastUpdateTime);
		this.m.LastUpdateTime = this.Time.getVirtualTimeF();

		if (this.isInCombat())
		{
			this.setOrders("Fighting");
			return;
		}

		if (this.m.StunTime > this.Time.getVirtualTimeF())
		{
			return;
		}

		if (this.m.Controller != null)
		{
			this.m.Controller.think();
		}

		if (this.m.Flags.get("IsAlps"))
		{
			this.m.IsLeavingFootprints = false;

			if (this.World.getTime().IsDaytime)
			{
				this.m.VisibilityMult = 0.0;
				this.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			}
			else
			{
				this.m.VisibilityMult = 1.0;
				this.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
			}
		}

		if (this.m.Path != null)
		{
			if (this.m.Path.isAtWaypoint(this.getPos()))
			{
				this.m.Path.pop();

				if (this.m.Path.isEmpty())
				{
					this.m.Path = null;
					this.m.Destination = null;
				}
			}

			if (this.m.Path != null)
			{
				this.m.Destination = this.World.tileToWorld(this.m.Path.getCurrent());
			}
		}

		if (this.m.Destination != null)
		{
			if (this.m.IsMirrored)
			{
				if (this.getSprite("bodyUp").HasBrush)
				{
					if (this.m.Destination.Y < this.getPos().Y)
					{
						this.getSprite("bodyUp").Visible = false;
						this.getSprite("body").Visible = true;
					}
					else
					{
						this.getSprite("bodyUp").setHorizontalFlipping(this.m.Destination.X < this.getPos().X);
						this.getSprite("bodyUp").Visible = true;
						this.getSprite("body").Visible = false;
					}
				}

				this.getSprite("body").setHorizontalFlipping(this.m.Destination.X < this.getPos().X);
			}

			local myTile = this.getTile();
			local speed = this.m.BaseMovementSpeed;

			local terrainTable = this.Const.World.TerrainTypeSpeedMult;
			local wheelMaintenance = 0;
			if (this.getFaction() == this.Const.Faction.Player)
			{
				local tTable = [];
				tTable.resize(terrainTable.len(), 0);
				for (local i=0; i < terrainTable.len() ; ++i)
				{
					tTable[i] += this.Const.World.TerrainTypeSpeedMult[i];
				}
				local broTable = [];
				foreach( bro in this.World.getPlayerRoster().getAll() )
				{
					broTable = bro.getBackground().getModifiers().Terrain;
					if (broTable == null)
					{
						continue
					}
					for (local i = 0; i < broTable.len(); ++i)
					{
						tTable[i] += broTable[i];
					}
					if (bro.getSkills().hasPerk(::Legends.Perk.LegendWheelMaintenance))
					{
						wheelMaintenance += 1;
					}
				}
				if (this.World.Retinue.hasFollower("follower.scout"))
				{
					for (local i = 0; i < terrainTable.len(); ++i)
					{
						if (this.Const.World.TerrainTypeSpeedMult[i] <= 0.65 && this.Const.World.TerrainTypeSpeedMult[i] > 0.0)
						{
							tTable[i] *= (this.Const.World.TerrainTypeSpeedMult[i] + 0.15) / this.Const.World.TerrainTypeSpeedMult[i];
						}
					}
				}

				if (wheelMaintenance > 0)
				{
					for (local i = 0; i < terrainTable.len(); ++i)
					{
						tTable[i] *= (this.Const.World.TerrainTypeSpeedMult[i] + (0.05 * wheelMaintenance.tofloat())) / this.Const.World.TerrainTypeSpeedMult[i];
					}
				}

				terrainTable = tTable;
			}

			speed = speed * (1.0 - this.Math.minf(0.5, this.m.Troops.len() * this.Const.World.MovementSettings.SlowDownPartyPerTroop));
			speed = speed * this.Const.World.MovementSettings.GlobalMult;
			if (!this.isIgnoringCollision())
			{
				if (myTile.HasRoad)
				{
					speed = speed * this.Math.maxf(terrainTable[myTile.Type] * this.Const.World.MovementSettings.RoadMult, 1.0);
				}
				else
				{
					speed = speed * terrainTable[myTile.Type];
				}

				if (this.m.IsPlayer)
				{
					speed = speed * this.World.Assets.getTerrainTypeSpeedMult(myTile.Type);
				}
			}

			if (this.m.IsSlowerAtNight && !this.World.isDaytime())
			{
				speed = speed * this.Const.World.MovementSettings.NighttimeMult;
			}

			if (myTile.HasRiver)
			{
				speed = speed * this.Const.World.MovementSettings.RiverMult;
			}

			if (this.getFaction() != this.Const.Faction.Player)
			{
				speed = speed * this.Const.World.MovementSettings.NotPlayerMult;
			}

			speed = speed * delta;

			if (this.m.IsLeavingFootprints && !myTile.IsOccupied)
			{
				if (this.Time.getVirtualTimeF() - this.m.LastFootprintTime >= 1.0)
				{
					local scale;

					if (this.m.FootprintSizeOverride == 0.0)
					{
						scale = this.Math.minf(1.0, this.Math.maxf(0.4, this.m.Troops.len() * 0.05));
					}
					else
					{
						scale = this.m.FootprintSizeOverride;
					}

					this.World.spawnFootprint(this.createVec(this.getPos().X - 5, this.getPos().Y - 15), this.m.Footprints[this.getDirection8To(this.m.Destination)] + "_0" + this.m.LastFootprintType, scale, this.m.FootprintSizeOverride != 0.0 ? 30.0 : 0.0, this.World.Assets.getFootprintVision(), this.m.FootprintType);
					this.m.LastFootprintTime = this.Time.getVirtualTimeF();
					this.m.LastFootprintType = this.m.LastFootprintType == 1 ? 2 : 1;
				}
			}

			if (!this.move(this.m.Destination, speed))
			{
				this.m.Destination = null;
			}
		}

		if (this.m.IdleSoundsIndex != 0 && this.m.LastIdleSound + 10.0 < this.Time.getRealTimeF() && this.Math.rand(1, 100) <= 5 && this.isVisibleToEntity(this.World.State.getPlayer(), 500))
		{
			this.m.LastIdleSound = this.Time.getRealTimeF();
			this.Sound.play(this.Const.SoundPartyAmbience[this.m.IdleSoundsIndex][this.Math.rand(0, this.Const.SoundPartyAmbience[this.m.IdleSoundsIndex].len() - 1)], this.Const.Sound.Volume.Ambience, this.getPos());
		}
	}

	o.onCombatLost = function ()
	{
		// World Economy: Track caravan destroyed
		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue() && this.getFlags().has("CaravanInvestment"))
		{
			local origin = this.getOrigin();
			if (!::MSU.isNull(origin))
			{
				local destinationID = this.getFlags().get("CaravanDestinationID");
				if (destinationID == null)
				{
					::logWarning("CaravanDestinationID is null for a recently destroyed caravan. This should only happen for caravans loaded from an older save.");
				}
				local investment = this.getFlags().get("CaravanInvestment");
				local profit = this.getFlags().get("CaravanProfit");
				local inv = this.getStashInventory().getItems();
				local coords = this.getTile().Coords;
				local caravanHistoryData = ::Const.World.Common.WorldEconomy.Trade.createCaravanHistoryData(::Const.World.Common.WorldEconomy.Trade.CaravanHistoryType.Destroyed, origin.getID(), destinationID, investment, profit, inv, [coords.X, coords.Y]);
				origin.updateCaravanSentHistory(caravanHistoryData);
			}
		}

		this.World.EntityManager.onWorldEntityDestroyed(this, false);
		this.world_entity.onCombatLost();
	}

	o.onDiscovered = function ()
	{
		this.world_entity.onDiscovered();
		// temporarily removed until we figure out what's going on with the caravan hunter retinue - Breaky 23.10.2024
		// local playerRoster = this.World.getPlayerRoster().getAll();
		// local lookout = 0;

		// if(!World.State.isPaused() && isAttackable() && getFaction() != 0 && !isAlliedWithPlayer() && getTile().getDistanceTo(World.State.getPlayer().getTile()) <= 12)
		// {
		// 	foreach( bro in playerRoster )
		// 	{
		// 		if (bro.getCampAssignment() != this.Const.World.CampBuildings.Scout)
		// 			{
		// 				if (bro.getSkills().hasPerk(::Legends.Perk.LegendLookout)
		// 					{
		// 					lookout += 1;
		// 					}
		// 			}
		// 	}
		// 	if (lookout > 0)
		// 	{
		// 		World.State.setPause(true);
		// 	}
		// }
	}

	o.addToInventory <- function ( _i )
	{
		if (typeof _i == "string") this.world_entity.addToInventory(_i);
		else this.m.StashInventory.add(_i);
	}

	o.clearInventory <- function ()
	{
		this.world_entity.clearInventory();
		this.m.StashInventory.clear();
	}

	o.onDropLootForPlayer = function ( _lootTable )
	{
		this.world_entity.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.m.Loot.Money, _lootTable);
		this.dropAmmo(this.m.Loot.Ammo, _lootTable);
		this.dropMedicine(this.m.Loot.Medicine, _lootTable);
		this.dropArmorParts(this.m.Loot.ArmorParts, _lootTable);

		_lootTable.extend(this.m.StashInventory.getItems());

		if (this.m.Flags.get("IsCaravan"))
		{
			this.World.Statistics.getFlags().increment("CaravansRaided");

			local faction = ::World.FactionManager.getFaction(this.getFaction());
			local faction_flags = faction.getFlags();
			local fcr = faction_flags.getAsInt("FactionsCaravansRaided");
			faction_flags.set("FactionsCaravansRaided", fcr + 1);
		}
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize( _out );
		this.m.StashInventory.onSerialize(_out);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize( _in );
		this.m.StashInventory.onDeserialize(_in);
	}
});
