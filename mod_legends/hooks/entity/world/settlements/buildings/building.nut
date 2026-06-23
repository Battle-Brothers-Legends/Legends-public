::mods_hookExactClass("entity/world/settlements/buildings/building", function(o) {
	o.m.IsClosedAtDay <- false;

	o.isClosedAtDay <- function() {
		return this.m.IsClosedAtDay;
	}
	o.fillStash = function(_list, _stash, _priceMult, _allowDamagedEquipment = false) {
		_stash.clear();
		local rarityMult = this.getSettlement().getModifiers().RarityMult;
		local foodRarityMult = this.getSettlement().getModifiers().FoodRarityMult;
		local medicineRarityMult = this.getSettlement().getModifiers().MedicalPriceMult;
		local mineralRarityMult = this.getSettlement().getModifiers().MineralRarityMult;
		local buildingRarityMult = this.getSettlement().getModifiers().BuildingRarityMult;
		local isTrader = this.World.Retinue.hasFollower("follower.trader");

		foreach (i in _list) {
			local r = i.R;

			for (local num = 0; true;) {
				local p = ::Math.rand(0, 100) * rarityMult;

				if (p < r) break;

				local item = null;
				local isHelm = false;
				local isArmor = false;
				local isUpgrade = false;
				local script = i.S;
				local index = null;

				if ((index = script.find("helmets/")) != null && script.find("legend_helmets") == null) {
					isHelm = true;
					item = ::Const.World.Common.pickHelmet([
						[1, script.slice(index + "helmets/".len())]
					]);
				} else if ((index = script.find("armor/")) != null && script.find("legend_armor") == null) {
					isArmor = true;
					item = ::Const.World.Common.pickArmor([
						[1, script.slice(index + "armor/".len())]
					]);
				} else if ((index = script.find("armor_upgrades/")) != null && script.find("legend_armor") == null) {
					isUpgrade = true;
					item = ::Const.World.Common.pickArmorUpgrade([
						[1, script.slice(index + "armor_upgrades/".len())]
					]);
				} else {
					if (script in ::Legends.Buildings.Replacement) {
						script = ::Legends.Buildings.Replacement[script]
					}
					item = this.new("scripts/items/" + script);
				}

				if (item == null) break;

				local isFood = item.isItemType(::Const.Items.ItemType.Food);
				local isMedicine = item.getID() in ::Legends.Buildings.Medicine;
				local isMineral = item.getID() in ::Legends.Buildings.Minerals;
				local isBuilding = item.getID() in ::Legends.Buildings.BuildMaterials;

				if ((!isFood || p * foodRarityMult >= r) &&
					(!isMedicine || p * medicineRarityMult >= r) &&
					(!isMineral || p * mineralRarityMult >= r) &&
					(!isBuilding || p * buildingRarityMult >= r)
				) {
					local items = [item];
					if (isArmor || isHelm) {
						local upgrades = item.getUpgrades();
						foreach (i, u in upgrades) {
							if (u != 1 && u != 3)
								continue;

							local upgrade = item.getUpgrade(i);
							upgrade.m.Armor = null;
							items.push(upgrade);
							item.m.Upgrades[i] = null;
						}
					}

					foreach (it in items) {
						if (_allowDamagedEquipment && it.getConditionMax() > 1) {
							if (::Math.rand(1, 100) <= 50) {
								local condition = ::Math.rand(it.getConditionMax() * 0.4, it.getConditionMax() * 0.9);
								it.setCondition(condition);
							}
						}
						it.setPriceMult(i.P * _priceMult);
						if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue()) {
							it.setOriginSettlement(this.getSettlement());
						}
						_stash.add(it);
					}
				}

				if (r != 0 || rarityMult < 1.0 ||
					isFood && foodRarityMult < 1.0 ||
					isMedicine && medicineRarityMult < 1.0 ||
					isMineral && mineralRarityMult < 1.0 ||
					isBuilding && buildingRarityMult < 1.0
				) {
					r = r + p;
				}

				num = ++num;

				if (num >= 3 || !isTrader && num >= 2 && item.isItemType(::Const.Items.ItemType.TradeGood)) {
					break;
				}
			}
		}

		_stash.sort();
	}

	o.onUpdateStablesList <- function(_list) {}
});
