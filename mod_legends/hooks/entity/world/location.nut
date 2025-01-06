::mods_hookExactClass("entity/world/location", function(o)
{
	o.isShowingDefenders = function ()
	{
		return this.m.IsShowingDefenders || this.World.Assets.getOrigin().getID() == "scenario.rangers" || this.World.Assets.getOrigin().getID() == "scenario.legends_rangers";
	}

	o.onSpawned = function ()
	{
		local nearestSettlement = 9000;
		local myTile = this.getTile();

		foreach( s in this.World.EntityManager.getSettlements() )
		{
			local d = myTile.getDistanceTo(s.getTile());

			if (d < nearestSettlement)
			{
				nearestSettlement = d;
			}
		}

		if (!this.isLocationType(this.Const.World.LocationType.Unique))
		{
			local num = 0;

			for( local chance = (this.m.Resources + nearestSettlement * 4) / 5.0 - 37.0; num < 2;  )
			{
				local r = this.Math.rand(1, 100);

				if (r <= chance)
				{
					chance = chance - r;
					num = ++num;
					local type = this.Math.rand(1, 100);

					if (type <= 40)
					{
						local weapons = clone this.Const.Items.NamedWeapons;

						if (this.m.NamedWeaponsList != null && this.m.NamedWeaponsList.len() != 0)
						{
							weapons.extend(this.m.NamedWeaponsList);
							weapons.extend(this.m.NamedWeaponsList);
						}

						this.m.Loot.add(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
					}
					else if (type <= 50)
					{
						local shields = clone this.Const.Items.NamedShields;

						if (this.m.NamedShieldsList != null && this.m.NamedShieldsList.len() != 0)
						{
							shields.extend(this.m.NamedShieldsList);
							shields.extend(this.m.NamedShieldsList);
						}

						this.m.Loot.add(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					}
					else if (type <= 70)
					{
						local helmets = clone this.Const.Items.NamedHelmets;

						if (this.m.NamedHelmetsList != null && this.m.NamedHelmetsList.len() != 0)
						{
							helmets.extend(this.m.NamedHelmetsList);
							helmets.extend(this.m.NamedHelmetsList);
						}
						local weightName = this.Const.World.Common.convNameToList(helmets);
						this.m.Loot.add(this.Const.World.Common.pickHelmet(weightName));
					}
					else if (type <= 100)
					{
						local armor = clone this.Const.Items.NamedArmors;
						if (this.m.NamedArmorsList != null && this.m.NamedArmorsList.len() != 0)
						{
							armor.extend(this.m.NamedArmorsList);
							armor.extend(this.m.NamedArmorsList);
						}
						local weightName = this.Const.World.Common.convNameToList(armor);
						this.m.Loot.add(this.Const.World.Common.pickArmor(weightName));
					}
				}
				else
				{
					break;
				}
			}
		}
	}

	o.createDefenders = function ()
	{
		local resources = this.m.Resources;

		if (this.m.IsScalingDefenders)
		{
			resources = resources * this.Math.minf(3.0, 1.0 + this.World.getTime().Days * 0.0075);
		}

		if (!this.isAlliedWithPlayer())
		{
			resources = resources * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
		}

		if (this.Time.getVirtualTimeF() - this.m.LastSpawnTime <= 60.0)
		{
			resources = resources * 0.75;
		}

		local best = {
			Troops = []
		}

		if (this.m.DefenderSpawnList && ("Name" in this.m.DefenderSpawnList))
		{
			best = this.Const.World.Common.buildDynamicTroopList(this.m.DefenderSpawnList, resources)
		}
		else
		{
			local bestCost = -9000;

			foreach( party in this.m.DefenderSpawnList )
			{
				if (party.Cost > resources)
				{
					continue;
				}

				if (best == null || party.Cost > bestCost)
				{
					best = party;
					bestCost = party.Cost;
				}
			}

			local potential = [];

			foreach( party in this.m.DefenderSpawnList )
			{
				if (party.Cost > resources || party.Cost < bestCost * 0.75)
				{
					continue;
				}

				potential.push(party);
			}

			if (potential.len() != 0)
			{
				best = potential[this.Math.rand(0, potential.len() - 1)];
			}

			if (best == null)
			{
				bestCost = 9000;

				foreach( party in this.m.DefenderSpawnList )
				{
					if (this.Math.abs(party.Cost - resources) < bestCost)
					{
						best = party;
						bestCost = this.Math.abs(party.Cost - resources);
					}
				}
			}
		}

		if (best == null)
		{
			return
		}

		this.m.Troops = [];

		if (this.Time.getVirtualTimeF() - this.m.LastSpawnTime <= 60.0)
		{
			this.m.DefenderSpawnDay = this.World.getTime().Days - 7;
		}
		else
		{
			this.m.DefenderSpawnDay = this.World.getTime().Days;
		}

		local troopMbMap = {};
		foreach( t in best.Troops )
		{
			local key = "Enemy" + t.Type.ID;
			if (!(key in troopMbMap))
			{
				troopMbMap[key] <- this.Const.LegendMod.GetFavEnemyBossChance(t.Type.ID);
			}

			local mb = troopMbMap[key];

			for( local i = 0; i != t.Num; i = ++i )
			{
				this.Const.World.Common.addTroop(this, t, false, mb);
			}
		}

		this.updateStrength();
	}

	local setResources = o.setResources;
	o.setResources <- function (_v) {
		setResources(::Math.max(0, ::Math.round(_v)));
	}

	o.getNewResources <- function ()
	{
		return 0;
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize( _out );
		_out.writeBool(this.m.IsShowingDefenders);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize( _in );
		this.m.IsShowingDefenders = _in.readBool();
	}
});
