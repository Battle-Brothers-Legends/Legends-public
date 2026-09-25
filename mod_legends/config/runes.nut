::Legends.Rune <- {}

::Legends.Runes <- {
	Target = {
		Shield = ::Const.Items.ItemType.Shield,
		Weapon = ::Const.Items.ItemType.Weapon,
		Helmet = ::Const.Items.ItemType.Helmet,
		Armor = ::Const.Items.ItemType.Armor
	}
	Defs = {},
	add = function (_def) {
		local id = ::Legends.Rune.len() + 1;
		::Legends.Runes.Defs[id] <- _def;
		return id;
	}
	get = function (_const) {
		if (_const in ::Legends.Runes.Defs) {
			return ::Legends.Runes.Defs[_const];
		}
		return null;
	}
};

::Legends.Runes.getMinBonus <- function (_minValue, _maxValue) {
	return (_maxValue - _minValue) * ::World.Assets.m.ProfessionEffect.LegendAncientKnowledge
		+ _minValue;
}

::Legends.Runes.getMaxBonus <- function (_value, _upgraded) {
	return _upgraded ? ::Math.round(_value * 1.5) : _value;
}

::Legends.Runes.getTooltip <- function (_item, _def, _isShort = false) {
	local ret = [];
	foreach (i, value in _def.EffectValues) {
		if (i == 0) {
			ret.extend([
				["bonus" + (i + 1), _item.getRuneBonus1()]
			])
		} else if (i == 1) {
			ret.extend([
				["bonus" + (i + 1), _item.getRuneBonus2()]
			])
		}
	}
	return _isShort ? ::Legends.tooltip(_def.ShortTooltip, ret) : ::Legends.tooltip(_def.Tooltip, ret);
}

::Legends.Runes.getRuneTooltip <- function (_def, _upgraded) {
	local ret = [];
	foreach (i, value in _def.EffectValues) {
		local maxValue = this.getMaxBonus(value[1], _upgraded);
		local minValue = ::Math.floor(this.getMinBonus(value[0], maxValue));

		ret.extend([
			["min" + (i + 1), minValue],
			["max" + (i + 1), maxValue]
		])
	}
	return ::Legends.tooltip(_def.RuneTooltip, ret);
}

::Legends.Runes.setRuneBonuses <- function (_item, _def, _upgraded, _crafted) {
	foreach (i, value in _def.EffectValues) {
		local maxValue = this.getMaxBonus(value[1], _upgraded);
		local minValue = this.getMinBonus(value[0], maxValue);
		local result = ::Math.rand(_crafted ? ::Legends.S.randomizeFractionToInt(minValue) : value[0], maxValue);

		if (i == 0) {
			_item.setRuneBonus1(result);
		} else if (i == 1) {
			_item.setRuneBonus2(result);
		}
	}
}

::Legends.Runes.applyCompareHints <- function(_tooltipList, _selectedItem, _equippedItem) {
	local selectedDef = ::Legends.Runes.get(_selectedItem.getRuneVariant());
	local equippedDef = ::Legends.Runes.get(_equippedItem.getRuneVariant());
	if (selectedDef != null && equippedDef != null && selectedDef.Name == equippedDef.Name) {
		local bonusDiff1 = _selectedItem.getRuneBonus1() - _equippedItem.getRuneBonus1();
		local bonusDiff2 = _selectedItem.getRuneBonus2() - _equippedItem.getRuneBonus2();

		if (bonusDiff1 == 0 && bonusDiff2 == 0) {
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = "ui/tooltips/money_sw.png",
				text = "No rune effect difference"
			});

			return;
		}

		if (bonusDiff1 != 0) {
			local param1 = [];
			param1.extend([
				["bonus1Diff", ::Legends.S.colorize(::Legends.S.addSign(bonusDiff1), bonusDiff1)],
				["new", _selectedItem.getRuneBonus1()],
				["old",_equippedItem.getRuneBonus1()]
			]);
			
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = "ui/icons/special.png",
				text = ::Legends.tooltip(selectedDef.CompareTooltip[0], param1)
			});
		}
		
		if (bonusDiff2 != 0) {
			local param2 = [];
			param2.extend([
				["bonus2Diff", ::Legends.S.colorize(::Legends.S.addSign(bonusDiff2), bonusDiff2)],
				["new", _selectedItem.getRuneBonus2()],
				["old",_equippedItem.getRuneBonus2()]
			]);

			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = "ui/icons/special.png",
				text = ::Legends.tooltip(selectedDef.CompareTooltip[1], param2)
			});
		}

	} else {
		if (selectedDef != null) {
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = "ui/tooltips/positive.png",
				text = ::Legends.Runes.getTooltip(_selectedItem, selectedDef, true)
			});
		}
		
		if (equippedDef != null) {
			_tooltipList.push({
				id = 20,
				type = "hint",
				icon = "ui/tooltips/negative.png",
				text = ::Legends.Runes.getTooltip(_equippedItem, equippedDef, true)
			})
		}
	}
}
