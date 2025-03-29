::mods_hookExactClass("factions/actions/send_supplies_action", function(o)
{
	o.m.Dest <- null;
	o.m.IsSendingAid <- false;

	o.onUpdate = function ( _faction )
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (!_faction.isReadyToSpawnUnit())
		{
			return;
		}

		local starts = [];
		local dests = [];
		local data = this.getTownNeedHelp(_faction);

		// send aid to poor town
		if (!_faction.getFlags().get("SentSupplyAid") && // last time wasn't to send aid
			data.Poor.len() > 0 && data.Forts.len() > 0)  // must have fort and poor town
		{
			starts.extend(data.Forts);
			dests.extend(data.Poor);
			this.m.IsSendingAid = true;
		}
		else if (data.Forts.len() > 0)
		{
			// ask a fort to send supply to another fort
			if (data.Forts.len() >= 2 && this.Math.rand(1, 100) <= 50)
			{
				starts.push(data.Forts.remove(this.Math.rand(0, data.Forts.len() - 1)));
				dests.extend(data.Forts);
			}
			// ask small town to send supply to big town
			else
			{
				dests.extend(data.Forts);

				foreach( s in _faction.getSettlements() )
				{
					if (s.isIsolatedFromRoads())
						continue;

					if (!s.isMilitary() && !(s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF()))
						starts.push(s);
				}
			}
		}

		if (starts.len() == 0 || dests.len() == 0)
			return;

		this.m.Start = ::MSU.Array.rand(starts);
		this.m.Dest = ::MSU.Array.rand(dests);

		if (this.m.Start.isConnectedToByRoads(this.m.Dest))
		{
			this.m.Score = 5 + (this.m.IsSendingAid ? 1 : 0);
			return;
		}

		this.m.Start = null;
		this.m.Dest = null;
	}

	o.onClear = function ()
	{
		this.m.IsSendingAid = false;
		this.m.Start = null;
		this.m.Dest = null;
	}

	o.getTownNeedHelp <- function ( _faction )
	{
		local ret = {Poor = [], Forts = []};

		foreach( s in _faction.getSettlements() )
		{
			if (s.isIsolatedFromRoads())
				continue;

			if (s.isMilitary()) {
				ret.Forts.push(s);
				continue;
			}

			if (s.getWealth() > 33)
				continue;

			ret.Poor.push(s);
		}

		return ret;
	}

	o.getReputationToDifficultyLightMult <- function ()
	{
		return this.faction_action.getReputationToDifficultyLightMult() * (this.World.FactionManager.isCivilWar() ? 1.1 : 1.0);
	}

	o.getResourcesForParty <- function ( _settlement, _faction )
	{
		if (_settlement == null) return this.Math.rand(100, 200) * this.getReputationToDifficultyLightMult();

		return (this.Math.rand(83, 127) + this.Math.round(0.11 * ::Math.max(1, _settlement.getResources()))) * this.getReputationToDifficultyLightMult();
	}

	o.convertBudgetToMult <- function ( _budget )
	{
		if (_budget == 0)
			return 1.0;

		return 1.0 + this.Math.floor(_budget / 900) * 0.01;
	}

	o.pickSpawnList <- function ( _settlement, _faction )
	{
		switch(::Math.rand(1, 4))
		{
		case 1:
			return this.Const.World.Spawn.Mercenaries;

		case 2:
			return this.Const.World.Spawn.MixedNobleCaravan;

		default:
			return this.Const.World.Spawn.NobleCaravan;
		}
	}

	o.addLoot <- function ( _party )
	{
		switch(::Math.rand(1, 3))
		{
		case 1:
			_party.getLoot().ArmorParts = this.Math.rand(15, 30);
			break;

		case 2:
			_party.getLoot().Medicine = this.Math.rand(20, 40);
			break;

		default:
			_party.getLoot().Ammo = this.Math.rand(75, 150);
		}

		_party.getLoot().Money = this.Math.floor(this.Math.rand(0, 100) * this.Math.rand(100, 200) * 0.01);
	}

	o.addToPartyInventory <- function ( _party )
	{
		switch(::Math.rand(1, 4))
		{
		case 1:
			_party.addToInventory("supplies/bread_item");
			break;

		case 2:
			_party.addToInventory("supplies/roots_and_berries_item");
			break;

		case 3:
			_party.addToInventory("supplies/dried_fruits_item");
			break;

		default:
			_party.addToInventory("supplies/ground_grains_item");
		}
	}

	o.afterSpawnCaravan <- function (_party)
	{
	}

	o.onExecute = function ( _faction )
	{
		local budget = !::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue() ? 0 : ::Const.World.Common.WorldEconomy.Trade.calculateTradingBudget(this.m.Start);

		if (!this.m.Start.isMilitary() && this.m.Start.getSize() < 3)
			budget *= 1.5;

		local mult = this.convertBudgetToMult(budget);
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Supply Caravan", false, this.pickSpawnList(this.m.Start, _faction), this.getResourcesForParty(this.m.Start, _faction) * mult);
		party.getSprite("body").setBrush(this.Const.World.Spawn.NobleCaravan.Body);
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		this.addLoot(party);

		// yes world economy
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			::Const.World.Common.WorldEconomy.Trade.setupTrade(party, this.m.Start, this.m.Dest, budget);
		}
		// no world economy
		else
		{
			this.addToPartyInventory(party);
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);

		local unload = this.new("scripts/ai/world/orders/unload_order");
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(unload);
		c.addOrder(despawn);

		this.afterSpawnCaravan(party);

		// mark if this is sending aid
		_faction.getFlags().set("SentSupplyAid", this.m.IsSendingAid);
	}
});
