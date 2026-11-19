if (!("Items" in ::Legends)) {
	::Legends.Items <- {};
}
::Legends.Items.Effects <- {};
::Legends.Items.Effects.GoldenGooseGoldPerDay <- 50;

::Legends.Items.Effects.ItemEffectDefs <- {

	DirectDamage = {
		getValue = function(_item) {
			return _item.getDirectDamageModifier();
		},
		isApplicable = function(_item) {
			return _item.getDirectDamageModifier() != 0;
		},
		getTooltipData = function(_value, _) {
			return {
				ID = 15,
				Icon = "ui/icons/direct_damage.png",
				Text = "%modifierPercent% damage ignoring armor",
				Param = [
					["modifierPercent", ::Legends.Text.addSignAndColorize(_value, true)]
				]
			};
		},
	},
	
	ArmorDamageMult = {
		getValue = function(_item) {
			return _item.getDamageReceivedArmorMult();
		},
		isApplicable = function(_item) {
			return _item.getDamageReceivedArmorMult() != 0;
		},
		getTooltipData = function(_value, _item) {
			local armorType = "Armor";
			local iconType = "ui/icons/armor_body.png";
			
			if (_item.m.ItemType == ::Const.Items.ItemType.Armor) {
				armorType = "Body Armor";
				iconType = "ui/icons/armor_body.png";

			} else if (_item.m.ItemType == ::Const.Items.ItemType.Helmet) {
				armorType = "Helmet Armor";
				iconType = "ui/icons/armor_head.png";
			}

			return {
				ID = 16,
				Icon = "ui/icons/armor_body.png",
				Text = "%modifierPercent% damage taken to %armorType%",
				Param = [
					["modifierPercent", ::Legends.Text.addSignAndColorize(_value, true)],
					["armorType", armorType]
				]
			};
		},
	},

	FatigueMult = {
		getValue = function(_item) {
			return _item.getFatiguePenaltyMultiplier();
		},
		isApplicable = function(_item) {
			return _item.getFatiguePenaltyMultiplier() != 0;
		},
		getTooltipData = function(_value, _item) {
			local armorType = "Armor";
			local modifier = ::MSU.isIn("getCurrentFatigueModifier", _item, true) ? _item.getCurrentFatigueModifier() : 0; // the resultant fatigue modifier if the item is equipped
			local optionalModifierText = modifier == 0 ? "" : " (" + ::Legends.Text.addSignAndColorize(modifier, false) + ")";

			if (_item.m.ItemType == ::Const.Items.ItemType.Armor) {
				armorType = "Body Armor";

			} else if (_item.m.ItemType == ::Const.Items.ItemType.Helmet) {
				armorType = "Helmets";
			}
			
			return {
				ID = 17,
				Icon = "ui/icons/fatigue.png",
				Text = "%modifierPercent%%optionalModifierText% Fatigue Weight Penalty of %armorType%",
				Param = [
					["modifierPercent", ::Legends.Text.addSignAndColorize(_value, true)],
					["optionalModifierText", optionalModifierText],
					["armorType", armorType]
				]
			};
		},
	},

	Resolve = {
		getValue = function(_item) {
			return _item.getResolveModifier();
		},
		isApplicable = function(_item) {
			return _item.getResolveModifier() != 0;
		},
		getTooltipData = function(_value, _) {
			return {
				ID = 12,
				Icon = "ui/icons/bravery.png",
				Text = "%resolveMod% Resolve",
				Param = [
					["resolveMod", ::Legends.Text.addSignAndColorize(_value, false)]
				]
			};
		},
	},

	ResolveMult = {
		getValue = function(_item) {
			return ::Math.round(_item.getBraveryMult() * 100.0) - 100;
		},
		isApplicable = function(_item) {
			return _item.getBraveryMult() != 1;
		},
		getTooltipData = function(_value, _) {
			return {
				ID = 15,
				Icon = "ui/icons/bravery.png",
				Text = "%resolveModPercent% Resolve",
				Param = [
					["resolveModPercent", ::Legends.Text.addSignAndColorize(_value, true)]
				]
			};
		},
	},

	Initiative = {
		getValue = function(_item) {
			return _item.getInitiativeModifier();
		},
		isApplicable = function(_item) {
			return _item.getInitiativeModifier() != 0;
		},
		getTooltipData = function(_value, _) {
			return {
				ID = 11,
				Icon = "ui/icons/initiative.png",
				Text = "%initMod% Initiative",
				Param = [
					["initMod", ::Legends.Text.addSignAndColorize(_value, false)]
				]
			};
		},
	},

	Threat = {
		getValue = function(_item) {
			return -1 * _item.getThreatModifier();	// We want to show the actual effect on the enemy
		},
		isApplicable = function(_item) {
			return _item.getThreatModifier() != 0;
		},
		getTooltipData = function(_value, _) {
			return {
				ID = 11,
				Icon = "ui/icons/special.png",
				Text = "%modifier% to the Resolve of any opponent engaged in melee",
				Param = [
					["modifier", ::Legends.Text.addSignAndColorize(_value, false)]
				]
			};
		},
	},
};

::Legends.Items.Effects.applyEffectTooltips <- function (_tooltipList, _item) {
	foreach( _ , effect in ::Legends.Items.Effects.ItemEffectDefs) {
		
		if (effect.isApplicable(_item)) {
			local value = effect.getValue(_item);
			local data = effect.getTooltipData(value, _item);
			local paramArr = [];
			if ("Param" in data) {
				paramArr = data.Param;
			}

			_tooltipList.push({
				id = data.ID,
				type = "text",
				icon = data.Icon,
				text = data.Text,
				param = paramArr
			});
		}
	}
};

::Legends.Items.Effects.applyCompareHints <- function (_tooltipList, _selectedItem, _equippedItem) {
	// Compare standardised effects
	foreach ( _, effect in ::Legends.Items.Effects.ItemEffectDefs) {
		local selectedVal = effect.getValue(_selectedItem);
		local equippedVal = effect.getValue(_equippedItem);
		local diff = selectedVal - equippedVal;
		if (diff != 0) {
			local data = effect.getTooltipData(diff, _selectedItem);
			local paramArr = [];
			if ("Param" in data) {
				paramArr = data.Param;
			}
			local compareText = ::Legends.tooltip(data.Text, paramArr);
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = data.Icon,
				text = "%compareText% (%after% vs %before%)",
				param = [
					["compareText", compareText],
					["after", selectedVal],
					["before", equippedVal]
				]
			});
		}
	}

	::Legends.Items.Effects.applyLayerCompareCustomEffectHints(_tooltipList, _selectedItem, _equippedItem);
};

::Legends.Items.Effects.applySetCompareHints <- function (_tooltipList, _selectedSet, _equippedSet) {
	// Compare standardised effects
	// (assumes only upgrade layers have standardised hints; base armor is assumed to not have standardised effects to compare)
	foreach ( _, effect in ::Legends.Items.Effects.ItemEffectDefs) {
		local selectedVal = 0;
		local equippedVal = 0;
		foreach (u in _selectedSet.m.Upgrades) {
			if (u == null || u.m.Type == ::Const.Items.ArmorUpgrades.Rune) continue;
			if (effect.isApplicable(u)) selectedVal += effect.getValue(u);
		}
		foreach (u in _equippedSet.m.Upgrades) {
			if (u == null || u.m.Type == ::Const.Items.ArmorUpgrades.Rune) continue;
			if (effect.isApplicable(u)) equippedVal += effect.getValue(u);
		}
		
		local diff = selectedVal - equippedVal;
		if (diff != 0) {
			local data = effect.getTooltipData(diff, _selectedSet);
			local paramArr = [];
			if ("Param" in data) {
				paramArr = data.Param;
			}
			local compareText = ::Legends.tooltip(data.Text, paramArr);
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = data.Icon,
				text = "%compareText% (%after% vs %before%)",
				param = [
					["compareText", compareText],
					["after", selectedVal],
					["before", equippedVal]
				]
			});
		}
	}

	// Compare custom effects
	::Legends.Items.Effects.applySetCompareCustomEffectHints(_tooltipList, _selectedSet, _equippedSet);
};

::Legends.Items.Effects.extractAdditionalTooltips <- function (_item) {
	local ret = [];
	local tooltipList = [];
	local super = _item.SuperName;
	local regularTooltipsLength = _item[super].getTooltip().len();
	tooltipList = _item.getTooltip();

	// If an item adds additional tooltips (ie in child's getTooltips function) describing custom effects, we want to get those
	if (tooltipList.len() > regularTooltipsLength) {
		local additionalTooltips = tooltipList.slice(regularTooltipsLength);
		foreach (t in additionalTooltips) {
			ret.push(t);
		}
	}
	return ret;
};

::Legends.Items.Effects.applyCompareCustomEffectHints <- function (_tooltipList, _selectedTooltips, _equippedTooltips) {
	// Compare custom effects tooltips
	local freq = {}; // A hash table to help weed out duplicate tooltips

	foreach (tooltip in _selectedTooltips) {
		local paramArr = [];
		local textStr = "";
		if ("text" in tooltip) {
			textStr = tooltip.text;
		}
		if ("param" in tooltip) {
			paramArr = tooltip.param;
		}
		local buildText = ::Legends.tooltip(textStr, paramArr);
		if (!(buildText in freq)) {
			freq[buildText] <- [1, "ui/tooltips/positive.png"];
		}
	}

	foreach (tooltip in _equippedTooltips) {
		local paramArr = [];
		local textStr = "";
		if ("text" in tooltip) {
			textStr = tooltip.text;
		}
		if ("param" in tooltip) {
			paramArr = tooltip.param;
		}
		local buildText = ::Legends.tooltip(textStr, paramArr);
		if (buildText in freq) {
			freq[buildText][0] += 1; // found a duplicate tooltip
		} else {
			freq[buildText] <- [1, "ui/tooltips/negative.png"];
		}
	}

	foreach (key, val in freq) {
		if (val[0] == 1) {
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = val[1],
				text = key
			});
		}
	}
};

::Legends.Items.Effects.applyLayerCompareCustomEffectHints <- function (_tooltipList, _selectedItem, _equippedItem) {
	local customS = ::Legends.Items.Effects.extractAdditionalTooltips(_selectedItem);
	local customE = ::Legends.Items.Effects.extractAdditionalTooltips(_equippedItem);
	::Legends.Items.Effects.applyCompareCustomEffectHints(_tooltipList, customS, customE);
};

::Legends.Items.Effects.applySetCompareCustomEffectHints <- function (_tooltipList, _selectedItem, _equippedItem) {
	local customS = [];
	local customE = [];
	foreach (u in _selectedItem.m.Upgrades) {
		if (u == null || u.m.Type == ::Const.Items.ArmorUpgrades.Rune) continue;
		customS.extend(::Legends.Items.Effects.extractAdditionalTooltips(u));
	}
	foreach (u in _equippedItem.m.Upgrades) {
		if (u == null || u.m.Type == ::Const.Items.ArmorUpgrades.Rune) continue;
		customE.extend(::Legends.Items.Effects.extractAdditionalTooltips(u));
	}
	::Legends.Items.Effects.applyCompareCustomEffectHints(_tooltipList, customS, customE);
};