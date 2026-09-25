if (!("Items" in ::Legends)) {
	::Legends.Items <- {};
}
::Legends.Items.Effects <- {};
::Legends.Items.Effects.GoldenGooseGoldPerDay <- 50;

::Legends.Items.Effects.ItemEffectDefs <- {

	DirectDamage = {
		isApplicable = function(_item) {
			return _item.getDirectDamageModifier() != 0;
		},
		getTooltipData = function(_item, _value = null) {
			local val = _value != null ? _value : _item.getDirectDamageModifier();
			return {
				CompareValue = _item.getDirectDamageModifier(),
				CompareValueStr = ::Legends.S.addSign(_item.getDirectDamageModifier()) + "%",
				ID = 15,
				Icon = "ui/icons/direct_damage.png",
				Text = "%modifierPercent% damage ignoring armor",
				Param = [
					["modifierPercent", ::Legends.S.colorize("" + ::Legends.S.getSign(val) + ::Math.abs(val) + "%", val)]
				]
			};
		},
	},
	
	ArmorDamageMult = {
		isApplicable = function(_item) {
			return _item.getDamageReceivedArmorMult() != 0;
		},
		getTooltipData = function(_item, _value = null) {
			local armorType = "Armor";
			local iconType = "ui/icons/armor_body.png";
			local val = _value != null ? _value : _item.getDamageReceivedArmorMult();
			if (_item.m.ItemType == ::Const.Items.ItemType.Armor) {
				armorType = "Body Armor";
				iconType = "ui/icons/armor_body.png";

			} else if (_item.m.ItemType == ::Const.Items.ItemType.Helmet) {
				armorType = "Helmet Armor";
				iconType = "ui/icons/armor_head.png";
			}
			return {
				CompareValue = _item.getDamageReceivedArmorMult(),
				CompareValueStr = ::Legends.S.addSign(_item.getDamageReceivedArmorMult()) + "%",
				ID = 16,
				Icon = "ui/icons/armor_body.png",
				Text = "%modifierPercent% damage taken to %armorType%",
				Param = [
					["modifierPercent", ::Legends.S.colorize("" + ::Legends.S.getSign(val) + ::Math.abs(val) + "%", val)],
					["armorType", armorType]
				]
			};
		},
	},

	Fatigue = {
		isApplicable = function(_item) {
			return _item.getCurrentFatigueModifier() != 0;
		},
		getTooltipData = function(_item, _value = null) {
			local armorType = "Armor";
			local val = _value != null ? _value : _item.getCurrentFatigueModifier();
			if (_item.m.ItemType == ::Const.Items.ItemType.Armor) {
				armorType = "Body Armor";

			} else if (_item.m.ItemType == ::Const.Items.ItemType.Helmet) {
				armorType = "Helmets";
			}
			return {
				CompareValue = _item.getCurrentFatigueModifier(),
				CompareValueStr = ::Legends.S.addSign(_item.getCurrentFatigueModifier()),
				ID = 17,
				Icon = "ui/icons/fatigue.png",
				Text = "%modifier% Fatigue Weight Penalty of %armorType%",
				Param = [
					["modifier", ::Legends.S.colorize("" + ::Legends.S.getSign(val) + ::Math.abs(val), val)],
					["armorType", armorType]
				]
			};
		},
	},

	FatigueMult = {
		isApplicable = function(_item) {
			return _item.getFatiguePenaltyMultiplier() != 0;
		},
		getTooltipData = function(_item, _value = null) {
			local armorType = "Armor";
			local val = _value != null ? _value : _item.getFatiguePenaltyMultiplier();
			if (_item.m.ItemType == ::Const.Items.ItemType.Armor) {
				armorType = "Body Armor";

			} else if (_item.m.ItemType == ::Const.Items.ItemType.Helmet) {
				armorType = "Helmets";
			}
			return {
				CompareValue = _item.getFatiguePenaltyMultiplier(),
				CompareValueStr = ::Legends.S.addSign(_item.getFatiguePenaltyMultiplier()) + "%",
				ID = 17,
				Icon = "ui/icons/fatigue.png",
				Text = "%modifierPercent% Fatigue Weight Penalty of %armorType%",
				Param = [
					["modifierPercent", ::Legends.S.colorize("" + ::Legends.S.getSign(val) + ::Math.abs(val) + "%", val)],
					["armorType", armorType]
				]
			};
		},
	},

	Resolve = {
		isApplicable = function(_item) {
			return _item.getResolveModifier() != 0;
		},
		getTooltipData = function(_item, _value = null) {
			local val = _value != null ? _value : _item.getResolveModifier();
			return {
				CompareValue = _item.getResolveModifier(),
				CompareValueStr = ::Legends.S.addSign(_item.getResolveModifier()),
				ID = 12,
				Icon = "ui/icons/bravery.png",
				Text = "%resolveMod% Resolve",
				Param = [
					["resolveMod", ::Legends.S.colorize("" + ::Legends.S.getSign(val) + ::Math.abs(val), val)]
				]
			};
		},
	},

	ResolveMult = {
		isApplicable = function(_item) {
			return _item.getBraveryMult() != 1;
		},
		getTooltipData = function(_item, _value = null) {
			local mult = ::Math.round(_item.getBraveryMult() * 100.0 - 100);
			local val = _value != null ? _value : mult;
			return {
				CompareValue = mult,
				CompareValueStr = ::Legends.S.addSign(mult) + "%",
				ID = 15,
				Icon = "ui/icons/bravery.png",
				Text = "%resolveModPercent% Resolve",
				Param = [
					["resolveModPercent", ::Legends.S.colorize(::Legends.S.addSign(val) + "%", val)]
				]
			};
		},
	},

	Initiative = {
		isApplicable = function(_item) {
			return _item.getInitiativeModifier() != 0;
		},
		getTooltipData = function(_item, _value = null) {
			local val = _value != null ? _value : _item.getInitiativeModifier();
			return {
				CompareValue = _item.getInitiativeModifier(),
				CompareValueStr = ::Legends.S.addSign(_item.getInitiativeModifier()),
				ID = 11,
				Icon = "ui/icons/initiative.png",
				Text = "%initMod% Initiative",
				Param = [
					["initMod", ::Legends.S.colorize("" + ::Legends.S.getSign(val) + ::Math.abs(val), val)]
				]
			};
		},
	},

	Threat = {
		isApplicable = function(_item) {
			return _item.getThreatModifier() != 0;
		},
		getTooltipData = function(_item, _value = null) {
			local invertedThreat = -1 * _item.getThreatModifier();	// For this tooltip we want to show the actual effect on the enemy
			local val = _value != null ? _value : invertedThreat;
			return {
				CompareValue = invertedThreat,
				CompareValueStr = ::Legends.S.addSign(invertedThreat),
				ID = 11,
				Icon = "ui/icons/special.png",
				Text = "%modifier% to the Resolve of any opponent engaged in melee",
				Param = [
					["modifier", ::Legends.S.colorize("" + ::Legends.S.getSign(val) + ::Math.abs(val), val)]
				]
			};
		},
	},
};

::Legends.Items.Effects.applyEffectTooltips <- function (_tooltipList, _item) {
	foreach( _ , effect in ::Legends.Items.Effects.ItemEffectDefs) {
		
		if (effect.isApplicable(_item)) {
			
			local data = effect.getTooltipData(_item);
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
		if (effect.isApplicable(_selectedItem) && !effect.isApplicable(_equippedItem)) {
			// Gain effect from selected item
			local data = effect.getTooltipData(_selectedItem);
			local paramArr = [];
			if ("Param" in data) {
				paramArr = data.Param;
			}
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = "ui/tooltips/positive.png",
				text = data.Text,
				param = paramArr
			});
		} else if (!effect.isApplicable(_selectedItem) && effect.isApplicable(_equippedItem)) {
			// Lose effect from equipped item
			local data = effect.getTooltipData(_equippedItem);
			local paramArr = [];
			if ("Param" in data) {
				paramArr = data.Param;
			}
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = "ui/tooltips/negative.png",
				text = data.Text,
				param = paramArr
			});
		} else if (effect.isApplicable(_selectedItem) && effect.isApplicable(_equippedItem)) {
			// Nett effect of switching equipped item to selected item
			local dataS = effect.getTooltipData(_selectedItem);
			local dataE = effect.getTooltipData(_equippedItem);
			local diff = dataS.CompareValue - dataE.CompareValue;
			if (diff != 0) {
				local dataDiff = effect.getTooltipData(_selectedItem, diff);
				local compareText = ::Legends.tooltip(dataDiff.Text, dataDiff.Param); // assumes that effect that can compare its value must always have non-empty Param
				_tooltipList.push({
					id = 20,
					type = "hint",
					icon = dataS.Icon,
					text = "%compareText% (%valueS% vs %valueE%)",
					param = [
						["compareText", compareText],
						["valueS", dataS.CompareValue],
						["valueE", dataE.CompareValue]
					] // If you're wondering why CompareValueStr isn't used in this script at the time of writing: it was used here at first, but it has been changed to CompareValue for brevity
				});
			}
		}
	}

	// Compare custom effects tooltips
	local customS = ::Legends.Items.Effects.extractAdditionalTooltips(_selectedItem);
	local customE = ::Legends.Items.Effects.extractAdditionalTooltips(_equippedItem);
	local freq = {}; // A hash table to help weed out duplicate tooltips

	foreach (tooltip in customS) {
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

	foreach (tooltip in customE) {
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
}