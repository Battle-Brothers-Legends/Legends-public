::mods_hookBaseClass("entity/world/settlements/situations/situation", function (o) {
	while (!("IsStacking" in o.m)) o = o[o.SuperName];

	o.m.IsSouthern <- false;
	o.m.SituationModifierTooltip <- {
		BuyPriceMult = {
			text = "buying prices",
			icon = "asset_money.png"
		},
		SellPriceMult = {
			text = "selling prices",
			icon = "asset_money.png"
		},
		FoodPriceMult = {
			text = "food prices",
			icon = "asset_food.png"
		},
		MedicalPriceMult = {
			text = "medical supply prices",
			icon = "asset_medicine.png"
		},
		BuildingPriceMult = {
			text = "building materials prices",
			icon = "asset_supplies.png"
		},
		IncensePriceMult = {
			text = "incense prices",
			icon = "bag.png"
		},
		BeastPartsPriceMult = {
			text = "beast parts prices",
			icon = "bag.png"
		},
		RarityMult = {
			text = "item rarity",
			icon = "special.png"
		},
		FoodRarityMult = {
			text = "food rarity",
			icon = "asset_food.png"
		},
		MedicalRarityMult = {
			text = "medical supply rarity",
			icon = "asset_medicine.png"
		},
		MineralRarityMult = {
			text = "mineral availability",
			icon = "bag.png"
		},
		BuildingRarityMult = {
			text = "building material availability",
			icon = "asset_supplies.png"
		},
		RecruitsMult = {
			text = "the amount of available recruits",
			icon = "asset_brothers.png"
		},
		StablesMult = {
			text = "the amount of available animals",
			icon = "buildings/stables.png"
		}
	}

	o.onResolved <- function (_settlement) {
		return this.onRemoved(_settlement);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local tooltip = getTooltip();
		local baseMods = ::new("scripts/entity/world/settlement_modifiers");
		local currentMods = ::new("scripts/entity/world/settlement_modifiers");

		this.onUpdate(currentMods);

		foreach (key, data in this.m.SituationModifierTooltip) {
			if (key in currentMods && key in baseMods) {
				local ratio = currentMods[key] / baseMods[key];

				if (ratio != 1.0) {
					tooltip.push({
						id = 10,
						type = "text",
						icon = "ui/icons/" + data.icon,
						text = (ratio > 1.0 ? "Increases " : "Decreases ") + data.text + " by "+ ::Legends.S.colorize(::Math.abs(::Math.round((ratio - 1.0) * 100)), ratio, 1.0) + "%"});
				}
			}
		}

		local extraDraft = [];
		this.onUpdateDraftList(extraDraft);

		if (extraDraft.len() > 0) {
			local bgNameList = {};

			foreach (r in extraDraft) {
				local bgName = "";

				if (typeof r == "integer") {
					bgName = ::Legends.Backgrounds.getName(r);
				} else {
					foreach (i, part in this.split(r, "_")) {
						if (part == "background") {
							continue;
						}
						if (bgName != "") {
							bgName += " ";
						}
						bgName += part.slice(0, 1).toupper() + part.slice(1);
					}
				}

				if (bgName != "") {
					bgNameList[bgName] <- true;
				}
			}

			local bgNameString = "";
			foreach (name, _ in bgNameList) {
				if (bgNameString != "") {
					bgNameString += ", ";
				}
				bgNameString += name;
			}

			if (bgNameList.len() > 0) {
				tooltip.push({
					id = 11,
					type = "text",
					icon = "ui/icons/asset_brothers.png",
					text = "More likely recruits: " + bgNameString
				});
			}
		}

		return tooltip;
	}

	o.onUpdateStablesList <- function (_list) {}
});
