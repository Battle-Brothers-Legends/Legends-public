::mods_hookExactClass("entity/tactical/enemies/zombie_boss", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		}
	}

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath(_killer, _skill, _tile, _fatalityType);
		local mapSize = this.Tactical.getMapSize();
		local attempts = 0;
		local n = 0;

		while (attempts++ < 250)
		{
			local x = this.Math.rand(this.Math.max(0, this.m.Info.Tile.SquareCoords.X - 5), this.Math.min(mapSize.X - 1, this.m.Info.Tile.SquareCoords.X + 5));
			local y = this.Math.rand(this.Math.max(0, this.m.Info.Tile.SquareCoords.Y - 5), this.Math.min(mapSize.Y - 1, this.m.Info.Tile.SquareCoords.Y + 5));

			if (!this.Tactical.isValidTileSquare(x, y))
			{
				continue;
			}

			local tile = this.Tactical.getTileSquare(x, y);

			if (!tile.IsEmpty || tile.ID == this.m.Info.Tile.ID)
			{
				continue;
			}

			this.spawnSpawnEffect(tile);
			local e = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_banshee", tile.Coords);
			e.setFaction(this.m.Info.Faction);
			e.assignRandomEquipment();
			n = ++n;

			if (n >= 5)
			{
				break;
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}
});
