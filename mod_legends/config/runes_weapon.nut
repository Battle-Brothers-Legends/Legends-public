/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRswPower <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Power",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswPower,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Power:
[color=%positive%]+%bonus1%%[/color] Damage inflicted on attacks with this weapon.
[color=%positive%]+%bonus2%[/color] Max damage on attacks with this weapon.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Power:
[color=%positive%]+3%[/color] to [color=%positive%]+%max1%%[/color] Damage inflicted on attacks with this weapon.
[color=%positive%]+3[/color] to [color=%positive%]+%max2%[/color] Max damage on attacks with this weapon.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()],
			["bonus2", _item.getRuneBonus2()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 9 : 6],
			["max2", _item.isUpgraded() ? 9 : 6]
		]);
	}
});

::Legends.Rune.LegendRswAccuracy <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Accuracy",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswAccuracy,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Accuracy:
[color=%positive%]+%bonus1%%[/color] Melee skill on attacks with this weapon.
[color=%positive%]+%bonus2%%[/color] Ranged skill on attacks with this weapon.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Accuracy:
[color=%positive%]+3%[/color] to [color=%positive%]+%max1%%[/color] Melee skill on attacks with the weapon.
[color=%positive%]+3%[/color] to [color=%positive%]+%max2%%[/color] Ranged skill on attacks with the weapon.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()],
			["bonus2", _item.getRuneBonus2()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 9 : 6],
			["max2", _item.isUpgraded() ? 9 : 6]
		]);
	}
});

::Legends.Rune.LegendRswFeeding <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Feeding",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswFeeding,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Feeding:
[color=%positive%]%bonus1%%[/color] of inflicted health damage recovers fatigue on attacks with this weapon.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Feeding:
[color=%positive%]2%[/color] to [color=%positive%]%max1%%[/color] of inflicted health damage recovers fatigue on attacks with this weapon.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(2, 6));
		} else {
			_item.setRuneBonus1(::Math.rand(2, 4));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 6 : 4]
		]);
	}
});

::Legends.Rune.LegendRswPoison <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Poison",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswPoison,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Poison:
[color=%positive%]%bonus1%[/color] turn(s) of poison applied on attacks with this weapon, with a strength of [color=%damage%]%bonus2%[/color]. Lowers action points and initiative.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Poison:
[color=%positive%]1 to %max1%[/color] turn(s) of poison applied on attacks with this weapon, with a strength of [color=%damage%]3 to %max2%[/color]. Lowers action points and initiative.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(1, 3));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(1, 2));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()],
			["bonus2", _item.getRuneBonus2()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 3 : 2],
			["max2", _item.isUpgraded() ? 9 : 6]
		]);
	}
});

::Legends.Rune.LegendRswBleeding <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Bleeding",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswBleeding,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Bleeding:
[color=%damage%]%bonus1%[/color] bleed damage every turn for [color=%positive%]%bonus2%[/color] turn(s).
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Bleeding:
[color=%damage%]3 to %max1%[/color] bleed damage every turn for [color=%positive%]1 to %max2%[/color] turn(s).
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()],
			["bonus2", _item.getRuneBonus2()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 9 : 6],
			["max2", _item.isUpgraded() ? 3 : 2]
		]);
	}
});

::Legends.Rune.LegendRswUnbreaking <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Unbreaking",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswUnbreaking,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Unbreaking:
[color=%positive%]%bonus1%[/color] to [color=%positive%]%bonus2%[/color] durability restored on every kill.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Unbreaking:
[color=%positive%]1-%max1%[/color] to [color=%positive%]3-%max2%[/color] durability restored on every kill.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()],
			["bonus2", _item.getRuneBonus2()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 3 : 2],
			["max2", _item.isUpgraded() ? 9 : 6]
		]);
	}
});

::Legends.Rune.LegendRswBlazing <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Blazing",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswBlazing,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Blazing:
On hit sets tile on fire causing [color=%damage%]%bonus1%[/color] Damage for [color=%positive%]%bonus2%[/color] turn(s) to anyone standing on it.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Blazing:
On hit sets tile on fire causing [color=%damage%]3[/color] to [color=%damage%]%max1%[/color] Damage for [color=%positive%]%max2%[/color] turn(s) to anyone standing on it.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 10));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()],
			["bonus2", _item.getRuneBonus2()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 10 : 6],
			["max2", _item.isUpgraded() ? 3 : 2]
		]);
	}
});
