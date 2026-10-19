::mods_hookExactClass("skills/effects/berserker_mushrooms_effect", function (o) {
	o.onTurnStart <- function () {
		local rage = ::Legends.Effects.get(this, ::Legends.Effect.LegendBerserkerRage);
		if (rage != null) {
			rage.addRage(5);
		}
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/turns_left.png",
				text = "Will be gone after 1 battle"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+25%[/color] Melee Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-15[/color] Melee Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-15[/color] Ranged Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			},
		]);
		if (::Legends.Effects.has(this, ::Legends.Effect.LegendBerserkerRage)) {
			tooltip.push({
				id = 14,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Adds [color=%positive%]5[/color] stacks of [color=%perk%]Berserker Rage[/color]'s [color=%effect%]Rage[/color] at the start of the character's turn"
			});
		}
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		local tooltip = "[color=%positive%]+25%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ", [color=%negative%]-15[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense"]) + ",  no morale check on " + ::Legends.S.inlineIcon("damage_received");
		if (::Legends.Effects.has(this, ::Legends.Effect.LegendBerserkerRage)) {
			tooltip += ", [color=%negative%]+5[/color] Rage stacks every turn";
		}
		return tooltip;
	}
});
