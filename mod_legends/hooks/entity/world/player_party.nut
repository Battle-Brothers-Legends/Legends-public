::mods_hookExactClass("entity/world/player_party", function(o)
{
	o.m.HaggleMultiplier <- 0.0;
	o.m.AmmoMultiplier <- 0;
	o.m.ArmorPartsMultiplier <- 0;
	o.m.MedsMultiplier <- 0;
	o.m.StashMultiplier <- 0;
	o.m.PauseOnMovementStop <- false;

	local onUpdate = o.onUpdate;
	o.onUpdate = function () {
		local wasMoving = this.m.Destination != null || this.hasPath();
		onUpdate();
		local isMoving = this.m.Destination != null || this.hasPath();
		if (wasMoving && !isMoving) {
			if (::Legends.Mod.ModSettings.getSetting("PauseOnMovementStop").getValue()) {
				this.m.PauseOnMovementStop = true;
			}
		}
	}

	o.setPath <- function( _path )
	{
		this.party.setPath(::World.Camp.isCamping() ? null : _path);

		if (_path != null && ::Legends.Mod.ModSettings.getSetting("ResumeOnMovementStart").getValue()) {
            if (::World.State.isPaused()) {
                ::World.State.setPause(false);
            }
        }
	}

	o.setDestination <- function( _destination ) {
		this.party.setDestination(::World.Camp.isCamping() ? null : _destination);
		if (_destination != null && ::Legends.Mod.ModSettings.getSetting("ResumeOnMovementStart").getValue()) {
            if (::World.State.isPaused()) {
                ::World.State.setPause(false);
            }
        }
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
			this.m.Strength += 10.0 * roster.len();
		}

		if (this.World.Assets.getOrigin() == null)
		{
			this.m.Strength * 0.8;
			return;
		}

		local zombieSummonLevel = 0;
		local skeletonSummonLevel = 0;

		local count = 0;
		foreach( i, bro in roster )	{
			if (i >= 25) {
				break;
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendPacifist))	{
				continue;
			}

			this.m.Strength += ::Legends.Difficulty.BroStrengthScaling(bro.getLevel(), count);
			this.m.Strength += ::Legends.Difficulty.BroItemScaling(bro.getItems().getAllItems());
			count++;

			
			// this is flawed because it sets zombie summon level rather than adding it
			// if we have a low level bro with SpawnZombieLow he'll override the bro with higher level and summon zombie high
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnZombieHigh)) {
				zombieSummonLevel = 7;
			} else if (bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnZombieMed)) {
				zombieSummonLevel = 5;
			} else if (bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnZombieLow)) {
				zombieSummonLevel = 2;
			}
		}

		if  (zombieSummonLevel == 0 && skeletonSummonLevel == 0) {
			return;
		}

		//  Scaling based on money and stash - was controversial
		//	if (::Legends.isLegendaryDifficulty())
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

		local zCount = 0;
		local sCount = 0;
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
						continue;
					}
					++zCount;

					break;
				case "spawns.skeleton":
					if (skeletonSummonLevel == 0)
					{
						continue;
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
	o.getVisionRadius = function ()	{
		::World.Assets.m.VisionRadiusMult = 1 + ::World.Assets.m.ProfessionEffect.LegendLookout;
		if (::World.Assets.isCamping())
			return ::World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Scout).getVisionRadius();
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

	o.getHaggleMult <- function ()
	{
		return this.m.HaggleMultiplier;
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
		if (this.World.State.m.AppropriateTimeToRecalc == 1) //Leonion's fix
		{
			this.calculateHaggleMult();
			this.calculateAmmoModifier();
			this.calculateArmorPartsModifier();
			this.calculateMedsModifier();
			this.calculateStashModifier();
		}
	}

	o.calculateHaggleMult <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc != 1)
			return;

		local haggleMult = 0.0;
		foreach (bro in this.World.getPlayerRoster().getAll()) {
			haggleMult += bro.getHaggleModifier();
		}
		haggleMult += ::World.Assets.m.ProfessionEffect.LegendConvincingProposals;

		if (this.World.Assets.getOrigin().getID() == "scenario.trader")
			haggleMult = haggleMult * 1.1;

		this.m.HaggleMultiplier = haggleMult;
	}

	o.calculateAmmoModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc != 1)
			return;

		local s = 0;
		foreach(bro in this.World.getPlayerRoster().getAll())	{
			s += bro.getAmmoModifier();
		}
		s += ::World.Assets.m.ProfessionEffect.LegendReserveBundles;
		this.m.AmmoMultiplier = s;
	}

	o.calculateArmorPartsModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc != 1)
			return;

		local s = 0;
		foreach(bro in this.World.getPlayerRoster().getAll())	{
			s += bro.getArmorPartsModifier();
		}
		s += ::World.Assets.m.ProfessionEffect.LegendToolsDrawers;
		this.m.ArmorPartsMultiplier = s;
	}

	o.calculateMedsModifier <- function ()
	{
		if (this.World.State.m.AppropriateTimeToRecalc != 1)
			return;

		local s = 0;
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			s += bro.getMedsModifier();
		}
		s += ::World.Assets.m.ProfessionEffect.LegendBandageBales;
		this.m.MedsMultiplier = s;
	}

	o.calculateStashModifier <- function (_resize = true)
	{
		if (_resize && ::World.State.m.AppropriateTimeToRecalc == 1) {	//Leonion's fix
			::Legends.Stash.resize();
		}
		return ::Legends.Stash.getSize();
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.setBaseImage(1);
	}
});
