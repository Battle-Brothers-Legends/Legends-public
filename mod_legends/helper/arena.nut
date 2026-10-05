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
	item = ::Const.World.Common.pickItem(item, "scripts/items/");
	if (::isKindOf(item, "legend_armor_upgrade")) {
		local armor = ::Const.World.Common.pickArmor([[1, ::Legends.Armor.Southern.gladiator_harness]]);
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

::Legends.Arena.updateTraits <- function (_list, _bro) {
	if (_bro.getFlags().getAsInt("ArenaFightsWon") == 1) {
		::Legends.Traits.grant(_bro, ::Legends.Trait.PitFighter, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + ::Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") == 5 && _bro.getSkills().hasTrait(::Legends.Trait.PitFighter)) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.PitFighter);
		::Legends.Traits.grant(_bro, ::Legends.Trait.ArenaFighter, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + ::Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") >= 12 && _bro.getSkills().hasTrait(::Legends.Trait.ArenaFighter)) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.ArenaFighter);
		::Legends.Traits.grant(_bro, ::Legends.Trait.ArenaVeteran, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + ::Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") >= 25 && (_bro.getSkills().hasTrait(::Legends.Trait.ArenaVeteran))) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.ArenaVeteran);
		::Legends.Traits.grant(_bro, ::Legends.Trait.LegendArenaChampion, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + ::Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") >= 50 && _bro.getSkills().hasTrait(::Legends.Trait.LegendArenaChampion)) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.LegendArenaChampion);
		::Legends.Traits.grant(_bro, ::Legends.Trait.LegendArenaInvictus, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + ::Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	}
}
