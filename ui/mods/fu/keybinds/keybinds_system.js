FU.Keybinds = {
	KeybindsByMod : {},
	PressedKeys : {},

	setKeybinds : function(_keybinds)
	{
		var self = this;
		_keybinds.forEach(function(keybind)
		{
			self.addKeybindFromSQ(keybind.modID, keybind.id, keybind.keyCombinations);
		});
	},

	addKeybindFromSQ : function( _modID, _id, _keyCombinations )
	{
		if (!(_modID in this.KeybindsByMod))
		{
			this.KeybindsByMod[_modID] = {};
		}
		this.KeybindsByMod[_modID][_id] = new FU.Keybind(_modID, _id, _keyCombinations);
	},

	removeKeybind : function( _modID, _id )
	{
		delete this.KeybindsByMod[_modID][_id];
		if (Object.keys(this.KeybindsByMod[_modID]).length === 0)
		{
			delete this.KeybindsByMod[_modID];
		}
	},

	getPressedKeysAsString : function( _excludeKey )
	{
		var key = '';
		Object.keys(this.PressedKeys).forEach(function(pressedKeyID)
		{
			if (_excludeKey != pressedKeyID)
			{
				key += pressedKeyID + "+";
			}
		});
		return key;
	},

	updatePressedKeys : function( _key, _release )
	{
		if (!_release)
		{
			if (_key in this.PressedKeys)
			{
				return true;
			}
			this.PressedKeys[_key] = 1;
		}
		else
		{
			if (_key in this.PressedKeys)
			{
				delete this.PressedKeys[_key];
			}
		}
		return false;
	},

	isMousebindPressed : function( _modID, _id, _event )
	{
		var key = FU.Key.MouseMapJS[event.button];
		return this.isPressed(_modID, _id, key);
	},

	isKeybindPressed : function( _modID, _id, _event )
	{
		var key = FU.Key.KeyMapJS[_event.keyCode];
		return this.isPressed(_modID, _id, key);
	},

	isPressed : function( _modID, _id, _key )
	{
		if (!(_modID in this.KeybindsByMod)) console.error("Unknown Mod ID: " + _modID);
		if (!(_id in this.KeybindsByMod[_modID])) console.error("Unknown Keybind ID: " + _id);
		var keyCombinations = this.KeybindsByMod[_modID][_id].getRawKeyCombinations();
		var currentKeyCombination = this.getPressedKeysAsString(_key);
		currentKeyCombination = FU.Key.sortKeyString(currentKeyCombination) + _key;
		if (FU.getSettingValue("mod_FU", "keybindsLog"))
		{
			console.error("Checking Key combination: " + currentKeyCombination)
		}
		for (var i = 0; i < keyCombinations.length; i++)
		{
			if (keyCombinations[i] == currentKeyCombination)
			{
				return true;
			}
		}
		return false;
	},
};
