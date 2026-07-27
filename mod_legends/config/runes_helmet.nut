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
[color=%positive%]+%min1%[/color] to [color=%positive%]+%max1%[/color] Vision.
[color=%positive%]+%min2%%[/color] to [color=%positive%]+%max2%%[/color] Experience gain.
	",
	Effect = [
		[0, 1],
		[3, 6]
	]
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
[color=%positive%]+%min1%%[/color] to [color=%positive%]+%max1%%[/color] Resolve.
[color=%positive%]+%min2%[/color] to [color=%positive%]+%max2%[/color] Resolve at all morale checks.
	",
	Effect = [
		[3, 6],
		[1, 3]
	]
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
[color=%positive%]+%min1%%[/color] to [color=%positive%]+%max1%%[/color] chance to have any attacker require two successful attack rolls in order to hit.
	",
	Effect = [
		[3, 6]
	]
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
[color=%positive%]+%min1%%[/color] to [color=%positive%]+%max1%%[/color] Initiative.
[color=%positive%]+%min2%%[/color] to [color=%positive%]+%max2%%[/color] Hit chance to next attack after you wait a turn.
	",
	Effect = [
		[3, 6],
		[3, 6]
	]
});
