::mods_hookExactClass("items/accessory/berserker_mushroom_item", function (o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		local index = ret.len() - 1;

		for (local i = ret.len() - 1; i >= 0; --i) {
			if (ret[i].id != 13)
				continue;

			index = i;
			break;
		}

		if (::Legends.Effects.has(this, ::Legends.Effect.LegendBerserkerRage)) {
			ret.insert(index, {
				id = 14,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Will add [color=%positive%]5[/color] stacks of [color=%effect%]Rage[/color] at the start of your turn if the character has [color=%perk%]Berserker Rage[/color]"
			});
		}
	}
});