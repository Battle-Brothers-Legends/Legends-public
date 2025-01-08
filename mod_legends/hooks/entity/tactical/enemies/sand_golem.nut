::mods_hookExactClass("entity/tactical/enemies/sand_golem", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLastStand);
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/determined_trait"));
		}
	}

	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("StoneMason", 1, 1);
		}

		this.m.BackupFaction = this.getFaction();
		this.m.BackupWorldParty = this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull() ? this.m.WorldTroop.Party : null;

		if (_tile != null && this.getSize() > 1)
		{
			local freeTiles = [];

			for( local i = 0; i < 6; i = ++i )
			{
				if (!_tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = _tile.getNextTile(i);

					if (nextTile.Level > _tile.Level + 1)
					{
					}
					else if (nextTile.IsEmpty)
					{
						freeTiles.push(nextTile);
					}
				}
			}

			if (freeTiles.len() != 0)
			{
				local n = 2;

				while (n != 0 && freeTiles.len() >= 1)
				{
					local r = this.Math.rand(0, freeTiles.len() - 1);
					local tile = freeTiles[r];
					freeTiles.remove(r);
					local rock = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/sand_golem", tile.Coords.X, tile.Coords.Y);
					rock.setFaction(this.getFaction());
					n = n - 1;
					if (this.getWorldTroop() != null && ("Party" in this.getWorldTroop()) && this.getWorldTroop().Party != null && !this.m.WorldTroop.Party.isNull())
					{
						local e;

						if (this.getSize() == 3)
						{
							e = this.Const.World.Common.addTroop(this.getWorldTroop().Party.get(), {
								Type = this.Const.World.Spawn.Troops.SandGolemMEDIUM
							}, false);
						}
						else
						{
							e = this.Const.World.Common.addTroop(this.getWorldTroop().Party.get(), {
								Type = this.Const.World.Spawn.Troops.SandGolem
							}, false);
						}
						rock.setWorldTroop(e);
					}

					rock.getSprite("body").Color = this.getSprite("body").Color;
					rock.getSprite("body").Saturation = this.getSprite("body").Saturation;

					if (tile.IsVisibleForPlayer)
					{
						for( local i = 0; i < this.Const.Tactical.SandGolemParticles.len(); i = ++i )
						{
							this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SandGolemParticles[i].Brushes, tile, this.Const.Tactical.SandGolemParticles[i].Delay, this.Const.Tactical.SandGolemParticles[i].Quantity, this.Const.Tactical.SandGolemParticles[i].LifeTimeQuantity, this.Const.Tactical.SandGolemParticles[i].SpawnRate, this.Const.Tactical.SandGolemParticles[i].Stages);
						}
					}

					if (this.getSize() == 3)
					{
						rock.grow(true);
					}
				}

				if (n > 0)
				{
					this.m.IsSpawningOnTile = true;
				}
			}
			else
			{
				this.m.IsSpawningOnTile = true;
			}
		}
		else
		{
			this.m.IsSpawningOnTile = true;
		}

		local flip = this.Math.rand(0, 100) < 50;
		local sprite_body = this.getSprite("body");

		if (_tile != null)
		{
			local decal;
			local skin = this.getSprite("body");
			this.m.IsCorpseFlipped = flip;
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An " + this.getName();
			corpse.Tile = _tile;
			corpse.Value = 2.0;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = false;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.IsHeadAttached = true;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 40)
			{
				local n = 0 + this.Math.rand(0, 1) + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = ++i )
				{
					local loot = this.new("scripts/items/misc/sulfurous_rocks_item");
					loot.drop(_tile);
				}

				if (this.Math.rand(1, 100) <= 10)
				{
					local loot = this.new("scripts/items/loot/glittering_rock_item");
					loot.drop(_tile);
				}
				else if (this.Math.rand(1, 100) <= 5)
				{
					local loot = this.new("scripts/items/trade/uncut_gems_item");
					loot.drop(_tile);
				}
			}

			this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		}
	}
});
