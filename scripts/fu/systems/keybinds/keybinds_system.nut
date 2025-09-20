::FU.Class.KeybindsSystem <- class extends ::FU.Class.System
{
	KeybindsByKey = null;
	KeybindsByMod = null;
	KeybindsForJS = null;
	PressedKeys = null;
	KeysChanged = false;

	constructor()
	{
		base.constructor(::FU.SystemID.Keybinds);
		this.KeybindsByKey = {};
		this.KeybindsByMod = {};
		this.KeybindsForJS = {};
		this.PressedKeys = {};
	}

	function registerMod( _mod )
	{
		base.registerMod(_mod);
		if (!::FU.System.ModSettings.hasPanel(_mod.getID()))
		{
			::FU.System.ModSettings.registerMod(_mod);
		}

		_mod.Keybinds = ::FU.Class.KeybindsModAddon(_mod);

		::FU.System.ModSettings.getPanel(_mod.getID()).addPage(::FU.Class.SettingsPage("Keybinds"));

		this.KeybindsByMod[_mod.getID()] <- {};
		this.KeybindsForJS[_mod.getID()] <- {};
	}

	function add( _keybind, _makeSetting = true )
	{
		if (!(_keybind instanceof ::FU.Class.AbstractKeybind))
		{
			throw ::FU.Exception.InvalidType(_keybind);
		}
		if (_keybind instanceof ::FU.Class.KeybindJS)
		{
			if (::FU.UI.JSConnection.isConnected())
			{
				::FU.UI.JSConnection.addKeybind(_keybind);
			}
			this.KeybindsForJS[_keybind.getMod().getID()][_keybind.getID()] <- _keybind;
		}
		else if (_keybind instanceof ::FU.Class.KeybindSQ)
		{
			foreach (key in _keybind.getRawKeyCombinations())
			{
				::FU.Mod.Debug.printWarning(format("Adding keyCombination %s for keybind %s", key, _keybind.getID()), "keybinds")
				if (!(key in this.KeybindsByKey))
				{
					this.KeybindsByKey[key] <- [];
					::FU.Mod.Debug.printWarning("Creating Keybind array for key: " + key, "keybinds")
				}
				this.KeybindsByKey[key].push(_keybind);
			}
		}

		this.KeybindsByMod[_keybind.getMod().getID()][_keybind.getID()] <- _keybind;
		if (_makeSetting)
		{
			this.addKeybindSetting(_keybind);
		}
	}

	// Private
	function remove( _modID, _id )
	{
		::FU.Mod.Debug.printWarning("Removing Keybind" + this.KeybindsByMod[_modID][_id], "keybinds");
		local keybind = this.KeybindsByMod[_modID].rawdelete(_id);
		if (keybind instanceof ::FU.Class.KeybindJS)
		{
			this.KeybindsForJS[_modID].rawdelete(_id);
			::FU.UI.JSConnection.removeKeybind(keybind);
		}
		else if (keybind instanceof ::FU.Class.KeybindSQ)
		{
			foreach (key in keybind.getRawKeyCombinations())
			{
				this.KeybindsByKey[key].remove(this.KeybindsByKey[key].find(keybind));
				if (this.KeybindsByKey[key].len() == 0)
				{
					this.KeybindsByKey.rawdelete(key);
				}
			}
		}
		return keybind;
	}

	function update( _modID, _id )
	{
		local keybind = this.remove(_modID, _id);
		keybind.KeyCombinations = split(::FU.Key.sortKeyCombinationsString(::getModSetting(_modID, _id).getValue()), "/");
		this.add(keybind, false);
	}

	function call( _key, _environment, _state, _keyState )
	{
		if (!(_key in this.KeybindsByKey))
		{
			return;
		}

		foreach (keybind in this.KeybindsByKey[_key])
		{
			::FU.Mod.Debug.printWarning("Checking keybind: " + keybind.tostring(), "keybinds");
			if (!keybind.hasState(_state))
			{
				continue;
			}

			if (!keybind.callOnKeyState(_keyState))
			{
				continue;
			}

			::FU.Mod.Debug.printWarning("Calling keybind", "keybinds");
			if (keybind.call(_environment) == true)
			{
				::FU.Mod.Debug.printWarning("Returning after keybind call returned true.", "keybinds");
				return true;
			}
		}
	}

	function addKeybindSetting( _keybind )
	{
		::FU.System.ModSettings.getPanel(_keybind.getMod().getID()).getPage("Keybinds").addElement(_keybind.makeSetting());
	}

	function getJSKeybinds()
	{
		// ret = [
		// 	{
		// 		id = "modID",
		// 		keybinds = [
		// 			{
		// 				id = "keybindID",
		// 				keyCombinations = "x/y+z",
		// 				keyState = ::FU.Key.Keystate.Release
		// 			}
		// 		]
		// 	}
		// ]
		local ret = []
		foreach (mod in this.KeybindsForJS)
		{
			foreach (keybind in mod)
			{
				ret.push(keybind.getUIData());
			}
		}
		return ret;
	}

	function onKeyInput( _key, _environment, _state )
	{
		this.KeysChanged = true;
		local keyAsString = ::FU.Key.KeyMapSQ[_key.getKey().tostring()];
		local keyState;
		if (this.isKeyStateContinuous(_key))
		{
			keyState = ::FU.Key.KeyState.Continuous;
		}
		else
		{
			keyState = ::FU.Key.getKeyState(_key.getState())
		}
		return this.onInput(_key, _environment, _state, keyAsString, keyState);
	}

	function frameUpdate( _ = null ) # needs an empty default parameter since scheduleEvent uses .call(_env)
	{
		if (!this.KeysChanged && this.PressedKeys.len() != 0)
		{
			::FU.UI.JSConnection.clearKeys();
			this.PressedKeys = {};
		}
		this.KeysChanged = false;
		::Time.scheduleEvent(::TimeUnit.Real, 1, this.frameUpdate.bindenv(this), null);
	}

	function onMouseInput( _mouse, _environment, _state )
	{
		local keyAsString = ::FU.Key.MouseMapSQ[_mouse.getID().tostring()];
		return this.onInput(_mouse, _environment, _state, keyAsString, ::FU.Key.getMouseState(_mouse.getState()));
	}

	// Private
	function onInput( _key, _environment, _state, _keyAsString, _keyState )
	{
		local key = "";
		foreach (pressedKeyID, value in this.PressedKeys)
		{
			if (_keyAsString != pressedKeyID)
			{
				key += pressedKeyID + "+";
			}
		}
		key += _keyAsString;
		key = ::FU.Key.sortKeyString(key);
		::FU.Mod.Debug.printWarning("Final key string: " + key, "keybinds");
		return this.call(key, _environment, _state, _keyState);
	}

	function isKeyStateContinuous( _key )
	{
		// Assumes key is in KeyMapSQ
		local key = ::FU.Key.KeyMapSQ[_key.getKey().tostring()];

		if (_key.getState() == 1)
		{
			if (key in this.PressedKeys)
			{
				return true;
			}
			this.PressedKeys[key] <- 1;
		}
		else
		{
			if (key in this.PressedKeys) // in case the keypress started while tabbed out for example
			{
				delete this.PressedKeys[key];
			}
		}
		return false;
	}

	function isKeybindPressed( _modID, _id )
	{
		local keybind = this.KeybindsByMod[_modID][_id];
		foreach (rawKeyCombination in keybind.getRawKeyCombinations())
		{
			local keyCombination = split(rawKeyCombination, "+");
			if (keyCombination.len() != this.PressedKeys.len()) continue;
			local failedKeyCombination = false;
			foreach (key in keyCombination)
			{
				if (!(key in this.PressedKeys))
				{
					failedKeyCombination = true;
					break;
				}
			}
			if (failedKeyCombination) continue;
			return true;
		}
		return false;
	}

	function importPersistentSettings()
	{
		::FU.System.PersistentData.loadFileForEveryMod("Keybind");
	}

	// Deprecated, now handled over the mod settings system
	function updateFromPersistence( _modID, _id, _keyCombinations )
	{
		::FU.System.ModSettings.setSettingFromPersistence(_modID, _id, _keyCombinations);
	}
}
