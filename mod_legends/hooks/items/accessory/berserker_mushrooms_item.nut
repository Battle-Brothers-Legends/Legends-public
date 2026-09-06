::mods_hookExactClass("items/accessory/berserker_mushrooms_item", function (o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		local index = ret.len() - 1;

		for (local i = ret.len() - 1; i >= 0; --i) {
			if (ret[i].id == 13) {
				index = i;
				break;
			}
		}

		local actor = ::World.State.m.CharacterScreen.getSelectedActor();
		if (::World.State.isInCharacterScreen()	&& actor != null && ::Legends.Effects.has(actor, ::Legends.Effect.LegendBerserkerRage)) {
			ret.insert(index, {
				id = 14,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Adds [color=%positive%]5[/color] stacks of [color=%perk%]Berserker Rage[/color]'s [color=%effect%]Rage[/color] at the start of the character's turn"
			});
		}
		return ret;
	}
});
