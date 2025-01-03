::mods_hookExactClass("entity/world/player_party", function(o)
{
	o.m.BarterMultiplier <- 0.0;
	o.m.WageMultiplier <- 0.0;
	o.m.FoodMultiplier <- 0;
	o.m.AmmoMultiplier <- 0;
	o.m.ArmorPartsMultiplier <- 0;
	o.m.MedsMultiplier <- 0;
	o.m.StashMultiplier <- 0;

	o.setPath <- function( _path )
	{
		party.setPath(::World.Camp.isCamping() ? null : _path);
	}

	o.setDestination <- function( _destination )
	{
		party.setDestination(::World.Camp.isCamping() ? null : _destination);
	}

	o.updateStrength = function ()
	{
		this.m.Strength = 0.0;
		local roster = this.World.getPlayerRoster().getAll();

		if (roster.len() > this.World.Assets.getBrothersScaleMax())
		{
			roster.sort(this.onLevelCompare);
		}
		if (roster.len() < this.World.Assets.getBrothersScaleMin())
		{
			this.m.Strength += 10.0 * (this.World.Assets.getBrothersScaleMin() - roster.len());
		}


		if (this.World.Assets.getOrigin() == null)
		{
			this.m.Strength * 0.8;
			return;
		}

		local broScale = 1.0
		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			broScale = 0.66;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf")
		{
			broScale = 1.66;
		}

		local zombieSummonLevel = 0
		local skeletonSummonLevel = 0

		local count = 0;
		foreach( i, bro in roster )
		{
			if (i >= 25)
			{
				break;
			}

			if (bro.getSkills().hasSkill("perk.legend_pacifist"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_high"))
			{
				zombieSummonLevel = 7;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_med"))
			{
				zombieSummonLevel = 5;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_low"))
			{
				zombieSummonLevel = 2;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_high"))
			{
				skeletonSummonLevel = 7;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_med"))
			{
				skeletonSummonLevel = 5;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_low"))
			{
				skeletonSummonLevel = 2;
			}

			local brolevel = bro.getLevel();

			if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
			{
				this.m.Strength += (3 + ((brolevel / 4) + (brolevel - 1)) * 1.5) * broScale;
			}
			else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Normal)
			{
				this.m.Strength += (10 + (((3 * brolevel) / 4) + (brolevel - 1)) * 2) * broScale;
			}
			else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Hard)
			{
				this.m.Strength += (6 + (count / 2) + ((brolevel / 2) + (pow(brolevel,1.2)))) * broScale;
			}
			else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary )
			{
				this.m.Strength += (count + (brolevel + (pow(brolevel,1.2)))) * broScale;
			}

			// item scaling
			local mainhand = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offhand = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			local body = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local head = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local mainhandvalue = 0;
			local offhandvalue = 0;
			local bodyvalue = 0;
			local headvalue = 0;

			if (mainhand != null)
			{
				mainhandvalue += (mainhand.getSellPrice())  / 1000;
			}

			if (offhand != null)
			{
				offhandvalue += (offhand.getSellPrice()) / 1000;
			}

			if (body != null)
			{
				bodyvalue += (body.getSellPrice()) / 1000;
			}

			if (head != null)
			{
				headvalue += (head.getSellPrice()) / 1000;
			}

			local gearvalue = mainhandvalue + offhandvalue + bodyvalue + headvalue;
			this.m.Strength += gearvalue;
			// item scaling end

			count++;

		}

		if  (zombieSummonLevel == 0 && skeletonSummonLevel == 0)
		{
			return
		}

		//  Scaling based on money and stash - was controversial
		//	if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		//	{
		//		local items = this.World.Assets.getStash().getItems();
		//
		//		local itemsvalue = 0;
		//		foreach( item in items )
		//		{
		//			if (item != null)
		//			{
		//				itemsvalue += item.getSellPrice();
		//			}
		//		}
		//		this.m.Strength += itemsvalue / 1000;
		//		this.logInfo("Item power " + itemsvalue);
		//		local cashvalue = this.World.Assets.getMoney();
		//		this.logInfo("Gear power " + cashvalue);
		//		this.m.Strength += cashvalue / 750;
		//	}

		//When playing a warlock build, we need to account for the summons he can add
		local stash = this.World.Assets.getStash().getItems();

		local zCount = 0
		local sCount = 0
		foreach (item in stash)
		{
			if (item == null)
			{
				continue;
			}

			switch( item.getID())
			{
				case "spawns.zombie":
					if (zombieSummonLevel == 0)
					{
						continue
					}
					++zCount;

					break;
				case "spawns.skeleton":
					if (skeletonSummonLevel == 0)
					{
						continue
					}
					++sCount;
					break;
			}
		}

		if (zCount > 1)
		{
			zCount = this.Math.floor(zCount / 2.0);
			for (local i = 0; i < zCount; i = ++i)
			{
				this.m.Strength += 3 + (((zombieSummonLevel / 2) + (zombieSummonLevel - 1)) * 2.0);
			}
		}
		if (sCount > 1)
		{
			sCount = this.Math.floor(sCount / 2.0);
			for (local i = 0; i < sCount; i = ++i)
			{
				this.m.Strength += 3 + (((skeletonSummonLevel / 2) + (skeletonSummonLevel - 1)) * 2.0);
			}
		}
	}

	o.getStrength = function ()
	{
		this.updateStrength();
		return this.m.Strength;
	}

	local getVisionRadius = o.getVisionRadius;
	o.getVisionRadius = function ()
	{
		if (this.World.Assets.isCamping())
			return this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Scout).getVisionRadius();
		return getVisionRadius();
	}

	o.setBaseImage <- function ( _version = -1)
	{
		local image = "figure_player_01";
		if (_version > 1 && _version < 10)
		{
			image = "figure_player_0" + _version;
		}
		else if (_version > 100)
		{
			switch(_version)
			{
				case 101:
					image = "figure_player_noble";
					break;
				case 102:
					image = "figure_player_crusader";
					break;
				case 103:
					image = "figure_player_ranger";
					break;
				case 104:
					image = "figure_player_warlock";
					break;
				case 105:
					image = "figure_player_seer";
					break;
				case 106:
					image = "figure_player_berserker";
					break;
				case 107:
					image = "figure_player_trader";
					break;
				case 108:
					image = "figure_player_vala";
					break;
				case 109:
					image = "figure_player_party";
					break;
				case 110:
					image = "figure_player_assassin";
					break;
				case 111:
					image = "figure_player_beggar";
					break;
				case 112:
					image = "figure_player_legion";
					break;
				case 113:
					image = "figure_player_inquisition";
					break;
				case 114:
					image = "figure_player_troupe";
					break;
				case 115:
					image = "figure_player_druid";
					break;
				case 116:
					image = "figure_player_slave";
					break;
				case 117:
					image = "figure_player_nomad";
					break;
			}
		}
		else if ( _version > 9)
		{
			image = "figure_player_" + _version;
		}
		else
		{
			image = "figure_player_01";
		}

		this.getSprite("body").setBrush(image);
	}

	o.getBarterMult <- function ()
	{
		return this.m.BarterMultiplier;
	}

	o.getWageModifier <- function ()
	{
		return this.m.WageMultiplier;
	}

	o.getFoodModifier <- function ()
	{
		return this.m.FoodMultiplier;
	}

	o.getAmmoModifier <- function ()
	{
		return this.m.AmmoMultiplier;
	}

	o.getArmorPartsModifier <- function ()
	{
		return this.m.ArmorPartsMultiplier;
	}

	o.getMedsModifier <- function ()
	{
		return this.m.MedsMultiplier;
	}

	o.getStashModifier <- function ()
	{
		return this.m.StashMultiplier;
	}

	o.calculateModifiers <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 1)	//Leonion's fix
		{
			this.calculateBarterMult();
			this.calculateWageModifier();
			this.calculateFoodModifier();
			this.calculateAmmoModifier();
			this.calculateArmorPartsModifier();
			this.calculateMedsModifier();
			this.calculateStashModifier();
		}
	}


	o.calculateFoodModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 0)
		{
			return;
		}

		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			if (!bro.getSkills().hasSkill("perk.legend_quartermaster"))
			{
				continue;
			}

			this.m.FoodMultiplier = 1;
			break;
		}
	}

	o.calculateWageModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 0)
		{
			return;
		}

		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			if (bro.getSkills().hasSkill("perk.legend_barter_paymaster"))
			{
				this.m.WageMultiplier = bro.getBarterModifier();
				return;
			}
		}
	}

	o.calculateBarterMult <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 0)
		{
			return;
		}

		local barterMult = 0.0;
		local greed = 1;
		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			barterMult += bro.getBarterModifier();
			if (bro.getSkills().hasSkill("perk.legend_barter_greed"))
			{
				greed += 1;
			}
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.trader")
		{
			barterMult = barterMult * 1.1;
		}

		this.m.BarterMultiplier = barterMult / greed;
	}

	o.calculateAmmoModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 0)
		{
			return;
		}

		local s = 0;
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			s += bro.getAmmoModifier();
		}
		this.m.AmmoMultiplier = s;
	}

	o.calculateArmorPartsModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 0)
		{
			return;
		}

		local s = 0;
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			s += bro.getArmorPartsModifier();
		}
		this.m.ArmorPartsMultiplier = s;
	}

	o.calculateMedsModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 0)
		{
			return;
		}

		local s = 0;
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			s += bro.getMedsModifier();
		}
		this.m.MedsMultiplier = s;
	}

	o.calculateStashModifier <- function (resize = true)
	{
		if (this.World.State.m.AppropriateTimeToRecalc == 1)	////Leonion's fix
		{
			local s = this.Const.LegendMod.MaxResources[this.World.Assets.getEconomicDifficulty()].Stash
			s += this.World.Assets.getOrigin().getStashModifier();
			s += this.World.Retinue.getInventoryUpgrades() * 27;

			foreach( bro in this.World.getPlayerRoster().getAll())
			{
				s += bro.getStashModifier();
			}

			if (resize && s != this.Stash.getCapacity())
			{
				this.Stash.resize(s);
			}

			return s;
		}

		return ::Stash.getCapacity();
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.setBaseImage(1);
	}
});
