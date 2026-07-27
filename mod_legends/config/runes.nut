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

::Legends.Runes.getTooltip <- function (_item, _def) {
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
	return ::Legends.tooltip(_def.Tooltip, ret);
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

::Legends.Runes.setRuneBonuses <- function (_def, _upgraded, _crafted) {
	foreach (i, value in _def.EffectValues) {
		local maxValue = this.getMaxBonus(value[1], _upgraded);
		local minValue = this.getMinBonus(value[0], maxValue);
		local result = ::Math.rand(_crafted ? ::Legends.S.randomizeFractionToInt(minValue) : value[0], maxValue);

		if (i == 0) {
			this.setRuneBonus1(result);
		} else if (i == 1) {
			this.setRuneBonus2(result);
		}
	}
}
