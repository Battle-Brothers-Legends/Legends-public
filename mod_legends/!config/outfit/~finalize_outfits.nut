::Const.LegendMod.Armors <- {};
::Const.LegendMod.Helmets <- {};

foreach( i, v in ::Const.LegendMod.ArmorObjs)
	::Const.LegendMod.Armors[v.ID] <- v;

foreach (i, v in ::Const.LegendMod.HelmObjs)
	::Const.LegendMod.Helmets[v.ID] <- v;

foreach (i, v in ::Const.LegendMod.OutfitObjs)
	::Const.LegendMod.Outfits[v.ID] <- v;


/**
* Picks one of legends armors
* @param _list in form of weighted list [[1, "relative/patch/to/script"]]
*/
::Const.World.Common.pickLegendArmor <- function (_list) {
	return ::Const.World.Common.pickItem(_list, "scripts/items/legend_armor/");
}

/**
* Picks one of legends helmets
* @param _list in form of weighted list [[1, "relative/patch/to/script"]]
*/
::Const.World.Common.pickLegendHelmet <- function (_list) {
	return ::Const.World.Common.pickItem(_list, "scripts/items/legend_helmets/");
}

/**
* Picks one from the list of items
* @param _list in form of weighted list [[1, "relative/patch/to/script"]]
* @param _script base path to script
*/
::Const.World.Common.pickItem <- function (_list, _script = "")
{
	local candidates = _list.filter(@(idx, t) t[0] > 0);
	if (!candidates.len())
		return null;

	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);
	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);

	if (!selected.len())
		return null;
	selected = selected[0];

	if (_script == "")
		return selected[1];

	if (selected[1] == "" || selected[1] == null)
		return null;

	local ret = ::new(_script + selected[1]);
	if (selected.len() == 3)
		ret.setVariant(selected[2]);
	return ret;
}

/**
* Picks one of predefined helmets
* @param _list in form of weighted list, can be either of:
* - [[1, "helmetID"]]
* - [[1, ::Legends.Helmet.X]]
* there are also optional paramters
* - [[<weighh>, <helmetID|const>, <variant>]]
*/
::Const.World.Common.pickHelmet <- function (_helms)
{
	local candidates = _helms.filter(@(idx, t) t[0] > 0);
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);

	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);

	if (!selected.len())
		return null;
	selected = selected[0];

	local helm = selected[1];
	local variant = selected.len() == 3 ? selected[2] : null;

	//Disabling helmet layers temporariliy
	if (helm == "")
		return null;
	// return this.new("scripts/items/helmets/" + helm);

	local layersObj = typeof(helm) == "string" ? ::Const.LegendMod.Helmets[helm] : helm;
	if (layersObj.Script != "")
	{
		local helmet = this.new(layersObj.Script);
		if (variant != null)
		{
			helmet.setupArmor(variant);
		}
		return helmet;
	}

	local set = layersObj.Sets[this.Math.rand(0, layersObj.Sets.len() -1)];
	local helmet = this.Const.World.Common.pickLegendHelmet(set.Hoods);
	if (helmet != null)
	{
		if (variant != null)
		{
			if (helm == "greatsword_faction_helm" || helm == ::Legends.Helmet.Standard.greatsword_faction_helm) //this doesn't set variant properly for things like [1, "hood", 63] in cripple_background file
				helmet.setupArmor(variant);
		}

		local helm = this.Const.World.Common.pickLegendHelmet(set.Helms);
		if (helm != null)
		{
			helmet.setUpgrade(helm)
		}

		local top = this.Const.World.Common.pickLegendHelmet(set.Tops);
		if (top != null)
		{
			helmet.setUpgrade(top)
		}

		local van = this.Const.World.Common.pickLegendHelmet(set.Vanity);
		if (van != null)
		{
			helmet.setUpgrade(van)
		}

		if ("Vanity2" in set)
		{
			local van2 = this.Const.World.Common.pickLegendHelmet(set.Vanity2);
			if (van2 != null)
			{
				helmet.setUpgrade(van2)
			}
		}
	}

	return helmet;
}

/**
* Picks one of predefined armors
* @param _list in form of weighted list, can be either of:
* - [[1, "armorID"]]
* - [[1, ::Legends.Armor.X]]
* there are also optional paramters
* - [[<weighh>, <armorID|const>, <variant>, <faction>]]
* TODO <variant> seems to be unused?
*/
::Const.World.Common.pickArmor <- function (_armors)
{
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

	if (!(armorID in this.Const.LegendMod.Armors) && typeof(armorID) == "string")
		return this.new("scripts/items/armor/" + armorID);

	local layersObj = typeof(armorID) == "string" ? ::Const.LegendMod.Armors[armorID] : armorID;
	if (layersObj.Script != "") {
		local item = this.new(layersObj.Script);
		if (faction != null) {
			item.setupArmor(faction);
		}
		return item;
	}

	local set = layersObj.Sets[this.Math.rand(0, layersObj.Sets.len() -1)];
	local armor = ::Const.World.Common.pickLegendArmor(set.Cloth);
	if (armor == null && typeof(armorID) == "string")
		return this.new("scripts/items/armor/" + armorID);

	if (faction != null) {
		armor.setupArmor(faction);
	}

	local chain = ::Const.World.Common.pickLegendArmor(set.Chain);
	if (chain != null) {
		armor.setUpgrade(chain)
	}

	local plate = ::Const.World.Common.pickLegendArmor(set.Plate);
	if (plate != null) {
		armor.setUpgrade(plate)
	}

	local cloak = ::Const.World.Common.pickLegendArmor(set.Cloak);
	if (cloak != null) {
		armor.setUpgrade(cloak)
	}

	local tab = ::Const.World.Common.pickLegendArmor(set.Tabard);
	if (tab != null) {
		armor.setUpgrade(tab)
	}

	local att = ::Const.World.Common.pickLegendArmor(set.Attachments);
	if (att != null) {
		armor.setUpgrade(att)
	}

	return armor;
}

/**
* Picks one of armor upgrades
* @param _list in form of weighted list, can be either of:
* - [[1, "relative/path/to/upgrade"]]
* TODO, could be private function?
*/
::Const.World.Common.pickArmorUpgrade <- function (_armors)
{
	local candidates = _armors.filter(@(idx, t) t[0] > 0);
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);

	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);
	if (!selected.len())
		return null;
	local armorID = selected[0][1];

	if (!(armorID in ::Const.LegendMod.Armors))
		return this.new("scripts/items/armor_upgrades/" + armorID);

	local layersObj = ::Const.LegendMod.Armors[armorID];
	if (layersObj.Script != "")
		return this.new(layersObj.Script);

	return null;
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
::Const.World.Common.pickOutfit <- function ( _outfitArr, _armorArr = null, _helmetArr = null, _chance = 0)
{
	if (_chance != 0) {
		if (::Math.rand(1, 100) >= _chance) {
			// this.logInfo("Pick outfit rolled against a chance and returned two things")
			return [::Const.World.Common.pickArmor(_armorArr), ::Const.World.Common.pickHelmet(_helmetArr)]
		}
	}
	else if (_armorArr != null && _helmetArr != null && _armorArr.len() > 0 && _helmetArr.len() > 0) {
		local armorCount = _armorArr.filter(@(idx, t) t[0] > 0).len();
		local helmCount = _helmetArr.filter(@(idx, t) t[0] > 0).len();
		local outfitCount = _outfitArr.filter(@(idx, t) t[0] > 0).len();

		if (::Math.rand(1, armorCount * helmCount) > outfitCount) {
			// this.logInfo("Pick outfit rolled against an armor*helmcount and returned two things")
			return [::Const.World.Common.pickArmor(_armorArr), ::Const.World.Common.pickHelmet(_helmetArr)]
		}
	}

	local candidates = _outfitArr.filter(@(idx, t) t[0] > 0);
	local totalWeight = candidates.map(@(t) t[0]).reduce(@(p, c) p + c);

	local r = ::Math.rand(0, totalWeight);
	local selected = candidates.filter(@(idx, t) (r -= t[0]) <= 0);
	local outfitID = selected.len() > 0 ? selected[0][1] : "";

	local layersObj = typeof(outfitID) == "string" ? ::Const.LegendMod.Outfits[outfitID] : outfitID;
	// this.logInfo("Pick outfit picked an outfit")
	return [::Const.World.Common.pickArmor(layersObj.Body), ::Const.World.Common.pickHelmet(layersObj.Helmet)];
}

/**
* Automatic conversion of vanilla and legends names to outfits
*/
::Const.World.Common.convNameToList <- function ( _named )
{
	local findString = ["helmets/", "armor/", "legend_armor/", "legend_helmets/"];
	foreach (search in findString) {
		if (_named[0].find(search) != null ) { //was this list
			return _named.map(@(item) [1, item.slice(item.find(search) + search.len())]);
		}
	}
	return [];
}
