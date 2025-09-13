if (!("Arena" in ::Legends))
	::Legends.Arena <- {};

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
				text = _bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") == 5 && _bro.getSkills().hasTrait(::Legends.Trait.PitFighter)) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.PitFighter);
		::Legends.Traits.grant(_bro, ::Legends.Trait.ArenaFighter, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") >= 12 && _bro.getSkills().hasTrait(::Legends.Trait.ArenaFighter)) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.ArenaFighter);
		::Legends.Traits.grant(_bro, ::Legends.Trait.ArenaVeteran, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") >= 25 && (_bro.getSkills().hasTrait(::Legends.Trait.ArenaVeteran))) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.ArenaVeteran);
		::Legends.Traits.grant(_bro, ::Legends.Trait.LegendArenaChampion, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	} else if (_bro.getFlags().getAsInt("ArenaFightsWon") >= 50 && _bro.getSkills().hasTrait(::Legends.Trait.LegendArenaChampion)) {
		::Legends.Traits.remove(_bro, ::Legends.Trait.LegendArenaChampion);
		::Legends.Traits.grant(_bro, ::Legends.Trait.LegendArenaInvictus, function(skill) {
			_list.push({
				id = 10,
				icon = skill.getIcon(),
				text = _bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
			});
		});
	}
}
