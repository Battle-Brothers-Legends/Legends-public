::mods_hookExactClass("entity/world/settlements/buildings/building", function(o)
{
	o.m.IsClosedAtDay <- false;

	o.isClosedAtDay <- function ()
	{
		return this.m.IsClosedAtDay;
	}

	o.fillStash = function ( _list, _stash, _priceMult, _allowDamagedEquipment = false )
	{
		_stash.clear();
		local rarityMult = this.getSettlement().getModifiers().RarityMult;
		local foodRarityMult = this.getSettlement().getModifiers().FoodRarityMult;
		local medicineRarityMult = this.getSettlement().getModifiers().MedicalPriceMult;
		local mineralRarityMult = this.getSettlement().getModifiers().MineralRarityMult;
		local buildingRarityMult = this.getSettlement().getModifiers().BuildingRarityMult;
		local isTrader = this.World.Retinue.hasFollower("follower.trader");

		foreach( i in _list )
		{
			local r = i.R;

			for( local num = 0; true;  )
			{
				local p = this.Math.rand(0, 100) * rarityMult;
				local item;
				local isHelm = false;
				local isArmor = false;
				local isUpgrade = false;
				local isDog = false;
				local script = i.S;

				local index = script.find("helmets/");
				if (index != null && script.find("legend_helmets") == null)
				{
					isHelm = true;
					script = script.slice(index + "helmets/".len());
				}
				index = script.find("armor/");
				if (index != null && script.find("legend_armor") == null)
				{
					isArmor = true;
					script = script.slice(index + "armor/".len());
				}
				index = script.find("armor_upgrades/");
				if (index != null && script.find("legend_armor") == null)
				{
					isUpgrade = true;
					script = script.slice(index + "armor_upgrades/".len());
				}

				// for my stupid dog renamings
				if ((script.find("wardog_item") || script.find("warhound_item")) && !script.find("legend"))
				{
					isDog = true;
					local splitted = split(script, "/");
					script = "accessory/legend_" + splitted[splitted.len() - 1];
				}

				if (p >= r)
				{
					if (isHelm)
					{
						item = this.Const.World.Common.pickHelmet([
							[1, script]
						]);
					}
					else if (isArmor)
					{
						item = this.Const.World.Common.pickArmor([
							[1, script]
						]);
					}
					else if (isUpgrade)
					{
						item = this.Const.World.Common.pickArmorUpgrade([
							[1, script]
						]);
					}
					else if (isDog)
					{
						item = this.new("scripts/items/" + script)
					}
					else
					{
						item = this.new("scripts/items/" + i.S);
					}


					if (item == null)
					{
						break;
					}

					local isFood = item.isItemType(this.Const.Items.ItemType.Food);
					local isMedicine = item.getID() == "supplies.medicine";
					local isMineral = item.getID() == "misc.uncut_gems" || item.getID() == "misc.copper_ingots" || item.getID() == "misc.legend_gold_ingots" || item.getID() == "misc.legend_iron_ingots" || item.getID() == "misc.legend_silver_ingots";
					local isBuilding = item.getID() == "misc.quality_wood" || item.getID() == "misc.copper_ingots" || item.getID() == "misc.legend_tin_ingots" || item.getID() == "misc.legend_iron_ingots";

					if (!isFood || p * foodRarityMult >= r)
					{
						if (!isMedicine || p * medicineRarityMult >= r)
						{
							if (!isMineral || p * mineralRarityMult >= r)
							{
								if (!isBuilding || p * buildingRarityMult >= r)
								{
									local items = [item];
									if (isArmor || isHelm)
									{
										local upgrades = item.getUpgrades();
										foreach( i, u in upgrades )
										{
											if (u != 1)
											{
												continue;
											}

											local upgrade = item.getUpgrade(i);
											upgrade.m.Armor = null;
											items.push(upgrade);
											item.m.Upgrades[i] = null;
										}
									}

									foreach (it in items)
									{
										if (_allowDamagedEquipment && it.getConditionMax() > 1)
										{
											if (this.Math.rand(1, 100) <= 50)
											{
												local condition = this.Math.rand(it.getConditionMax() * 0.4, it.getConditionMax() * 0.9);
												it.setCondition(condition);
											}
										}
										it.setPriceMult(i.P * _priceMult);
										if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
										{
											it.setOriginSettlement(this.getSettlement());
										}
										_stash.add(it);
									}
								}
							}
						}
					}

					if (r != 0 || rarityMult < 1.0 || isFood && foodRarityMult < 1.0 || isMedicine && medicineRarityMult < 1.0 || isMineral && mineralRarityMult < 1.0 || isBuilding && buildingRarityMult < 1.0)
					{
						r = r + p;
					}

				}
				else
				{
					break;
				}

				num = ++num;

				if (num >= 3 || !isTrader && num >= 2 && item.isItemType(this.Const.Items.ItemType.TradeGood))
				{
					break;
				}
			}
		}

		_stash.sort();
	}

	o.onUpdateStablesList <- function ( _list )
	{
	}
});
