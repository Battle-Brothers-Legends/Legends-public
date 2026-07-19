::mods_hookNewObject("entity/world/entity_manager", function ( em )
{
	em.m.Crownlings <- [];
	em.m.LastCrownlingUpdateTime <- 0;
	local manageAIMercenaries = ::mods_getMember(em, "manageAIMercenaries");
	local onSerialize = ::mods_getMember(em, "onSerialize");
	local onDeserialize = ::mods_getMember(em, "onDeserialize");
	::mods_override(em, "manageAIMercenaries", function ()
	{
		manageAIMercenaries();
		local dead = [];

		foreach( index, crownlingParty in this.m.Crownlings )
		{
			if (crownlingParty.isNull() || !crownlingParty.isAlive())
			{
				dead.push(index);
			}
		}

		dead.reverse();

		foreach( crownlingParty in dead )
		{
			this.m.Crownlings.remove(crownlingParty);
		}

		if (this.m.LastCrownlingUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastCrownlingUpdateTime = this.Time.getVirtualTimeF();

		if (this.m.Crownlings.len() < ::BDP.Crownlings.MaxParties || this.World.FactionManager.isHolyWar() && this.m.Crownlings.len() < ::BDP.Crownlings.MaxPartiesHolyWar)
		{
			::logInfo("spawning new party");
			local playerTile = this.World.State.getPlayer().getTile();
			local candidateSettlements = [];

			foreach( settlement in this.World.EntityManager.getSettlements() )
			{
				if (settlement.isIsolated())
				{
					continue;
				}

				if (settlement.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidateSettlements.push(settlement);
			}

			local selectedSettlement = candidateSettlements[this.Math.rand(0, candidateSettlements.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", selectedSettlement.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
			party.setDescription(::BDP.Crownlings.WorldmapDescription);
			party.setFootprintType(this.Const.World.FootprintsType.Mercenaries);
			party.getFlags().set("IsMercenaries", true);
			party.getFlags().set("IsCrownlings", true);

			if (selectedSettlement.getFactions().len() == 1)
			{
				party.setFaction(selectedSettlement.getOwner().getID());
			}
			else
			{
				party.setFaction(selectedSettlement.getFactionOfType(this.Const.FactionType.Settlement).getID());
			}

			local r = this.Math.min(::BDP.Crownlings.MaxPartyResources, 150 + this.World.getTime().Days);
			this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.Crownlings, this.Math.rand(r * 0.8, r), 0);
			party.getLoot().Money = this.Math.rand(300, 600);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 10);
			party.getLoot().Ammo = this.Math.rand(0, 50);

			for( local i = 0; i < 2; i = ++i )
			{
				local r = this.Math.rand(1, 4);
				party.addToInventory(::BDP.Crownlings.FoodLoot[this.Math.rand(0, ::BDP.Crownlings.FoodLoot.len() - 1)]);
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_crownling_0" + this.Math.rand(1, 2));
			local mercList = [];
			mercList.extend(this.m.Crownlings);
			mercList.extend(this.m.Mercenaries);

			while (true)
			{
				local name = ::BDP.Crownlings.CrownlingCompanyNames[this.Math.rand(0, ::BDP.Crownlings.CrownlingCompanyNames.len() - 1)];

				if (name == this.World.Assets.getName())
				{
					continue;
				}

				local abort = false;

				foreach( crownlingParty in mercList )
				{
					if (crownlingParty.getName() == name)
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

				foreach( crownlingParty in mercList )
				{
					if (crownlingParty.getBanner() == banner)
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

			this.m.Crownlings.push(this.WeakTableRef(party));
		}

		foreach( crownlingParty in this.m.Crownlings )
		{
			crownlingParty.updatePlayerRelation();

			if (!crownlingParty.getController().hasOrders())
			{
				local candidateSettlements = [];

				foreach( settlement in this.m.Settlements )
				{
					if (!settlement.isAlive() || settlement.isIsolated())
					{
						continue;
					}

					if (!settlement.isAlliedWith(crownlingParty))
					{
						continue;
					}

					if (settlement.getTile().ID == crownlingParty.getTile().ID)
					{
						continue;
					}

					candidateSettlements.push(settlement);
				}

				if (candidateSettlements.len() == 0)
				{
					continue;
				}

				local destination = candidateSettlements[this.Math.rand(0, candidateSettlements.len() - 1)];
				local controller = crownlingParty.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(this.Math.rand(10, 60) * 1.0);
				controller.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(destination.getTile());
				move.setRoadsOnly(false);
				controller.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(this.Math.rand(10, 60) * 1.0);
				controller.addOrder(wait2);
				local mercenary = this.new("scripts/ai/world/orders/mercenary_order");
				mercenary.setSettlement(destination);
				controller.addOrder(mercenary);
			}
		}
	});
	::mods_override(em, "onSerialize", function ( _out )
	{
		onSerialize(_out);

		if (_out.getMetaData().getInt("BDPVersion") >= 3)
		{
			local numCrownlings = 0;

			foreach( crownling in this.m.Crownlings )
			{
				if (crownling != null && !crownling.isNull() && crownling.isAlive())
				{
					numCrownlings = ++numCrownlings;
				}
			}

			_out.writeU8(numCrownlings);

			foreach( crownling in this.m.Crownlings )
			{
				if (crownling != null && !crownling.isNull() && crownling.isAlive())
				{
					_out.writeU32(crownling.getID());
				}
			}
		}
	});
	::mods_override(em, "onDeserialize", function ( _in )
	{
		onDeserialize(_in);

		if (_in.getMetaData().getInt("BDPVersion") >= 3)
		{
			local numCrownlings = _in.readU8();

			for( local i = 0; i != numCrownlings; i = ++i )
			{
				local crownling = this.World.getEntityByID(_in.readU32());

				if (crownling != null)
				{
					this.m.Crownlings.push(this.WeakTableRef(crownling));
				}
			}
		}
	});
});

::mods_hookExactClass("ai/world/orders/mercenary_order", function ( mo )
{
	local onExecute = ::mods_getMember(mo, "onExecute");
	::mods_override(mo, "onExecute", function ( _entity, _hasChanged )
	{
		local respawning = true;

		if (this.m.TargetSettlement == null || this.m.TargetSettlement.isNull() || !this.m.TargetSettlement.isAlive())
		{
			respawning = false;
		}

		if (this.m.TargetSettlement.getTile().ID != _entity.getTile().ID)
		{
			respawning = false;
		}

		local ret = onExecute(_entity, _hasChanged);

		if (_entity.getFlags().get("IsCrownlings"))
		{
			_entity.clearTroops();
			local r = this.Math.min(350, 150 + this.World.getTime().Days);
			local brush = _entity.getSprite("body").getBrush().Name;
			this.Const.World.Common.assignTroops(_entity, this.Const.World.Spawn.Crownlings, this.Math.rand(r * 0.8, r), 0);
			_entity.getSprite("body").setBrush(brush);
		}

		return ret;
	});
});

