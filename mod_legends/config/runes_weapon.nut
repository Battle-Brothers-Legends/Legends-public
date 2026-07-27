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
[color=%positive%]+%min1%%[/color] to [color=%positive%]+%max1%%[/color] Damage inflicted on attacks with this weapon.
[color=%positive%]+%min2%[/color] to [color=%positive%]+%max2%[/color] Max damage on attacks with this weapon.
	",
	Effect = [
		[3, 6],
		[3, 6]
	]
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
[color=%positive%]+%min1%%[/color] to [color=%positive%]+%max1%%[/color] Melee skill on attacks with the weapon.
[color=%positive%]+%min2%%[/color] to [color=%positive%]+%max2%%[/color] Ranged skill on attacks with the weapon.
	",
	Effect = [
		[3, 6],
		[3, 6]
	]
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
[color=%positive%]%min1%%[/color] to [color=%positive%]%max1%%[/color] of inflicted health damage recovers fatigue on attacks with this weapon.
	",
	Effect = [
		[2, 4]
	]
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
[color=%positive%]%min1% to %max1%[/color] turn(s) of poison applied on attacks with this weapon, with a strength of [color=%damage%]%min2% to %max2%[/color]. Lowers action points and initiative.
	",
	Effect = [
		[1, 2],
		[3, 6]
	]
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
[color=%damage%]%min1% to %max1%[/color] bleed damage every turn for [color=%positive%]%min2% to %max2%[/color] turn(s).
	",
	Effect = [
		[3, 6],
		[1, 2]
	]
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
[color=%positive%]%min1%-%max1%[/color] to [color=%positive%]%min2%-%max2%[/color] durability restored on every kill.
	",
	Effect = [
		[3, 6],
		[1, 2]
	]
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
On hit sets tile on fire causing [color=%damage%]%min1%[/color] to [color=%damage%]%max1%[/color] Damage for [color=%positive%]%min2% to %max2%[/color] turn(s) to anyone standing on it.
	",
	Effect = [
		[3, 6],
		[1, 2]
	]
});
