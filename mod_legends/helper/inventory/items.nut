if (!("Items" in ::Legends)) {
	::Legends.Items <- {};
}

::Legends.Items.hasItemFlag <- @(_item, _flag)(_item != null ? _item.getFlags().has(_flag) : false);

::Legends.Items.isWarhoundAllowedIntoBags <- @(_item, _entity)((_item.getID().find("wardog") == null && _item.getID().find("warhound") == null) || ::Legends.Perks.has(_entity, ::Legends.Perk.LegendPackLeader));

::Legends.Items.extraLootChance <- @(_baseLootAmount = 0)(_baseLootAmount + (!::Tactical.State.isScenarioMode() && ::Math.rand(1, 100) <= (::World.Assets.getExtraLootChance() + ::World.Assets.m.ProfessionEffect.LegendSkinning) ? 1 : 0));

::Legends.Items.logArmor <- function (_armor) {
	if (!_armor.isEquipped()) {
		return;
	}

	::logWarning("Armor Layering");
	::logWarning("--------------");
	::logWarning("Durability: " + _armor.getArmorMax());
	::logWarning("StaminaMod: " + _armor.getStaminaModifier());

	local upgrade = _armor.getUpgradeIDs();
	local upgText = [];
	local clothText = "\"cloth/" + split(_armor.getID(), ".")[2] + "\", " + _armor.getVariant();

	upgText.push(upgrade[0] == null ? "\"\"" : "\"chain/" + split(upgrade[0], ".")[2] + "\", " + _armor.getUpgradeVariant(0));
	upgText.push(upgrade[1] == null ? "\"\"" : "\"plate/" + split(upgrade[1], ".")[2] + "\", " + _armor.getUpgradeVariant(1));
	upgText.push(upgrade[3] == null ? "\"\"" : "\"cloak/" + split(upgrade[3], ".")[2] + "\", " + _armor.getUpgradeVariant(3));
	upgText.push(upgrade[2] == null ? "\"\"" : "\"tabard/" + split(upgrade[2], ".")[2] + "\", " + _armor.getUpgradeVariant(2));
	upgText.push(upgrade[4] == null ? "\"\"" : "\"armor_upgrades/" + split(upgrade[4], ".")[2] + "\", " + _armor.getUpgradeVariant(4));

	local toPrint = "{" + "\n\tID = \"CHANGEME\"," + "\n\tScript = \"\"," + "\n\tSets = [{" + "\n\t\tCloth = [[1, " + clothText + "]]," + "\n\t\tChain = [[1, " + upgText[0] + "]]," + "\n\t\tPlate = [[1, " + upgText[1] + "]]," + "\n\t\tCloak = [[1, " + upgText[2] + "]]," + "\n\t\tTabard = [[1, " + upgText[3] + "]]," + "\n\t\tAttachments = [[1, " + upgText[4] + "]]," + "\n\t}]" + "\n},";

	::logWarning(toPrint);
}

::Legends.Items.logHelmet <- function (_helmet) {
	if (!_helmet.isEquipped()) {
		return;
	}

	::logWarning("Helmet Layering");
	::logWarning("---------------");
	::logWarning("Durability: " + _helmet.getArmorMax());
	::logWarning("StaminaMod: " + _helmet.getStaminaModifier());

	local upgrade = _helmet.getUpgradeIDs();
	local upgText = [];
	local hoodText = "\"hood/" + split(_helmet.getID(), ".")[2] + "\", " + _helmet.getVariant();

	upgText.push(upgrade[0] == null ? "\"\"" : "\"helm/" + split(upgrade[0], ".")[2] + "\", " + _helmet.getUpgradeVariant(0));
	upgText.push(upgrade[1] == null ? "\"\"" : "\"top/" + split(upgrade[1], ".")[2] + "\", " + _helmet.getUpgradeVariant(1));
	upgText.push(upgrade[2] == null ? "\"\"" : "\"vanity/" + split(upgrade[2], ".")[2] + "\", " + _helmet.getUpgradeVariant(2));

	local toPrint = "{" + "\n\tID = \"CHANGEME\"," + "\n\tScript = \"\"," + "\n\tSets = [{" + "\n\t\tHoods = [[1, " + hoodText + "]]," + "\n\t\tHelms = [[1, " + upgText[0] + "]]," + "\n\t\tTops = [[1, " + upgText[1] + "]]," + "\n\t\tVanity = [[1, " + upgText[2] + "]]," + "\n\t}]" + "\n},";

	::logWarning(toPrint);
}
