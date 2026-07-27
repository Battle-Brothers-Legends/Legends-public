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
[color=%positive%]+%min1%%[/color] to [color=%positive%]+%max1%%[/color] to Melee defense.
[color=%positive%]+%min2%%[/color] to [color=%positive%]+%max2%%[/color] to Ranged defense.
	",
	Effect = [
		[3, 6],
		[3, 6]
	]
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
[color=%negative%]-%min1%%[/color] to [color=%negative%]-%max1%%[/color] to all adjacent enemies' Melee skill.
[color=%negative%]-%min2%%[/color] to [color=%negative%]-%max2%%[/color] to all adjacent enemies' Melee defense.
	",
	Effect = [
		[3, 8],
		[3, 8]
	]
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
	Effect = [
		[9, 18],
		[15, 30]
	]
});



