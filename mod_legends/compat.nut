foreach(mod in ::Legends.Compat.HardIncompat.List) {
	if (!::Hooks.hasMod(mod.ID))
		continue;
	local name = ::Hooks.getMod(mod.ID).Name;
	local modVersion = ::Legends.Compat.normalizeVersion(::Hooks.getMod(mod.ID).getVersion().tostring());
	local text = ::format("%s(%s)<br>is NOT compatible and will crash your game.", name, mod.ID);
	if (mod.Version != null) {
		local knownVersion = ::Legends.Compat.normalizeVersion(mod.Version);
		if (::MSU.SemVer.compare(::MSU.SemVer.getTable(modVersion), ::MSU.SemVer.getTable(knownVersion)) > 0)
			text += "<br>However, your version is newer than one we confirmed not working, it might work, but there's no guarantee."
	}
	if (mod.Replacement != null)
		text += "<br>" + mod.Replacement;
	::Legends.Mod.Debug.addPopupMessage(text, ::MSU.Popup.State.Full);
}

foreach (mod in ::Legends.Compat.IncompatNotRegistered.List) {
	local files = mod.Files;
	local name = mod.ID;
	local foundFiles = 0;
	foreach (file in files) {
		local lastSlash = file.find("/");
		local index = lastSlash;
		while (index != null) {
			lastSlash = index;
			index = file.find("/", lastSlash + 1);
		}

		local expectedScript = ::split(file, ".")[0];
		local scriptFiles = this.IO.enumerateFiles(file.slice(0, lastSlash));
		if (scriptFiles == null)
			continue;
		foreach(scriptFile in scriptFiles) {
			if (expectedScript == scriptFile) {
				foundFiles++;
				break;
			}
		}
	}

	if (foundFiles != 0 && foundFiles == files.len()) {
		local text = ::format("%s<br>is NOT compatible and will crash your game.", name);
		if (mod.Replacement != null)
			text += "<br>" + mod.Replacement;
		::Legends.Mod.Debug.addPopupMessage(text, ::MSU.Popup.State.Full);
	}
}

foreach(mod in ::Legends.Compat.SoftIncompat.List) {
	if (!::Hooks.hasMod(mod.ID))
		continue;
	local name = ::Hooks.getMod(mod.ID).Name;
	local modVersion = ::Legends.Compat.normalizeVersion(::Hooks.getMod(mod.ID).getVersion().tostring());
	local text = ::format("%s(%s)<br>is compatible but might cause weird issues, use at your own risk.", name, mod.ID);
	if (mod.Version != null) {
		local knownVersion = ::Legends.Compat.normalizeVersion(mod.Version);
		if (::MSU.SemVer.compare(::MSU.SemVer.getTable(modVersion), ::MSU.SemVer.getTable(knownVersion)) > 0)
			text += "<br>However, your version is newer than one we confirmed not working, it might work, but there's no guarantee."
	}
	if (mod.Replacement != null)
		text += "<br>" + mod.Replacement;
	::Legends.Mod.Debug.addPopupMessage(text, ::MSU.Popup.State.Full);
}

foreach(mod in ::Legends.Compat.IncompatButPatched.List) {
	if (!::Hooks.hasMod(mod.ID))
		continue;
	local hasPatch = mod.PatchID != null && ::Hooks.hasMod(mod.PatchID);
	if (hasPatch)
		continue;

	local name = ::Hooks.getMod(mod.ID).Name;
	local text = ::format("%s(%s)<br>is NOT compatible, but has patch %s", name, mod.ID, mod.Patch);
	::Legends.Mod.Debug.addPopupMessage(text, ::MSU.Popup.State.Full);
}

foreach (mod in ::Legends.Compat.OtherVersionCompat.List) {
	if (!::Hooks.hasMod(mod.ID))
		continue;
	local version = ::Legends.Compat.normalizeVersion(::Hooks.getMod(mod.ID).getVersion().tostring());
	local isVersionCompat = false;
	foreach(v in mod.Version) {
		local knownVersion = ::Legends.Compat.normalizeVersion(v);
		if (::MSU.SemVer.compare(::MSU.SemVer.getTable(knownVersion), ::MSU.SemVer.getTable(version)) == 0) {
			isVersionCompat = true;
			break;
		}
	}
	if (isVersionCompat)
		continue;

	local name = ::Hooks.getMod(mod.ID).Name;
	local text = ::format("%s(%s)<br>is NOT compatible, but has different version(s) that might work, check ", name, mod.ID);
	foreach (version in mod.Version) {
		text += version + ",";
	}
	::Legends.Mod.Debug.addPopupMessage(text, ::MSU.Popup.State.Full);
}

foreach (mod in ::Legends.Compat.Integrated) {
	if (!::Hooks.hasMod(mod))
		continue;
	::Legends.Mod.Debug.addPopupMessage(::format("%s is integrated into Legends, please remove it.", mod), ::MSU.Popup.State.Full);
}
