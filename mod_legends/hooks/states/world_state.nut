::mods_hookExactClass("states/world_state", function(o)
{
	o.m.CampScreen <- null;
	o.m.Campaign <- "";
	o.m.CommanderDied <- null;
	o.m.Camp <- null;
	o.m.IDToRef <- array(27, -1);
	o.m.DistantVisionBonus <- false;
	o.m.AppropriateTimeToRecalc <- 0; //Leonion's fix
	o.m.Encounters <- null;

	o.getBrothersInReserves <- function ()
	{
		local count = 0;
		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			if (bro.isInReserves())
			{
				count++;
			}
		}
		return count;
	}

	o.getBrothersInFrontline <- function ()
	{
		return ::World.getPlayerRoster().getSize() - this.getBrothersInReserves();
	}

	o.getCampScreen <- function ()
	{
		return this.m.CampScreen;
	}

	o.commanderDied <- function ()
	{
		return this.m.CommanderDied;
	}

	o.setCommanderDied <- function ( _v )
	{
		this.m.CommanderDied = _v
	}

	local onInit = o.onInit;
	o.onInit = function()
	{
		this.m.CommanderDied = false;
		this.m.Encounters = this.new("scripts/states/world/encounter_manager");
		::World.Encounters <- this.WeakTableRef(this.m.Encounters);
		this.m.Encounters.onInit();
		this.m.Camp = this.new("scripts/states/world/camp_manager");
		::World.Camp <- this.WeakTableRef(this.m.Camp);
		onInit();
	}

	local onInitUI = o.onInitUI;
	o.onInitUI = function()
	{
		this.m.CampScreen <- this.new("scripts/ui/screens/world/camp_screen");
		this.m.CampScreen.setOnBrothersPressedListener(this.camp_screen_main_dialog_module_onBrothersButtonClicked.bindenv(this));
		this.m.CampScreen.setOnCommanderPressedListener(this.camp_screen_main_dialog_module_onCommanderButtonClicked.bindenv(this));
		this.m.CampScreen.setOnTentPressedListener(this.camp_screen_main_dialog_module_onTentButtonClicked.bindenv(this));
		this.m.CampScreen.setOnModuleClosedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));
		this.m.CampScreen.setOnCampListener(this.onCamp.bindenv(this));
		onInitUI();
	}

	local onDestroyUI = o.onDestroyUI;
	o.onDestroyUI = function ()
	{
		this.m.CampScreen.destroy();
		this.m.CampScreen = null;
		onDestroyUI();
	}

	local onFinish = o.onFinish;
	o.onFinish = function()
	{
		this.m.Camp.destroy();
		this.m.Camp = null;
		::World.Camp = null;
		this.m.Encounters.clear();
		this.m.Encounters = null;
		::World.Encounters = null;
		onFinish();
	}

	local onShow = o.onShow;
	o.onShow = function ()
	{
		onShow();
		::World.setPlayerPos(this.getPlayer().getPos());
        ::World.setPlayerVisionRadius(this.getPlayer().getVisionRadius());
	}

	local loadCampaign = o.loadCampaign;
	o.loadCampaign = function( _campaignFileName )
	{
		if (::Time.getRealTimeF() - m.CampaignLoadTime < 4.0)
			return;

		m.AppropriateTimeToRecalc = 0;
		loadCampaign(_campaignFileName);
	}

	o.onCalculatePlayerPartyModifiers <- function()
	{
		m.AppropriateTimeToRecalc = 1;
		getPlayer().calculateModifiers(); //Leonion's fix
	}

	local startNewCampaign = o.startNewCampaign;
	o.startNewCampaign = function()
	{
		m.AppropriateTimeToRecalc = 0; // set to 0 as you don't want it to update those modifiers
		::Legends.IsStartingNewCampaign = true;
		startNewCampaign();
		::World.setFogOfWar(!::Legends.Mod.ModSettings.getSetting("DebugMap").getValue()); //
		::World.Crafting.resetAllBlueprints(); //
		onCalculatePlayerPartyModifiers();
		::Legends.IsStartingNewCampaign = false;
	}

	o.showIntroductionScreen <- function ( _tag = null )
	{
		this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
		::World.Contracts.update(true);
	}

	local setNewCampaignSettings = o.setNewCampaignSettings;
	o.setNewCampaignSettings = function ( _settings )
	{
		foreach(k,v in _settings)
		{
			::logInfo(k + " = " + v);
		}

		setNewCampaignSettings(_settings);
	}

	local setPause = o.setPause;
	o.setPause = function( _f )
	{
		local TopbarDayTimeModuleExist = ("TopbarDayTimeModule" in ::World) && ::World.TopbarDayTimeModule != null;

		if (TopbarDayTimeModuleExist)
			::World.TopbarDayTimeModule.m.IsAutoUpdateTimeButtonState = true;

		setPause(_f);

		if (TopbarDayTimeModuleExist)
			::World.TopbarDayTimeModule.m.IsAutoUpdateTimeButtonState = false;
	}

	local onCombatFinished = o.onCombatFinished;
	o.onCombatFinished = function()
	{
		local friendlyCaravanParties = [];

		foreach( party in m.PartiesInCombat )
		{
			if (party.getTroops().len() > 0
				&& party.isAlive()
				&& party.isAlliedWithPlayer()
				&& party.getFlags().get("IsCaravan")
				&& m.EscortedEntity == null
			) {
				friendlyCaravanParties.push(party);
				party.getFlags().set("IsCaravan", false); // set to false so the check in the original 'onCombatFinished' will fail
				::World.Statistics.getFlags().set("LastCombatSavedCaravan", true);

				if (party.getStashInventory().getItems().len() != 0) {
					local prefix = "scripts/items/";
					local script = ::IO.scriptFilenameByHash(::MSU.Array.rand(party.getStashInventory().getItems()).ClassNameHash);
					::World.Statistics.getFlags().set("LastCombatSavedCaravanProduce", script.slice(prefix.len()));
				}
				else if (party.getInventory().len() != 0) {
					::World.Statistics.getFlags().set("LastCombatSavedCaravanProduce", ::MSU.Array.rand(party.getInventory()));
				}
			}
		}

		onCombatFinished();

		foreach( party in friendlyCaravanParties )
		{
			party.getFlags().set("IsCaravan", true); // reverse the change
		}

		::Legends.Maps.cleanUp();
	}

	o.getLocalCombatProperties = function ( _pos, _ignoreNoEnemies = false )
	{
		local raw_parties = ::World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance);
		local parties = [];
		local properties = this.Const.Tactical.CombatInfo.getClone();
		local tile = ::World.getTile(::World.worldToTile(_pos));
		local isAtUniqueLocation = false;
		properties.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
		properties.Tile = tile;
		properties.InCombatAlready = false;
		properties.IsAttackingLocation = false;
		local factions = [];
		factions.resize(256, 0); // handled by MSU

		foreach( party in raw_parties )
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (party.isLocation() && party.isLocationType(this.Const.World.LocationType.Unique))
			{
				isAtUniqueLocation = true;
				break;
			}

			if (party.isInCombat())
			{
				raw_parties = ::World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance * 2.0);
				break;
			}
		}

		foreach( party in raw_parties )
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (isAtUniqueLocation && (!party.isLocation() || !party.isLocationType(this.Const.World.LocationType.Unique)))
			{
				continue;
			}

			if (!_ignoreNoEnemies)
			{
				local hasOpponent = false;

				foreach( other in raw_parties )
				{
					if (other.isAlive() && !party.isAlliedWith(other))
					{
						hasOpponent = true;
						break;
					}
				}

				if (hasOpponent)
				{
					parties.push(party);
				}
			}
			else
			{
				parties.push(party);
			}
		}

		foreach( party in parties )
		{
			if (party.isInCombat())
			{
				properties.InCombatAlready = true;
			}

			if (party.isLocation())
			{
				properties.IsAttackingLocation = true;
				properties.CombatID = "LocationBattle";
				properties.LocationTemplate = party.getCombatLocation();
				properties.LocationTemplate.OwnedByFaction = party.getFaction();
			}

			::World.Combat.abortCombatWithParty(party);
			party.onBeforeCombatStarted();
			local troops = party.getTroops();

			foreach( t in troops )
			{
				if (t.Script != "")
				{
					t.Faction <- party.getFaction();
					t.Party <- this.WeakTableRef(party);
					properties.Entities.push(t);

					if (!::World.FactionManager.isAlliedWithPlayer(party.getFaction()))
					{
						++factions[party.getFaction()];
					}
				}
			}

			if (troops.len() != 0)
			{
				party.onCombatStarted();
				properties.Parties.push(party);
				this.m.PartiesInCombat.push(party);

				if (party.isAlliedWithPlayer())
				{
					properties.AllyBanners.push(party.getBanner());
				}
				else
				{
					properties.EnemyBanners.push(party.getBanner());
				}
			}
		}

		local highest_faction = 0;
		local best = 0;

		foreach( i, f in factions )
		{
			if (f > best)
			{
				best = f;
				highest_faction = i;
			}
		}

		if (::World.FactionManager.getFaction(highest_faction) != null)
		{
			properties.Music = ::World.FactionManager.getFaction(highest_faction).getCombatMusic();
		}

		return properties;
	}

	o.getEngageNumberNames <- function ( _entityType)
	{
		foreach (key, value in this.Const.Strings.EngageEnemyNumbers)
		{
			if (_entityType >= value[0] && _entityType <= value[1])
			{
				return this.Const.Strings.EngageEnemyNumbersNames[key];
			}
		}
	}

	o.showCampScreen <- function ()
	{
		if (!this.isCampingAllowed())
		{
			return;
		}

		if (::World.Camp.isCamping())
		{
			this.onCamp();
			return
		}
		//this.Music.setTrackList(this.m.LastEnteredTown.getMusic(), this.Const.Music.CrossFadeTime);
		this.setPause(true);
		this.setAutoPause(true);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		//this.m.WorldTownScreen.setTown(this.m.LastEnteredTown);
		this.m.CampScreen.show();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrainInSettlement, ::World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		//this.Sound.setAmbience(1, this.m.LastEnteredTown.getSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInSettlement, ::World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		this.m.MenuStack.push(function ()
		{
			this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, ::World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
			this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);
			::World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			// ::World.Assets.consumeItems();
			// ::World.Assets.refillAmmo();
			// ::World.Assets.updateAchievements();
			// ::World.Assets.checkAmbitionItems();
			// ::World.Ambitions.resetTime(false, 2.0);
			// this.updateTopbarAssets();
			// ::World.State.getPlayer().updateStrength();
			this.m.CampScreen.clear();
			this.m.CampScreen.hide();
			this.m.WorldScreen.show();
			this.Music.setTrackList(::World.FactionManager.isGreaterEvil() ? this.Const.Music.WorldmapTracksGreaterEvil : this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime);

			if (::World.Assets.isIronman())
			{
				this.autosave();
			}

			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.setAutoPause(false);
			this.setPause(true);
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	o.camp_screen_main_dialog_module_onBrothersButtonClicked <- function ()
	{
		this.showCharacterScreenFromCamp();
	}

	o.camp_screen_main_dialog_module_onCommanderButtonClicked <- function ()
	{
		this.showCommanderScreenFromCamp();
	}

	o.camp_screen_main_dialog_module_onTentButtonClicked <- function ( _id )
	{
		this.showTentScreenFromCamp( _id );
	}

	o.isInDevScreen <- function ()
	{
		if (this.m.WorldScreen != null && this.m.WorldScreen.devConsoleVisible())
		{
			return true;
		}

		return false;
	}

	o.showCharacterScreenFromCamp <- function ()
	{
		::World.Assets.updateFormation();
		this.m.CampScreen.hideAllDialogs();
		this.m.CharacterScreen.show();
		this.m.MenuStack.push(function ()
		{
			this.m.CharacterScreen.hide();
			this.m.CampScreen.showLastActiveDialog();
		}, function ()
		{
			return !this.m.CharacterScreen.isAnimating();
		});
	}

	o.showCommanderScreenFromCamp <- function ()
	{
		this.m.CampScreen.hideAllDialogs();
		this.m.CampScreen.showCommanderDialog();
		this.m.MenuStack.push(function ()
		{
			this.m.CampScreen.showLastReturnDialog();
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	o.showTentScreenFromCamp <- function ( _id )
	{
		this.m.CampScreen.hideAllDialogs();
		this.m.CampScreen.showTentBuildingDialog( _id );
		this.m.MenuStack.push(function ()
		{
			this.m.CampScreen.showLastReturnDialog();
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	o.helper_handleDeveloperKeyInput = function ( _key )
	{
		if (_key.getState() != 0)
		{
			return false;
		}

		if (this.m.MenuStack.hasBacksteps())
		{
			return false;
		}

		switch(_key.getKey())
		{
		case 3:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			::World.setSpeedMult(3.0);
			this.logDebug("World Speed set to x3.0");
			return true;

		case 4:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			::World.setSpeedMult(4.0);
			this.logDebug("World Speed set to x4.0");
			return true;

		case 5:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			::World.setSpeedMult(5.0);
			this.logDebug("World Speed set to x5.0");
			return true;

		case 6:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			::World.setSpeedMult(6.0);
			this.logDebug("World Speed set to x6.0");
			return true;

		case 7:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			::World.setSpeedMult(7.0);
			this.logDebug("World Speed set to x7.0");
			return true;

		case 8:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			::World.setSpeedMult(8.0);
			this.logDebug("World Speed set to x8.0");
			return true;

		case 9:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			::World.setSpeedMult(9.0);
			this.logDebug("World Speed set to x9.0");
			return true;

		case 11:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.m.Player.setAttackable(!this.m.Player.isAttackable());

			if (this.m.Player.isAttackable())
			{
				this.logDebug("Player can now be attacked.");
			}
			else
			{
				this.logDebug("Player can NOT be attacked.");
			}

			return true;

		case 18:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			::World.Assets.setConsumingAssets(!::World.Assets.isConsumingAssets());

			if (::World.Assets.isConsumingAssets())
			{
				this.logDebug("Player is consuming assets.");
			}
			else
			{
				this.logDebug("Player is NOT consuming assets.");
			}

			return true;

		case 16:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			::World.setFogOfWar(!::World.isUsingFogOfWar());

			if (::World.isUsingFogOfWar())
			{
				this.logDebug("Fog Of War activated.");
			}
			else
			{
				this.logDebug("Fog Of War deactivated.");
			}

			return true;

		case 17:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastTileHovered == null)
			{
				break;
			}

			this.logInfo("distance: " + this.m.LastTileHovered.getDistanceTo(this.getPlayer().getTile()));
			this.logInfo("y: " + this.m.LastTileHovered.SquareCoords.Y);
			this.logInfo("type: " + this.m.LastTileHovered.Type);
			return true;

		case 21:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastEntityHovered != null && this.m.LastEntityHovered.isLocation())
			{
				local e = this.m.LastEntityHovered;
				e.setActive(false);
				e.getTile().spawnDetail(e.m.Sprite + "_ruins", this.Const.World.ZLevel.Object - 3, 0);
				e.die();
				return true;
			}

			break;

		case 22:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastEntityHovered != null && this.m.LastEntityHovered.isLocation())
			{
				local e = this.m.LastEntityHovered;
				local tile = e.getTile();
				local name = e.getName();
				local sprite = e.m.Sprite;
				e.setActive(false);
				e.getTile().spawnDetail(e.m.Sprite + "_ruins", this.Const.World.ZLevel.Object - 3, 0, false);
				e.fadeOutAndDie();
				return true;
			}

			break;

		case 25:
			// if (!this.m.IsDeveloperModeEnabled)
			// {
			// 	break;
			// }

			if (this.m.LastTileHovered != null)
			{
				local faction = ::World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits);
				local party = faction.spawnEntity(this.m.LastTileHovered, "TEST GROUP", false, this.Const.World.Spawn.BanditRoamers, 200);
				party.getSprite("banner").setBrush("banner_orcs_04");
				party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
				local c = party.getController();
				local ambush = this.new("scripts/ai/world/orders/ambush_order");
				c.addOrder(ambush);
				return true;
			}

			break;

		case 23:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			::World.Assets.addMoney(10000);
			this.updateTopbarAssets();
			break;

		case 24:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			local playerRoster = ::World.getPlayerRoster().getAll();

			foreach( bro in playerRoster )
			{
				bro.addXP(1000, false);
				bro.updateLevel();
			}

			break;

		case 27:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			::World.Assets.addBusinessReputation(500);
			break;

		case 81:
			if (!this.m.IsDeveloperModeEnabled)
			{
			}
			else
			{
				if (this.Tooltip.getDelay() < 1000)
				{
					this.Tooltip.setDelay(900000);
				}
				else
				{
					this.Tooltip.setDelay(150);
				}

				break;
			}
		}

		return false;
	}

	o.helper_handleContextualKeyInput = function ( _key )
	{
		if (this.isInLoadingScreen())
		{
			return true;
		}

		if (this.m.IsDeveloperModeEnabled && this.helper_handleDeveloperKeyInput(_key))
		{
			return true;
		}

		//if (this.isInDevScreen())
		//{
		//	switch(_key.getKey())
		//	{
		//	case 41:
		//		this.m.WorldScreen.hideDevConsole();
		//		break;
		//	}

		// 	return true;
		// }

		if (this.isInCharacterScreen() && _key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 11:
			case 48:
				this.m.CharacterScreen.switchToPreviousBrother();
				break;

			case 38:
			case 14:
			case 50:
				this.m.CharacterScreen.switchToNextBrother();
				break;

			case 19:
			case 13:
			case 41:
				this.toggleCharacterScreen();
				break;


			case 29:
				this.m.CharacterScreen.toggleBrotherReserves();
				break;
			}

			return true;
		}

		if (this.m.CampfireScreen != null && this.m.CampfireScreen.isVisible() && _key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 41:
			case 26:
				this.m.CampfireScreen.onModuleClosed();
				break;
			}
		}
		else if (_key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 41:
				if (this.m.WorldMenuScreen.isAnimating())
				{
					return false;
				}

				if (this.toggleMenuScreen())
				{
					return true;
				}

				break;

			case 13:
			case 19:
				if (!this.m.MenuStack.hasBacksteps() || this.m.CharacterScreen.isVisible() || this.m.WorldTownScreen.isVisible() && !this.m.EventScreen.isVisible())
				{
					if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
					{
						this.toggleCharacterScreen();
					}

					return true;
				}

				break;

			case 28:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onRelationsButtonClicked();
				}
				else if (this.m.RelationsScreen.isVisible())
				{
					this.m.RelationsScreen.onClose();
				}

				break;

			case 25:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onObituaryButtonClicked();
				}
				else if (this.m.ObituaryScreen.isVisible())
				{
					this.m.ObituaryScreen.onClose();
				}

				break;

			case 30:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.showCampScreen();
					// if (this.isCampingAllowed())
					// {
					// 	this.onCamp();
					// }
				}

				break;

			//case 32:
			//	if (!this.m.MenuStack.hasBacksteps())
			//	{
			//		this.m.WorldScreen.showDevConsole();
			//		return true;
			//	}
			//	break;

			case 26:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onPerksButtonClicked();
				}

				break;

			case 42:
			case 40:
			case 10:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setPause(!this.isPaused());
					return true;
				}

				break;

			case 1:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setNormalTime();
					break;
				}

			case 2:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setFastTime();
					break;
				}

			case 16:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onTrackingButtonPressed();
					return true;
				}

				break;

			case 34:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
				}

				break;

			case 75:
				if (!this.m.MenuStack.hasBacksteps() && !::World.Assets.isIronman())
				{
					this.saveCampaign("quicksave");
				}

				break;

			case 79:
				if (!this.m.MenuStack.hasBacksteps() && !::World.Assets.isIronman() && ::World.canLoad("quicksave"))
				{
					this.loadCampaign("quicksave");
				}

				break;

			case 14:
				if ((_key.getModifier() & 2) != 0 && this.m.IsAllowingDeveloperMode)
				{
					this.m.IsDeveloperModeEnabled = !this.m.IsDeveloperModeEnabled;

					if (this.m.IsDeveloperModeEnabled)
					{
						this.logDebug("*** DEVELOPER MODE ENABLED ***");
					}
					else
					{
						this.logDebug("*** DEVELOPER MODE DISABLED ***");
					}
				}

				break;

			case 1:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(0);
				return true;

			case 2:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(1);
				return true;

			case 3:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(2);
				return true;

			case 4:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(3);
				return true;

			case 95:
				this.m.IsForcingAttack = false;
				return true;
			}
		}

		if (_key.getState() == 1 && !this.m.MenuStack.hasBacksteps())
		{
			switch(_key.getKey())
			{
			case 11:
			case 27:
			case 48:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					::World.getCamera().move(-1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, ::World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 14:
			case 50:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					::World.getCamera().move(1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, ::World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 33:
			case 36:
			case 49:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					::World.getCamera().move(0, 1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, ::World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 29:
			case 51:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					::World.getCamera().move(0, -1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, ::World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 67:
			case 46:
				::World.getCamera().zoomBy(-this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 68:
			case 47:
				::World.getCamera().zoomBy(this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 96:
			case 39:
				::World.getCamera().Zoom = 1.0;
				::World.getCamera().setPos(::World.State.getPlayer().getPos());
				break;

			case 95:
				if (this.m.MenuStack.hasBacksteps())
				{
				}
				else
				{
					this.m.IsForcingAttack = true;
					return true;
				}
			}
		}
	}

	o.getRefFromID <- function ( _id )
	{
		if (_id == -1) return null;

		if (_id > this.m.IDToRef.len() - 1) return null;

		local val = this.m.IDToRef[_id];
		if (val == -1) {
			return null
		}
		return val;
	}

	o.removeCompanyID <- function ( _id )
	{
		this.m.IDToRef[_id] = -1;
	}

	o.addNewID <- function ( _actor ) //return the id we gave and also put wtr into id slot
	{
		for ( local i = 0; i < 27; i++ )
		{
			if (this.m.IDToRef[i] == -1)
			{
				this.m.IDToRef[i] = this.WeakTableRef(_actor);
				return i;
			}
		}
	}

	o.setDistantVisionBonus <- function ( _bonus )
	{
		this.m.DistantVisionBonus = _bonus;
	}

	o.getDistantVisionBonus <- function ()
	{
		return this.m.DistantVisionBonus;
	}

	/**
	 * Adds convenience method to world state to mimic original
	 * Shows encouter dialog while in settlement
	 */
	o.showEncounterScreenFromTown <- function (_encounter, _playSound = true) {
		if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
		{
			if (::isKindOf(_encounter, "encounter_event")) {
				::World.Events.addSpecialEvent(_encounter.m.Event);
				::World.State.getMenuStack().popAll(true);
				::Time.scheduleEvent(::TimeUnit.Real, 100, function ( _tag ) {
					::World.State.setPause(false);
				}, null);
				::World.Encounters.clearActiveEvent();
			} else {
				if (_playSound && ::Const.Events.GlobalSound != "")
					::Sound.play(::Const.Events.GlobalSound, 1.0);

				this.m.WorldTownScreen.hideAllDialogs();
				this.m.EventScreen.setIsEncounter(true);
				this.m.EventScreen.show(_encounter);
				this.m.MenuStack.push(function () {
					this.m.EventScreen.hide();
					this.m.WorldTownScreen.showLastActiveDialog();
					this.m.EventScreen.setIsEncounter(false);
					this.m.WorldTownScreen.refresh();
				}, function () {
					return false;
				});
			}
		}
	}

	/**
	 * Adds convenience method to world state to mimic original
	 * Shows encouter dialog while in camp
	 */
	o.showEncounterScreenFromCamp <- function (_encounter, _playSound = true) {
		if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
		{
			if (::isKindOf(_encounter, "encounter_event")) {
				::World.Events.addSpecialEvent(_encounter.m.Event);
				::World.State.getMenuStack().popAll(true);
				::Time.scheduleEvent(::TimeUnit.Real, 100, function ( _tag ) {
					::World.State.setPause(false);
				}, null);
				::World.Encounters.clearActiveEvent();
			} else {
				if (_playSound && ::Const.Events.GlobalSound != "")
					::Sound.play(::Const.Events.GlobalSound, 1.0);

				this.m.CampScreen.hide();
				this.m.EventScreen.setIsEncounter(true);
				this.m.EventScreen.show(_encounter);
				this.m.MenuStack.push(function() {
					this.m.EventScreen.hide();
					this.m.CampScreen.show();
					this.m.EventScreen.setIsEncounter(false);
					this.m.WorldTownScreen.refresh();
				}, function() {
					return false;
				});
			}
		}
	}

	/**
	 * Adds convenience method to world state to mimic original
	 * Shows event dialog while in camp
	 */
	o.showEventScreenFromCamp <- function ( _event, _isContract = false, _playSound = true )
	{
		if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
		{
			if (_playSound && this.Const.Events.GlobalSound != "")
			{
				this.Sound.play(this.Const.Events.GlobalSound, 1.0);
			}

			this.m.CampScreen.hide();
			this.m.EventScreen.setIsContract(_isContract);
			this.m.EventScreen.show(_event);
			this.m.MenuStack.push(function () {
				this.m.EventScreen.hide();
				this.m.EventScreen.setIsContract(false);
				this.m.CampScreen.show();
				this.m.WorldTownScreen.refresh();
			}, function () {
				return false;
			});
		}
	}

	o.showCombatDialog = function ( _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true, _properties = null, _pos = null )
	{
		// fix guest roster positions before every battle
		local freeSlots = ::Legends.S.getEmptySlotsInFormation();
		foreach(bro in ::World.getGuestRoster().getAll()) {
			bro.setPlaceInFormation(freeSlots.pop());
		}

		local entities = [];
		local allyBanners = [];
		local enemyBanners = [];
		local hasOpponents = false;
		local listEntities = _isCombatantsVisible && (_isPlayerInitiated || ::World.Assets.getOrigin().getID() == "scenario.rangers" || this.Const.World.TerrainTypeLineBattle[this.m.Player.getTile().Type] && ::World.getTime().IsDaytime);

		if (_pos == null)
		{
			_pos = this.m.Player.getPos();
		}

		if (_properties != null)
		{
			allyBanners = _properties.AllyBanners;
			enemyBanners = _properties.EnemyBanners;
		}

		if (allyBanners.len() == 0)
		{
			allyBanners.push(::World.Assets.getBanner());
		}

		if (!_isPlayerInitiated && ::World.Camp.isCamping())
		{
			_allowFormationPicking = false;
		}

		if (!_isPlayerInitiated && !this.Const.World.TerrainTypeLineBattle[this.m.Player.getTile().Type])
		{
			_allowFormationPicking = false;
		}

		local champions = [];
		local entityTypes = [];
		entityTypes.resize(this.Const.EntityType.len(), 0);

		if (_properties != null)
		{
			_properties.IsPlayerInitiated = _isPlayerInitiated;
		}

		if (_properties == null)
		{
			local parties = ::World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance);
			local isAtUniqueLocation = false;

			if (parties.len() <= 1)
			{
				this.m.EngageCombatPos = null;
				return;
			}

			foreach( party in parties )
			{
				if (!party.isAlive() || party.isPlayerControlled())
				{
					continue;
				}

				if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
				{
					continue;
				}

				if (party.isLocation() && party.isShowingDefenders() && party.getCombatLocation().Template[0] != null && party.getCombatLocation().Fortification != 0 && !party.getCombatLocation().ForceLineBattle)
				{
					entities.push({
						Name = "Fortifications",
						Icon = "palisade_01_orientation",
						Overlay = null
					});
				}

				if (party.isLocation() && party.isLocationType(this.Const.World.LocationType.Unique))
				{
					isAtUniqueLocation = true;
					break;
				}

				if (party.isInCombat())
				{
					parties = ::World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance * 2.0);
					break;
				}
			}

			foreach( party in parties )
			{
				if (!party.isAlive() || party.isPlayerControlled())
				{
					continue;
				}

				if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
				{
					continue;
				}

				if (isAtUniqueLocation && (!party.isLocation() || !party.isLocationType(this.Const.World.LocationType.Unique)))
				{
					continue;
				}

				if (party.isAlliedWithPlayer())
				{
					if (party.getTroops().len() != 0 && allyBanners.find(party.getBanner()) == null)
					{
						allyBanners.push(party.getBanner());
					}

					continue;
				}
				else
				{
					hasOpponents = true;

					if (!party.isLocation() || party.isShowingDefenders())
					{
						if (party.getTroops().len() != 0 && enemyBanners.find(party.getBanner()) == null)
						{
							enemyBanners.push(party.getBanner());
						}
					}
				}

				if (party.isLocation() && !party.isShowingDefenders())
				{
					entityTypes.resize(this.Const.EntityType.len(), 0);
					break;
				}

				party.onBeforeCombatStarted();
				local troops = party.getTroops();

				foreach( t in troops )
				{
					if (t.Script.len() != "")
					{
						if (t.Variant != 0)
						{
							champions.push(t);
						}
						else
						{
							++entityTypes[t.ID];
						}
					}
				}
			}
		}
		else
		{
			foreach( t in _properties.Entities )
			{
				if (!hasOpponents && (!::World.FactionManager.isAlliedWithPlayer(t.Faction) || _properties.TemporaryEnemies.find(t.Faction) != null))
				{
					hasOpponents = true;
				}

				if (t.Variant != 0)
				{
					champions.push(t);
				}
				else
				{
					++entityTypes[t.ID];
				}
			}
		}

		foreach( c in champions )
		{
			entities.push({
				Name = c.Name,
				Icon = this.Const.EntityIcon[c.ID],
				Overlay = "icons/miniboss.png"
			});
		}

		for( local i = 0; i < entityTypes.len(); i = ++i )
		{
			if (entityTypes[i] > 0)
			{
				if (entityTypes[i] == 1)
				{
					local start = this.isFirstCharacter(this.Const.Strings.EntityName[i], [
						"A",
						"E",
						"I",
						"O",
						"U"
					]) ? "An " : "A ";
					entities.push({
						Name = start + this.removeFromBeginningOfText("The ", this.Const.Strings.EntityName[i]),
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
				else if (::Legends.Mod.ModSettings.getSetting("ExactEngageNumbers").getValue())
				{
					entities.push({
						Name = entityTypes[i] + " " + this.Const.Strings.EntityNamePlural[i],
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
				else
				{
					entities.push({
						Name =  getEngageNumberNames(entityTypes[i]) + " " + this.Const.Strings.EntityNamePlural[i],
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
			}
		}

		if (!hasOpponents)
		{
			this.m.EngageCombatPos = null;
			return;
		}

		local text = "";

		if (!listEntities || entities.len() == 0)
		{
			entities = [];
			allyBanners = [];
			enemyBanners = [];

			if (!_isPlayerInitiated)
			{
				text = "You can\'t make out who is attacking you in time.<br/>You have to defend yourself!";
			}
			else
			{
				text = "You can\'t make out who you\'ll be facing. Attack at your own peril and be prepared to retreat if need be!";
			}
		}

		local tile = ::World.getTile(::World.worldToTile(_pos));
		local image = this.Const.World.TerrainTacticalImage[tile.TacticalType];

		if (!::World.getTime().IsDaytime)
		{
			image = image + "_night";
		}

		image = image + ".png";
		this.setAutoPause(true);
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.EngageCombatPos = _pos;
		this.m.EngageByPlayer = _isPlayerInitiated;
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.CombatDialog.show(entities, allyBanners, enemyBanners, _isPlayerInitiated || this.m.EscortedEntity != null, _allowFormationPicking, text, image, this.m.EscortedEntity != null ? "Flee!" : "Fall back!");
		this.m.MenuStack.push(function ()
		{
			this.m.EngageCombatPos = null;
			this.m.CombatDialog.hide();
			this.m.WorldScreen.show();
			this.stunPartiesNearPlayer(_isPlayerInitiated);
			this.setAutoPause(false);
		}, function ()
		{
			return !this.m.CombatDialog.isAnimating();
		}, _isPlayerInitiated);
	}

	local onBeforeSerialize = o.onBeforeSerialize;
	o.onBeforeSerialize = function ( _out )
	{
		local meta = _out.getMetaData();
		meta.setString("legendsVersion", ::Legends.Version);
		onBeforeSerialize( _out );
	}

	local onBeforeDeserialize = o.onBeforeDeserialize;
	o.onBeforeDeserialize = function ( _in )
	{
		onBeforeDeserialize( _in );
		this.logInfo("Legends version in save: " + _in.getMetaData().getString("legendsVersion"));
		this.logInfo("Current Legends version: " + ::Legends.Version);
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		::World.Encounters.onSerialize(_out);
		onSerialize(_out);
		::World.Camp.onSerialize(_out);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		::World.Encounters.onDeserialize(_in);
		onDeserialize(_in);
		if (this.m.EscortedEntity == null) {
			::World.State.setCampingAllowed(true);
			::World.State.setEscortedEntity(null);
			::World.State.getPlayer().setVisible(true);
			::World.Assets.setUseProvisions(true);
		}

		::World.Camp.clear();
		::World.Camp.onDeserialize(_in);
		onCalculatePlayerPartyModifiers();
	}
});
