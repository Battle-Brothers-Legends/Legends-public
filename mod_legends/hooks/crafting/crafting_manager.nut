::mods_hookNewObject("crafting/crafting_manager", function (o) {
	o.m.Filters <- [
		"All",
		::Legends.Profession.LegendAlchemy,
		::Legends.Profession.LegendCharlatan,
		::Legends.Profession.LegendHerbcraft,
		::Legends.Profession.LegendLeatherworking,
		::Legends.Profession.LegendMetalworking,
		::Legends.Profession.LegendTailoring,
		::Legends.Profession.LegendTrophyCarving,
		::Legends.Profession.LegendWoodworking
	];
	o.m.ItemCrafts <- null;

	o.getQualifiedBlueprintsForUI <- function (_filter = "All", _type = "Crafting") {
		local ret = [];

		foreach (b in this.m.Blueprints) {
			local category = b.getCategory();
			if (o.m.Filters.find(category) == null) {
				category = "Other";
			}

			if (b.m.BlueprintType == "Crafting" && (_filter != "All" && (category != _filter))) {
				continue;
			}

			if (b.isQualified() && (_type == b.m.BlueprintType)) {
				ret.push(b.getUIData());
			}
		}

		ret.sort(this.onSortBlueprints);
		return ret;
	}

	// Skibidis your toilet
	o.getCraftsUsingItem <- function (_itemID) {
		if (this.m.ItemCrafts == null) {
			this.m.ItemCrafts = {};

			foreach (b in this.m.Blueprints) {
				if (b.m.PreviewCraftable == null) {
					continue;
				}

				local name = b.getName();
				if (name == null || name.len() == 0) {
					continue;
				}

				foreach (c in b.m.PreviewComponents) {
					local id = c.Instance.getID();
					if (!(id in this.m.ItemCrafts)) {
						this.m.ItemCrafts[id] <- [];
					}

					if (this.m.ItemCrafts[id].find(name) == null) {
						this.m.ItemCrafts[id].push(name);
					}
				}
			}

			foreach (crafts in this.m.ItemCrafts) {
				crafts.sort();
			}
		}

		return _itemID in this.m.ItemCrafts ? this.m.ItemCrafts[_itemID] : [];
	}

	o.deleteAllBlueprints <- function () {
		foreach (bp in this.m.Blueprints) {
			bp = null;
		}
		this.m.Blueprints = [];
		this.m.ItemCrafts = null;
	}

	o.resetAllBlueprints <- function () {
		this.deleteAllBlueprints();
		this.create();
	}

	o.clear = function () {
		foreach (b in this.m.Blueprints) {
			b.reset();
		}
	}

	o.onSortBlueprints = function (_b1, _b2) {
		if (_b1.IsCraftable && !_b2.IsCraftable) {
			return -1;
		} else if (!_b1.IsCraftable && _b2.IsCraftable) {
			return 1;
		} else if (_b1.Category > _b2.Category) {
			return 1;
		} else if (_b1.Category < _b2.Category) {
			return -1;
		} else if (_b1.Type > _b2.Type) {
			return 1;
		} else if (_b1.Type < _b2.Type) {
			return -1;
		} else if (_b1.Name > _b2.Name) {
			return 1;
		} else if (_b1.Name < _b2.Name) {
			return -1;
		} else {
			return 0;
		}
	}
});
