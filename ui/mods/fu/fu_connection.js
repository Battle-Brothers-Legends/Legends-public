var FUConnection = function ()
{
	FUBackendConnection.call(this);
};

FUConnection.prototype = Object.create(FUBackendConnection.prototype);
Object.defineProperty(FUConnection.prototype, 'constructor', {
	value: FUConnection,
	enumerable: false,
	writable: true
});

FUConnection.prototype.onQuerySettingsData = function (_data)
{
	FU.Keybinds.setKeybinds(_data.keybinds);
	Screens.ModSettingsScreen.setSettings(_data.settings);
};

FUConnection.prototype.removeKeybind = function (_keybind)
{
	FU.Keybinds.removeKeybind(_keybind.modID, _keybind.id);
};

FUConnection.prototype.addKeybind = function (_keybind)
{
	FU.Keybinds.addKeybindFromSQ(_keybind.modID, _keybind.id, _keybind.keyCombinations);
};

FUConnection.prototype.clearKeys = function ()
{
	FU.Keybinds.PressedKeys = {};
}

FUConnection.prototype.getUpdateCheckPromise = function (_updateURL)
{
	var ret = $.Deferred();
	var xhttp = new XMLHttpRequest();
	xhttp.onloadend = function()
	{
		if (this.status == 200)
		{
			ret.resolve(JSON.parse(this.responseText).tag_name); // will (probably) need adjustment if we add more update sources (other than github)
			return;
		}
		ret.resolve(null);
	}
	xhttp.ontimeout = function()
	{
		ret.resolve(null);
	}
	xhttp.open('GET', _updateURL);
	xhttp.send();
	return ret;
}

FUConnection.prototype.checkForModUpdates = function (_mods)
{
	var self = this;
	var modIDs = [];
	var promises = [];
	$.each(_mods, function (_id, _version)
	{
		modIDs.push(_id);
		promises.push(self.getUpdateCheckPromise(_version));
	})
	$.when.apply($, promises).done(function()
	{
		var modVersions = {};
		var args = arguments
		modIDs.forEach(function(_modID, _i)
		{
			if (args[_i] != null) modVersions[_modID] = args[_i]
		})
		self.notifyBackendReceivedModVersions(modVersions);
	}).fail(function()
	{
		console.error("Something went wrong with FU Update checks");
	});
}

FUConnection.prototype.notifyBackendReceivedModVersions = function (_modVersions)
{
	SQ.call(this.mSQHandle, "receiveModVersions", _modVersions);
}

registerScreen("FUConnection", new FUConnection());
