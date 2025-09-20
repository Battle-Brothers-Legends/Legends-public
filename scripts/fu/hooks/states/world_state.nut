::mods_hookExactClass("states/world_state", function(o) {
	local onInitUI = o.onInitUI;
	o.onInitUI = function()
	{
		onInitUI();
		local mainMenuModule = this.m.WorldMenuScreen.getMainMenuModule();
		mainMenuModule.setOnModOptionsPressedListener(this.main_menu_module_onModOptionsPressed.bindenv(this));
	}

	o.main_menu_module_onModOptionsPressed <- function()
	{
		::FU.SettingsScreen.setOnCancelPressedListener(this.FU_settings_screen_onCancelPressed.bindenv(this));
		::FU.SettingsScreen.setOnSavePressedListener(this.FU_settings_screen_onSavepressed.bindenv(this));
		this.toggleMenuScreen();
		this.setAutoPause(true);
		this.m.WorldScreen.hide();
		::FU.SettingsScreen.show(::FU.SettingsFlags.World);
		this.m.MenuStack.push(function ()
		{
			::FU.SettingsScreen.hide();
			this.m.WorldScreen.show();
			this.setAutoPause(false);
			this.toggleMenuScreen();
		}, function ()
		{
			return !::FU.SettingsScreen.isAnimating();
		});
	}

	o.FU_settings_screen_onCancelPressed <- function()
	{
		this.m.MenuStack.pop();
	}

	o.FU_settings_screen_onSavepressed <- function( _data )
	{
		::FU.System.ModSettings.updateSettingsFromJS(_data);
		this.m.MenuStack.pop();
	}

	o.getLocalCombatProperties = function( _pos, _ignoreNoEnemies = false )
	{
		local raw_parties = ::World.getAllEntitiesAtPos(_pos, ::Const.World.CombatSettings.CombatPlayerDistance);
		local parties = [];
		local properties = ::Const.Tactical.CombatInfo.getClone();
		local tile = ::World.getTile(::World.worldToTile(_pos));
		local isAtUniqueLocation = false;
		properties.TerrainTemplate = ::Const.World.TerrainTacticalTemplate[tile.TacticalType];
		properties.Tile = tile;
		properties.InCombatAlready = false;
		properties.IsAttackingLocation = false;
		local factions = array(256, 0); // This is the part that FU changes

		foreach (party in raw_parties)
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (party.isLocation() && party.isLocationType(::Const.World.LocationType.Unique))
			{
				isAtUniqueLocation = true;
				break;
			}

			if (party.isInCombat())
			{
				raw_parties = ::World.getAllEntitiesAtPos(_pos, ::Const.World.CombatSettings.CombatPlayerDistance * 2.0);
				break;
			}
		}

		foreach (party in raw_parties)
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (isAtUniqueLocation && (!party.isLocation() || !party.isLocationType(::Const.World.LocationType.Unique)))
			{
				continue;
			}

			if (!_ignoreNoEnemies)
			{
				local hasOpponent = false;

				foreach (other in raw_parties)
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

		foreach (party in parties)
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

			foreach (t in troops)
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

		foreach (i, f in factions)
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

	local onBeforeSerialize = o.onBeforeSerialize;
	o.onBeforeSerialize = function( _out )
	{
		onBeforeSerialize(_out);
		local meta = _out.getMetaData();
		local modIDsString = "";
		foreach (mod in ::FU.System.Serialization.Mods)
		{
			meta.setString(mod.getID() + "Version", mod.getVersionString());
			::FU.Mod.Debug.printLog(format("FU Serialization: Saving %s (%s), Version: %s", mod.getName(), mod.getID(), mod.getVersionString()));
		}
		foreach (mod in ::mods_getRegisteredMods()) modIDsString += mod.Name + ",";
		meta.setString("FU.SavedModIDs", modIDsString.slice(0, -1));
	}

	local onBeforeDeserialize = o.onBeforeDeserialize;
	o.onBeforeDeserialize = function( _in )
	{
		onBeforeDeserialize(_in);

		if (::FU.Mod.Serialization.isSavedVersionAtLeast("1.1.0", _in.getMetaData()))
		{
			local modIDs = split(_in.getMetaData().getString("FU.SavedModIDs"), ",");
			local hooksMods = ::mods_getRegisteredMods();
			foreach (mod in hooksMods)
			{
				local IDIdx = modIDs.find(mod.Name);
				if (IDIdx != null)
				{
					modIDs.remove(IDIdx);
					if (::FU.System.Registry.hasMod(mod.Name))
					{
						local oldVersion = _in.getMetaData().getString(mod.Name + "Version");
						if (oldVersion == "")
						{
							::logInfo(format("FU Serialization: First time this save has been loaded with an FU version of %s (%s)", mod.FriendlyName, mod.Name));
						}
						else
						{
							local FUMod = ::FU.System.Registry.getMod(mod.Name);
							switch (::FU.SemVer.compare(FUMod, ::FU.SemVer.getTable(oldVersion)))
							{
								case 1:
									::logInfo(format("FU Serialization: Loading old save for %s (%s), %s -> %s", FUMod.getName(), FUMod.getID(), oldVersion, FUMod.getVersionString()));
									break;
								case 0:
									::FU.Mod.Debug.printLog(format("FU Serialization: Loading %s (%s), version %s", FUMod.getName(), FUMod.getID(), FUMod.getVersionString()));
									break;
								case -1:
									::logWarning(format("FU Serialization: Loading save from newer version for %s (%s), %s -> %s", FUMod.getName(), FUMod.getID(), oldVersion, FUMod.getVersionString()));
									break;
							}
						}
					} // else hooks mod loaded that already existed in save
				}
				else
				{
					::logWarning(format("FU Serialization: First time this save is being loaded with %s (%s)", mod.FriendlyName, mod.Name));
				}
			}

			foreach (id in modIDs)
			{
				::logWarning(format("FU Serialization: This save was made while using %s but is being loaded without it.", id));
			}
		}
		else // pre 1.1.0 legacy save support (should be removed in the future)
		{
			foreach (mod in ::FU.System.Serialization.Mods)
			{
				local oldVersion = _in.getMetaData().getString(mod.getID() + "Version");
				if (oldVersion == "")
				{
					::logInfo(format("FU Serialization: First time loading this save with %s (%s)", mod.getName(), mod.getID()));
				}
				else
				{
					switch (::FU.SemVer.compare(mod, ::FU.SemVer.getTable(oldVersion)))
					{
						case 1:
							::logInfo(format("FU Serialization: Loading old save for %s (%s), %s -> %s", mod.getName(), mod.getID(), oldVersion, mod.getVersionString()));
							break;
						case 0:
							::FU.Mod.Debug.printLog(format("FU Serialization: Loading %s (%s), version %s", mod.getName(), mod.getID(), mod.getVersionString()));
							break;
						case -1:
							::logWarning(format("FU Serialization: Loading save from newer version for %s (%s), %s -> %s", mod.getName(), mod.getID(), oldVersion, mod.getVersionString()));
							break;
						default:
							::logError("Something has gone very wrong with FU Serialization");
							::FU.Log.printStackTrace();
					}
				}
			}
		}
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function( _out )
	{
		::FU.System.ModSettings.flagSerialize(_out);
		::World.Flags.set("FU.LastDayMorningEventCalled", ::World.Assets.getLastDayMorningEventCalled());
		onSerialize(_out);
		::FU.System.Serialization.clearFlags();
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function( _in )
	{
		onDeserialize(_in);
		if (::World.Flags.has("FU.LastDayMorningEventCalled"))
		{
			::World.Assets.setLastDayMorningEventCalled(::World.Flags.get("FU.LastDayMorningEventCalled"));
		}
		else
		{
			::World.Assets.setLastDayMorningEventCalled(::World.getTime().Days);
		}
		::FU.System.ModSettings.flagDeserialize(_in);
		::FU.System.Serialization.clearFlags();
	}

	local onKeyInput = o.onKeyInput;
	o.onKeyInput = function( _key )
	{
		if (!::FU.Key.isKnownKey(_key))
		{
			return onKeyInput(_key);
		}
		if (::FU.System.Keybinds.onKeyInput(_key, this, ::FU.Key.State.World) || ::FU.Mod.ModSettings.getSetting("SuppressBaseKeybinds").getValue())
		{
			return false;
		}
		return onKeyInput(_key);
	}

	local onMouseInput = o.onMouseInput;
	o.onMouseInput = function( _mouse )
	{
		if (!::FU.Key.isKnownMouse(_mouse))
		{
			return onMouseInput(_mouse);
		}
		if (::FU.System.Keybinds.onMouseInput(_mouse, this, ::FU.Key.State.World))
		{
			return false;
		}
		return onMouseInput(_mouse);
	}
});
