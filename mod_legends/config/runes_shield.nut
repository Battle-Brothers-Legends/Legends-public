/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRssDefense <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Shield,
	Name = "Shield Rune Sigil: Defense",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssDefense,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Defense:
[color=%positive%]+%bonus1%%[/color] Melee defense.
[color=%positive%]+%bonus2%%[/color] Ranged defense.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Defense:
[color=%positive%]+3%[/color] to [color=%positive%]+%max1%%[/color] to Melee defense.
[color=%positive%]+3%[/color] to [color=%positive%]+%max2%%[/color] to Ranged defense.
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

::Legends.Rune.LegendRssRadiance <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Shield,
	Name = "Shield Rune Sigil: Radiance",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssRadiance,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Radiance:
[color=%negative%]-%bonus1%%[/color] to all adjacent enemies' Melee skill.
[color=%negative%]-%bonus2%%[/color] to all adjacent enemies' Melee defense.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Radiance:
[color=%negative%]-3%[/color] to [color=%negative%]-%max1%%[/color] to all adjacent enemies' Melee skill.
[color=%negative%]-3%[/color] to [color=%negative%]-%max2%%[/color] to all adjacent enemies' Melee defense.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 12));
			_item.setRuneBonus2(::Math.rand(3, 12));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
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
			["max1", _item.isUpgraded() ? 12 : 9],
			["max2", _item.isUpgraded() ? 12 : 9]
		]);
	}
});

::Legends.Rune.LegendRssDurability <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Shield,
	Name = "Shield Rune Sigil: Durability",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssDurability,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Tooltip = @"
This item has the power of the rune sigil of Durability:
[color=%positive%]+%bonus1%[/color] additional Durability added to shield.
Has [color=%positive%]%bonus2%%[/color] chance to ignore damage to shield.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Durability:
[color=%positive%]+%min1%[/color] to [color=%positive%]+%max1%[/color] additional Durability added to shield.
Has [color=%positive%]%min2%%[/color] to [color=%positive%]%max2%%[/color] chance to ignore damage to shield.
	",
	Flag = "LegendRuneExtraDurability"
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9) * 3); // 9, 12 ... 27
			_item.setRuneBonus2(::Math.rand(5, 8) * 5); // 25, 30 ... 40%
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6) * 3); // 9, 12 ... 18
			_item.setRuneBonus2(::Math.rand(3, 6) * 5); // 15, 20 ... 30%
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
			["min1", 3 * (_item.isUpgraded() ? 3 : 3)],
			["max1", 3 * (_item.isUpgraded() ? 9 : 6)],
			["min2", 5 * (_item.isUpgraded() ? 5 : 3)],
			["max2", 5 * (_item.isUpgraded() ? 8 : 6)]
		]);
	}
});



