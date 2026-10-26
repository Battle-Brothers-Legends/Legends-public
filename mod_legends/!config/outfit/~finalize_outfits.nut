if (!("Items" in ::Legends)) {
	::Legends.Items <- {};
}

/**
* Picks one of legends armors
* @param _list in form of weighted list [[1, "relative/path/to/script"]]
*/
::Legends.Items.pickLegendArmor <- @(_list) ::Legends.Items.pickItem(_list, "scripts/items/legend_armor/");
::Const.World.Common.pickLegendArmor <- function(_list) {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.pickLegendArmor deprecated, will be removed in 19.6, use ::Legends.Items.pickLegendArmor instead");
	return ::Legends.Items.pickLegendArmor(_list);
}

/**
* Picks one of legends helmets
* @param _list in form of weighted list [[1, "relative/path/to/script"]]
*/
::Legends.Items.pickLegendHelmet <- @(_list) ::Legends.Items.pickItem(_list, "scripts/items/legend_helmets/");
::Const.World.Common.pickLegendHelmet <- function(_list) {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.pickLegendHelmet deprecated, will be removed in 19.6, use ::Legends.Items.pickLegendHelmet instead");
	return ::Legends.Items.pickItem(_list, "scripts/items/legend_helmets/");
}

/**
* Picks one from the list of items
* @param _list in form of weighted list     [[1, "relative/path/to/script"]]
* or nested with lambdas:                   [[1, @() [[1, "relative/path/to/script"]]]]
* or a function that returns item           [[1, @() ::new("path/to/script")]
* @param _script base path to script or a function that returns item object
*/
::Legends.Items.pickItem <- function(_list, _script = "") {
	local candidates = _list.filter(@(idx, t) t[0] > 0);
	if (!candidates.len())
		return null;

	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);
	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);

	if (!selected.len())
		return null;
	selected = selected[0];

	if (typeof(selected[1]) == "function") {
		local result = selected[1]();
		if (typeof(result) == "array")
			return this.pickItem(result, _script);
		if (selected.len() == 3)
			result.setVariant((typeof(selected[2]) == "array") ? selected[2][::Math.rand(0, selected[2].len() - 1)] : selected[2]);
		return result;
	}

	if (_script == "")
		return selected[1];

	if (selected[1] == "" || selected[1] == null)
		return null;

	local ret = ::new(_script + selected[1]);
	if (selected.len() == 3)
		ret.setVariant((typeof(selected[2]) == "array") ? selected[2][::Math.rand(0, selected[2].len() - 1)] : selected[2]);
	return ret;
}

::Const.World.Common.pickItem <- function(_list, _script = "") {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.pickItem deprecated, will be removed in 19.6, use ::Legends.Items.pickItem instead");
	return ::Legends.Items.pickItem(_list, _script);
}

/**
* Picks one of predefined helmets
* @param _list in form of weighted list, can be either of:
* - [[1, "helmetID"]]
* - [[1, ::Legends.Helmet.X]]
* there are also optional parameters
* - [[<weight>, <helmetID|const>, <variant>]]
* Variant can be an array, in this case a random variant will be picked out of the array.
*/
::Legends.Items.pickHelmet <- function(_helms) {
	local candidates = _helms.filter(@(idx, t) t[0] > 0);
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);

	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);

	if (!selected.len())
		return null;
	selected = selected[0];

	local helm = selected[1];
	//Disabling helmet layers temporarily
	if (helm == "")
		return null;
	// return ::new("scripts/items/helmets/" + helm);

	local v = (selected.len() == 3) ? selected[2] : null;
	local variant = (typeof(v) == "array") ? v[::Math.rand(0, v.len() - 1)] : v;

	local layersObj = typeof(helm) == "string" ? ::Const.LegendMod.Helmets[helm] : helm;
	if (layersObj.Script != "") {
		local helmet = ::new(layersObj.Script);
		if (variant != null) {
			helmet.setupArmor(variant);
		}
		return helmet;
	}

	local set = layersObj.Sets[::Math.rand(0, layersObj.Sets.len() - 1)];
	local helmet = ::Legends.Items.pickLegendHelmet(set.Hoods);
	if (helmet != null) {
		if (variant != null) {
			//this doesn't set variant properly for things like [1, "hood", 63] in cripple_background file
			if (helm == "greatsword_faction_helm" || helm == ::Legends.Helmet.Standard.greatsword_faction_helm)
				helmet.setupArmor(variant);
		}

		local applyUpgradeIfExists = function(_slot) {
			local item = ::Legends.Items.pickLegendHelmet(_slot);
			if (item != null)
				helmet.setUpgrade(item);
		};

		applyUpgradeIfExists(set.Helms);
		applyUpgradeIfExists(set.Tops);
		applyUpgradeIfExists(set.Vanity);
		if ("Vanity2" in set)
			applyUpgradeIfExists(set.Vanity2);
	}
	return helmet;
}


::Const.World.Common.pickHelmet <- function(_helms) {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.pickHelmet deprecated, will be removed in 19.6, use ::Legends.Items.pickHelmet instead");
	return ::Legends.Items.pickHelmet(_helms);
}

/**
* Picks one of predefined armors
* @param _list in form of weighted list, can be either of:
* - [[1, "armorID"]]
* - [[1, ::Legends.Armor.X]]
* there are also optional paramters
* - [[<weight>, <armorID|const>, <variant>, <faction>]]
* TODO <variant> seems to be unused?
*/
::Legends.Items.pickArmor <- function(_armors) {
	local candidates = _armors.filter(@(idx, t) t[0] > 0);
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);

	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);

	if (!selected.len())
		return null;
	selected = selected[0];

	local armorID = selected[1];
	local faction = selected.len() == 4 ? selected[3] : null;
	if (armorID == "")
		return null;

	if (!(armorID in ::Const.LegendMod.Armors) && typeof(armorID) == "string")
		return ::new("scripts/items/armor/" + armorID);

	local layersObj = typeof(armorID) == "string" ? ::Const.LegendMod.Armors[armorID] : armorID;
	if (layersObj.Script != "") {
		local item = ::new(layersObj.Script);
		if (faction != null) {
			item.setupArmor(faction);
		}
		return item;
	}

	local set = layersObj.Sets[::Math.rand(0, layersObj.Sets.len() - 1)];
	local armor = ::Legends.Items.pickLegendArmor(set.Cloth);
	if (armor == null && typeof(armorID) == "string")
		return ::new("scripts/items/armor/" + armorID);

	if (faction != null) {
		armor.setupArmor(faction);
	}

	local applyUpgradeIfExists = function(_slot) {
		local item = ::Legends.Items.pickLegendArmor(_slot);
		if (item != null)
			armor.setUpgrade(item);
	};

	applyUpgradeIfExists(set.Chain);
	applyUpgradeIfExists(set.Plate);
	applyUpgradeIfExists(set.Cloak);
	applyUpgradeIfExists(set.Tabard);
	applyUpgradeIfExists(set.Attachments);

	return armor;
}

::Const.World.Common.pickArmor <- function(_armors) {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.pickArmor deprecated, will be removed in 19.6, use ::Legends.Items.pickArmor instead");
	return ::Legends.Items.pickArmor(_armors);
}

/**
* Picks one of armor upgrades
* @param _list in form of weighted list, can be either of:
* - [[1, "relative/path/to/upgrade"]]
*/
::Legends.Items.pickArmorUpgrade <- function(_armors) {
	local candidates = _armors.filter(@(idx, t) t[0] > 0);
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);

	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);
	if (!selected.len())
		return null;
	local armorID = selected[0][1];

	if (!(armorID in ::Const.LegendMod.Armors))
		return ::new("scripts/items/armor_upgrades/" + armorID);

	local layersObj = ::Const.LegendMod.Armors[armorID];
	if (layersObj.Script != "")
		return ::new(layersObj.Script);

	return null;
}

::Const.World.Common.pickArmorUpgrade <- function(_armors) {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.pickArmorUpgrade deprecated, will be removed in 19.6, use ::Legends.Items.pickArmorUpgrade instead");
	return ::Legends.Items.pickArmorUpgrade(_armors);
}

/**
* Operating assuming that if we have chance not -1 we sent in an armor and helmet array that aren't null
* @param _outfitArr
* [
* 	[1, "outfitID"]
*	[1, ::Legends.Outfit.X]
* ]
* @param _armorArr same, but with armors
* @param _helmetArr same, but with helmets
*/
::Legends.Items.pickOutfit <- function(_outfitArr, _armorArr = null, _helmetArr = null, _chance = 0) {
	if (_chance != 0 && ::Math.rand(1, 100) >= _chance) {
		return [::Legends.Items.pickArmor(_armorArr), ::Legends.Items.pickHelmet(_helmetArr)]
	} else if (_armorArr != null && _helmetArr != null && _armorArr.len() > 0 && _helmetArr.len() > 0) {
		local armorCount = _armorArr.filter(@(idx, t) t[0] > 0).len();
		local helmCount = _helmetArr.filter(@(idx, t) t[0] > 0).len();
		local outfitCount = _outfitArr.filter(@(idx, t) t[0] > 0).len();

		if (::Math.rand(1, armorCount * helmCount) > outfitCount) {
			return [::Legends.Items.pickArmor(_armorArr), ::Legends.Items.pickHelmet(_helmetArr)]
		}
	}

	local candidates = _outfitArr.filter(@(idx, t) t[0] > 0);
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);

	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);
	local outfitID = selected.len() > 0 ? selected[0][1] : "";

	local layersObj = typeof(outfitID) == "string" ? ::Const.LegendMod.Outfits[outfitID] : outfitID;
	return [::Legends.Items.pickArmor(layersObj.Body), ::Legends.Items.pickHelmet(layersObj.Helmet)];
}

::Const.World.Common.pickOutfit <- function(_outfitArr, _armorArr = null, _helmetArr = null, _chance = 0) {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.pickOutfit deprecated, will be removed in 19.6, use ::Legends.Items.pickOutfit instead");
	return ::Legends.Items.pickOutfit(_outfitArr, _armorArr, _helmetArr, _chance);
}

/**
* Automatic conversion of vanilla and legends names to outfits
*/
::Legends.Items.convNameToList <- function(_named) {
	local findString = ["helmets/", "armor/", "legend_armor/", "legend_helmets/"];
	foreach (search in findString) {
		if (_named[0].find(search) != null) {
			return _named.map(@(item) [1, item.slice(item.find(search) + search.len())]);
		}
	}
	return [];
}

::Const.World.Common.convNameToList <- function(_named) {
	// TODO remove with 19.6
	::logWarning("::Const.World.Common.convNameToList deprecated, will be removed in 19.6, use ::Legends.Items.convNameToList instead");
	return ::Legends.Items.convNameToList(_named);
}
