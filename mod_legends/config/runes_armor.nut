/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRsaEndurance <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Armor,
	Name = "Armor Rune Sigil: Endurance",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaEndurance,
	Script = "scripts/items/legend_armor/runes/legend_rune_endurance",
	Tooltip = @"
This item has the power of the rune sigil of Endurance:
[color=%positive%]+%bonus1%[/color] Fatigue recovery per turn.
[color=%negative%]%bonus2%%[/color] reduced Fatigue cost of all your skills.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Endurance:
[color=%positive%]+0[/color] to [color=%positive%]+%max1%[/color] Fatigue recovery per turn.
[color=%negative%]3%[/color] to [color=%positive%]%max2%%[/color] reduced Fatigue cost of all your skills.
	",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(0, 3));
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
			["max1", _item.isUpgraded() ? 3 : 1],
			["max2", _item.isUpgraded() ? 9 : 6]
		]);
	}
});

::Legends.Rune.LegendRsaSafety <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Armor,
	Name = "Armor Rune Sigil: Safety",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaSafety,
	Script = "scripts/items/legend_armor/runes/legend_rune_safety",
	Tooltip = @"
This item has the power of the rune sigil of Safety:
[color=%positive%]+%bonus1%%[/color] Hitpoints.
[color=%negative%]-%bonus2%%[/color] Damage received.
	",
	RuneTooltip = @"
This item has the power of the rune sigil of Safety:
[color=%positive%]+3%[/color] to [color=%positive%]+%max1%%[/color] Hitpoints.
[color=%negative%]-3%[/color] to [color=%positive%]-%max2%%[/color] Damage received.
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

// TODO, this rune is deprecated since 2023, why do we keep it?
::Legends.Rune.LegendRsaResilience <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Armor,
	Name = "Armor Rune Sigil: Resilience",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaResilience,
	Script = "scripts/items/legend_armor/runes/legend_rune_resilience",
	Tooltip = @"
[color=%negative%]This rune is not supposed to drop, if you see this, post bug report.[/color]

This item has the power of the rune sigil of Resilience:
[color=%positive%]Immune[/color] to stuns, knockbacks and grabs.
	",
	RuneTooltip = @"
[color=%negative%]This rune is not supposed to drop, if you see this, post bug report.[/color]

This item has the power of the rune sigil of Resilience:
[color=%positive%]Immune[/color] to stuns, knockbacks and grabs.
	",
	setRuneBonus = function(_item, _bonus) {},
	getTooltip = function(_item) {
		return ::Legends.tooltip(this.Tooltip);
	}
	getRuneTooltip = function (_item) {
		// Removed 22/1/23 as part of the steel brow rework. May rework this rune in a similar manner later where its not blanket immunity
		// return "This item has the power of the rune sigil of Resilience:\n[color=%positive%]Immune[/color] to stuns, knockbacks and grabs.";
		return ::Legends.tooltip(this.RuneTooltip);
	}
});
