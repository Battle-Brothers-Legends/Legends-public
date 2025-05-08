::mods_hookExactClass("entity/world/entity_manager", function(o)
{
	o.m.FreeCompanies <- [];
	o.m.NonDefaultFreeCompanies <- [];
	o.m.LastFreeCompanyUpdateTime <- 0;

	local update = o.update;
	o.update = function ()
	{
		update();
		this.manageAIFreeCompanies();
	}

	local clear = o.clear;
	o.clear = function ()
	{
		clear();
		this.m.FreeCompanies = [];
		this.m.NonDefaultFreeCompanies = [];
		this.m.LastFreeCompanyUpdateTime = 0.0;
	}

	o.manageAIFreeCompanies <- function () //we update these at the same time as Mercenaries, for now they mostly just do the same thing Mercenaries do
	{
		local garbage = [];

		foreach( i, fc in this.m.FreeCompanies )
		{
			if (fc.isNull() || !fc.isAlive())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.FreeCompanies.remove(g);
		}

		if (this.m.LastFreeCompanyUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastFreeCompanyUpdateTime = this.Time.getVirtualTimeF();

		local days = this.World.getTime().Days;
		local companies = 0;
		// if (days > 0)
		// 	companies++;
		// if (days > 100)
		// 	companies++;
		// if (days > 175)
		// 	companies++;

		if (companies == 0)
			return;

		if (this.m.FreeCompanies.len() < companies)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local candidates = [];

			foreach( s in this.World.EntityManager.getSettlements() )
			{
				if (s.isIsolated())
				{
					continue;
				}

				if (s.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidates.push(s);
			}

			// local themeSelect = this.Math.rand(0, this.Const.FreeCompanyCoordinationList.len() - 1);
			//just hardcoding themes to be a 1/100 chance of being themed here until i go over this again later, uncomment below if i add another theme before tweaking this
			local themeSelect;
			local themeTable;
			local selectedND = false;
			if (this.Math.rand(0, 199) == 0 && days > 100)
			{
				do {
					themeSelect = this.Math.rand(0, this.Const.FreeCompanyOneTimeList.len() - 1);
				} while ( this.m.NonDefaultFreeCompanies.find(themeSelect) && !( this.m.NonDefaultFreeCompanies.len() == this.Const.FreeCompanyOneTimeList.len() ) );
				if (this.m.NonDefaultFreeCompanies.len() == this.Const.FreeCompanyOneTimeList.len() - 1) //dude it's like 5am and im writing this
				{
					// themeSelect = this.Math.rand(0, this.Const.FreeCompanyCoordinationList.len() - 1); //only go i nhere if we can't select any more nondefaults, it'll break that while loop above too
				}
				else
				{
					this.m.NonDefaultFreeCompanies.push(themeSelect);
					selectedND = true;
				}
			}
			if (selectedND)
			{
				themeTable = this.Const.FreeCompanyOneTimeList[themeSelect]; //array 0 is our "default"/"example" one
			}
			else
			{
				themeTable = this.Const.FreeCompanyCoordinationList[this.Math.rand(0, this.Const.FreeCompanyCoordinationList.len() - 1)];
			}


			local start = candidates[this.Math.rand(0, candidates.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", start.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));

			local description = ("Description" in themeTable) ? themeTable.Description : "A free company, out for their own share of crowns.";
			party.setDescription(description);

			local footprints = ("FootprintsType" in themeTable) ? themeTable.FootprintsType : "Mercenaries";
			party.setFootprintType(this.Const.World.FootprintsType[footprints]);

			party.getFlags().set("IsFreeCompany", true);
			party.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.FreeCompany).getID());

			// local r = this.Math.min(330, 150 + this.World.getTime().Days);
			local spawntype = ("Spawn" in themeTable) ? themeTable.Spawn : "FreeCompany";
			local r = this.World.State.getPlayer().getStrength();
			if (days > 100) r += 50;
			else if (days > 75) r += 30;
			else if (days > 50) r += 10;

			local r = this.Math.rand(r * 0.8, r * 1.5);
			if (days < 25) {
				this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.FreeCompanyLow, r * 0.9);
			}
			else
			{
				this.Const.World.Common.assignTroops(party, this.Const.World.Spawn[spawntype], r); //change this to freecompany spawn later
			}

			if ("UnitOutfits" in themeTable) {
				foreach (troop in party.getTroops()) //this shit is admittedly really slow but I do not care it doesn't get run often enough to need to conserve iterations highly
				{
					foreach (uo in themeTable.UnitOutfits)
					{
						if (troop.ID == uo.Type)
						{
							troop.Outfits <- clone uo.Outfits
						}
					}
					// if ("Outfits" in troop.m)
					// {
					// 	local type = troop.getType();
					// 	foreach (uo in themeTable.UnitOutfits)
					// 	{
					// 		if (uo.Type == type)
					// 		{
					// 			troop.m.Outfits = uo.Outfits;
					// 		}
					// 	}
					// }
				}
			}

			party.getLoot().Money = this.Math.rand(400, 800);
			party.getLoot().ArmorParts = this.Math.rand(10, 30);
			party.getLoot().Medicine = this.Math.rand(5, 15);
			party.getLoot().Ammo = this.Math.rand(10, 50);

			local items =  ("LootTable" in themeTable) ? themeTable.LootTable : this.Const.FreeCompanyDefaultLootTable;


			for( local i = 0; i < 2; i = ++i ) //change to some trade goods, and lower money amount if it picks them
			{
				party.addToInventory(items[this.Math.rand(0, items.len() - 1)]);
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_mercenary_0" + this.Math.rand(1, 2));

			local nameList = clone themeTable.Names;

			while (true)
			{
				if (nameList.len() == 0)
				{
					nameList = clone this.Const.Strings.FreeCompanyNames;
					break;
				}
				local idx = this.Math.rand(0, themeTable.Names.len() - 1);
				local name = nameList[idx];

				if (name == this.World.Assets.getName())
				{
					nameList.remove(idx);
					continue;
				}

				local abort = false;

				foreach( p in this.m.FreeCompanies )
				{
					if (p.getName() == name)
					{
						nameList.remove(idx);
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.setName(name);
				break;
			}

			while (true)
			{
				local banner = this.Const.PlayerBanners[this.Math.rand(0, this.Const.PlayerBanners.len() - 1)];

				if (banner == this.World.Assets.getBanner())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.FreeCompanies )
				{
					if (p.getBanner() == banner)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.getSprite("banner").setBrush(banner);
				break;
			}

			this.m.FreeCompanies.push(this.WeakTableRef(party));
		}
		foreach( fc in this.m.FreeCompanies )
		{
			// this.logInfo("There is an FC called: " + fc.getName())
			fc.updatePlayerRelation();

			if (!fc.getController().hasOrders())
			{
				local candidates = [];

				foreach( s in this.m.Settlements )
				{
					if (!s.isAlive() || s.isIsolated())
					{
						continue;
					}

					if (!s.isAlliedWith(fc))
					{
						continue;
					}

					if (s.getTile().ID == fc.getTile().ID)
					{
						continue;
					}

					candidates.push(s);
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local dest = candidates[this.Math.rand(0, candidates.len() - 1)];
				local c = fc.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(dest.getTile());
				move.setRoadsOnly(false);
				c.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait2);
				local fco = this.new("scripts/ai/world/orders/legend_free_company_order");
				fco.setSettlement(dest);
				c.addOrder(fco);
			}
		}
	}

	o.manageAIMercenaries = function ()
	{
		local garbage = [];

		foreach( i, merc in this.m.Mercenaries )
		{
			if (merc.isNull() || !merc.isAlive())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.Mercenaries.remove(g);
		}

		if (this.m.LastMercUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastMercUpdateTime = this.Time.getVirtualTimeF();

		if (this.m.Mercenaries.len() < 3 || this.World.FactionManager.isCivilWar() && this.m.Mercenaries.len() < 4)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local candidates = [];

			foreach( s in this.World.EntityManager.getSettlements() )
			{
				if (s.isIsolated())
				{
					continue;
				}

				if (s.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidates.push(s);
			}

			local start = candidates[this.Math.rand(0, candidates.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", start.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
			party.setDescription("A free mercenary company travelling the lands and lending their swords to the highest bidder.");
			party.setFootprintType(this.Const.World.FootprintsType.Mercenaries);
			party.getFlags().set("IsMercenaries", true);

			if (start.getFactions().len() == 1)
			{
				party.setFaction(start.getOwner().getID());
			}
			else
			{
				party.setFaction(start.getFactionOfType(this.Const.FactionType.Settlement).getID());
			}

			local r = this.Math.min(330, 150 + this.World.getTime().Days);
			this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.Mercenaries, this.Math.rand(r * 0.8, r));
			party.getLoot().Money = this.Math.rand(300, 600);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 10);
			party.getLoot().Ammo = this.Math.rand(0, 50);

			for( local i = 0; i < 2; i = ++i )
			{
				local r = this.Math.rand(1, 13);

				local loot = [
					"supplies/bread_item",
					"supplies/mead_item",
					"supplies/dried_fruits_item",
					"supplies/beer_item",
					"loot/silver_bowl_item",
					"loot/jeweled_crown_item",
					"loot/ancient_amber_item",
					"loot/webbed_valuables_item",
					"loot/looted_valuables_item",
					"loot/white_pearls_item",
					"loot/rainbow_scale_item",
					"loot/lindwurm_hoard_item",
					"loot/silverware_item",
				];
				party.addToInventory(loot[this.Math.rand(0, loot.len() - 1 )]);
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_mercenary_0" + this.Math.rand(1, 2));

			while (true)
			{
				local name = this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)];

				if (name == this.World.Assets.getName())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getName() == name)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.setName(name);
				break;
			}

			while (true)
			{
				local banner = this.Const.PlayerBanners[this.Math.rand(0, this.Const.PlayerBanners.len() - 1)];

				if (banner == this.World.Assets.getBanner())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getBanner() == banner)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.getSprite("banner").setBrush(banner);
				break;
			}

			this.m.Mercenaries.push(this.WeakTableRef(party));
		}

		foreach( merc in this.m.Mercenaries )
		{
			merc.updatePlayerRelation();

			if (!merc.getController().hasOrders())
			{
				local candidates = [];

				foreach( s in this.m.Settlements )
				{
					if (!s.isAlive() || s.isIsolated())
					{
						continue;
					}

					if (!s.isAlliedWith(merc))
					{
						continue;
					}

					if (s.getTile().ID == merc.getTile().ID)
					{
						continue;
					}

					candidates.push(s);
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local dest = candidates[this.Math.rand(0, candidates.len() - 1)];
				local c = merc.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(dest.getTile());
				move.setRoadsOnly(false);
				c.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait2);
				local mercenary = this.new("scripts/ai/world/orders/mercenary_order");
				mercenary.setSettlement(dest);
				c.addOrder(mercenary);
			}
		}
	}

	o.onSerialize = function ( _out )
	{
		_out.writeI32(this.m.NextSituationID);
		local numMercs = 0;

		foreach( merc in this.m.Mercenaries )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				numMercs = ++numMercs;
			}
		}

		_out.writeU8(numMercs);

		foreach( merc in this.m.Mercenaries )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				_out.writeU32(merc.getID());
			}
		}

		local numMercs = 0;
		foreach( merc in this.m.FreeCompanies )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				numMercs = ++numMercs;
			}
		}

		_out.writeU8(numMercs);

		foreach( merc in this.m.FreeCompanies )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				_out.writeU32(merc.getID());
			}
		}

		_out.writeU8(this.m.NonDefaultFreeCompanies.len());
		foreach(fc in this.m.NonDefaultFreeCompanies)
		{
			_out.writeU8(fc);
		}
	}

	o.onDeserialize = function ( _in )
	{
		this.m.NextSituationID = _in.readI32();
		local numMercs = _in.readU8();

		for( local i = 0; i != numMercs; i = ++i )
		{
			local merc = this.World.getEntityByID(_in.readU32());

			if (merc != null)
			{
				this.m.Mercenaries.push(this.WeakTableRef(merc));
			}
		}

		local numMercs = _in.readU8();

		for( local i = 0; i != numMercs; i = ++i )
		{
			local merc = this.World.getEntityByID(_in.readU32());

			if (merc != null)
			{
				this.m.FreeCompanies.push(this.WeakTableRef(merc));
			}
		}

		local numFC = _in.readU8();
		for (local i = 0; i != numFC; i = ++i)
		{
			this.m.NonDefaultFreeCompanies.push(_in.readU8());
		}

		this.buildRoadAmbushSpots();
	}
});
