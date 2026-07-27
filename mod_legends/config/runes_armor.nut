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
[color=%positive%]+%min1%[/color] to [color=%positive%]+%max1%[/color] Fatigue recovery per turn.
[color=%negative%]%min2%%[/color] to [color=%positive%]%max2%%[/color] reduced Fatigue cost of all your skills.
	",
	EffectValues = [
		[0, 2],
		[3, 6]
	]
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
[color=%positive%]+%min1%%[/color] to [color=%positive%]+%max1%%[/color] Hitpoints.
[color=%negative%]-%min2%%[/color] to [color=%positive%]-%max2%%[/color] Damage received.
	",
	EffectValues = [
		[3, 6],
		[3, 6]
	]
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
[color=%positive%]Immune[/color] to stun, knockback and grab.
	",
	RuneTooltip = @"
[color=%negative%]This rune is not supposed to drop, if you see this, post bug report.[/color]

This item has the power of the rune sigil of Resilience:
[color=%positive%]Immune[/color] to stun, knockback and grab.
	"
		// Removed 22/1/23 as part of the steel brow rework. May rework this rune in a similar manner later where its not blanket immunity
		// return "This item has the power of the rune sigil of Resilience:\n[color=%positive%]Immune[/color] to stun, knockback and grab.";
});
