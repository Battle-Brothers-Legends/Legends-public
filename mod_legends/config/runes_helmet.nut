/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRshClarity <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Helmet,
	Name = "Helmet Rune Sigil: Clarity",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshClarity,
	Script = "scripts/items/legend_helmets/runes/legend_rune_clarity",
	Tooltip = @"
This item has the power of the rune sigil of Clarity:
[color=%positive%]+%bonus1%[/color] Vision.
[color=%positive%]+%bonus2%%[/color] Experience gain.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Clarity:
[color=%positive%]+0[/color] to [color=%positive%]+%max1%[/color] Vision.
[color=%positive%]+3%[/color] to [color=%positive%]+%max2%%[/color] Experience gain.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(0, 2));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(0, 1));
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
			["max1", _item.isUpgraded() ? 2 : 1],
			["max2", _item.isUpgraded() ? 9 : 6]
		]);
	}
});

::Legends.Rune.LegendRshBravery <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Helmet,
	Name = "Helmet Rune Sigil: Bravery",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshBravery,
	Script = "scripts/items/legend_helmets/runes/legend_rune_bravery",
	Tooltip = @"
This item has the power of the rune sigil of Bravery:
[color=%positive%]+%bonus1%%[/color] Resolve.
[color=%positive%]+%bonus2%[/color] Resolve at all morale checks.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Bravery:
[color=%positive%]+0[/color] to [color=%positive%]+%max1%%[/color] Resolve.
[color=%positive%]+1[/color] to [color=%positive%]+%max2%[/color] Resolve at all morale checks.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 5));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 3));
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
			["max2", _item.isUpgraded() ? 5 : 3]
		]);
	}
});

::Legends.Rune.LegendRshLuck <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Helmet,
	Name = "Helmet Rune Sigil: Luck",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshLuck,
	Script = "scripts/items/legend_helmets/runes/legend_rune_luck",
	Tooltip = @"
This item has the power of the rune sigil of Luck:
[color=%positive%]+%bonus1%%[/color] chance to have any attacker require two successful attack rolls in order to hit.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Luck:
[color=%positive%]+3%[/color] to [color=%positive%]+%max1%%[/color] chance to have any attacker require two successful attack rolls in order to hit..
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip, [
			["bonus1", _item.getRuneBonus1()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(this.RuneTooltip, [
			["max1", _item.isUpgraded() ? 9 : 6]
		]);
	}
});

::Legends.Rune.LegendRshPatience <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Helmet,
	Name = "Helmet Rune Sigil: Patience",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshPatience,
	Script = "scripts/items/legend_helmets/runes/legend_rune_patience",
	Tooltip = @"
This item has the power of the rune sigil of Patience:
[color=%positive%]+%bonus1%%[/color] Initiative.
[color=%positive%]+%bonus2%%[/color] Hit chance to next attack after you wait a turn.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Patience:
[color=%positive%]+3%[/color] to [color=%positive%]+%max1%%[/color] Initiative.
[color=%positive%]+3%[/color] to [color=%positive%]+%max2%%[/color] Hit chance to next attack after you wait a turn.
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
