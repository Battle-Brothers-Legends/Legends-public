if (!("Arena" in ::Legends))
	::Legends.Arena <- {};

/* Loot - strings and weighted arrays allowed */
::Legends.Arena.LootTable <- [
	{
		Predicate = @(_fights) true,
		Loot = [
			[1, "legend_armor/armor_upgrades/legend_light_gladiator_upgrade"]
		]
	},{
		Predicate = @(_fights) true,
		Loot = [
			[1, "legend_helmets/helm/legend_helmet_southern_gladiator_helm_crested"],
			[1, "legend_helmets/helm/legend_helmet_southern_gladiator_helm_split"],
			[1, "legend_helmets/helm/legend_helmet_southern_gladiator_helm_masked"]
		]
	},{
		Predicate = @(_fights) _fights > 5,
		Loot = [
			[1, "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"]
		]
	}
];

::Legends.Arena.pickLoot <- function(_totalFights, _index = -1) {
	local lootTable = ::Legends.Arena.LootTable.filter(@(_, _entry) _entry.Predicate(_totalFights));
	local item = lootTable[_index == -1 ? ::Math.rand(0, lootTable.len() - 1) : _index].Loot;
	item = ::Legends.Items.pickItem(item, "scripts/items/");
	if (::isKindOf(item, "legend_armor_upgrade")) {
		local armor = ::Legends.Items.pickArmor([[1, ::Legends.Armor.Southern.gladiator_harness]]);
		armor.setUpgrade(item);
		return armor;
	}
	return item;
}

::Legends.Arena.getLootEntry <- function (_item) {
	local icon = _item.getIcon();
	if (::Legends.Inventory.isItemLayered(_item) && _item.getUpgrade() != null) {
		icon = _item.getUpgrade().getIcon();
	}
	return {
		id = 12,
		icon = "ui/items/" + icon,
		text = "You gain a " + _item.getName()
	};
}


::Legends.Arena.getCollaredBros <- function () { return ::World.getPlayerRoster().getAll().filter(@(idx, bro) ::Legends.Arena.hasCollar(bro)); }

::Legends.Arena.hasCollar <- function (_bro) {
	local item = _bro.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
	if (item != null && item.getID() == "accessory.arena_collar")
		return true;

	local itemsInBag = _bro.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
	foreach (item in itemsInBag) {
		if (item != null && item.getID() == "accessory.arena_collar")
			return true;
	}
	return false;
}

::Legends.Arena.removeCollar <- function(_bro) {
	local item = _bro.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
	if (item != null && item.getID() == "accessory.arena_collar") {
		_bro.getItems().unequip(item);
	}

	local itemsInBag = _bro.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
	foreach (item in itemsInBag) {
		if (item != null && item.getID() == "accessory.arena_collar") {
			_bro.getItems().removeFromBag(item);
		}
	}
}

// wins needed for each arena trait, lowest first
::Legends.Arena.TraitTiers <- [
	[1, ::Legends.Trait.PitFighter],
	[5, ::Legends.Trait.ArenaFighter],
	[12, ::Legends.Trait.ArenaVeteran],
	[25, ::Legends.Trait.LegendArenaChampion],
	[50, ::Legends.Trait.LegendArenaInvictus]
];

::Legends.Arena.updateTraits <- function (_list, _bro) {
	local won = _bro.getFlags().getAsInt("ArenaFightsWon");
	local earned = -1;
	local current = -1;

	foreach (i, tier in ::Legends.Arena.TraitTiers) {
		if (won >= tier[0]) {
			earned = i;
		}

		if (_bro.getSkills().hasTrait(tier[1])) {
			current = i;
		}
	}

	// goes by the wins alone so a character who missed a step catches up, and never takes away a higher trait he already has
	if (earned <= current) {
		return;
	}

	foreach (i, tier in ::Legends.Arena.TraitTiers) {
		if (i < earned) {
			::Legends.Traits.remove(_bro, tier[1]);
		}
	}

	::Legends.Traits.grant(_bro, ::Legends.Arena.TraitTiers[earned][1], function(skill) {
		_list.push({
			id = 10,
			icon = skill.getIcon(),
			text = _bro.getName() + " is now " + ::Const.Strings.getArticle(skill.getName()) + skill.getName()
		});
	});
}

::Legends.Arena.grantWins <- function (_bro, _wins) {
	local flags = _bro.getFlags();
	flags.set("ArenaFightsWon", ::Math.max(_wins, flags.getAsInt("ArenaFightsWon")));
	flags.set("ArenaFights", ::Math.max(_wins, flags.getAsInt("ArenaFights")));
	::Legends.Arena.updateTraits([], _bro);
}
