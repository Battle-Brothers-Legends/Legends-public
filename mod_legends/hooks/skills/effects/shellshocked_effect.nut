::mods_hookExactClass("skills/effects/shellshocked_effect", function (o) {
	o.getDescription = function () {
		return "Shellshocked from being near a mortar explosion. Ears ringing, vision blurred, slightly disoriented.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%negative%]-" + 5 * this.m.TurnsLeft + "%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + 5 * this.m.TurnsLeft + "%[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-" + 5 * this.m.TurnsLeft + "%[/color] Resolve"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-" + 5 * this.m.TurnsLeft + "%[/color] Melee Skill"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-" + 5 * this.m.TurnsLeft + "%[/color] Ranged Skill"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-" + 5 * this.m.TurnsLeft + "%[/color] Melee Defense"
			},
			{
				id = 17,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-" + 5 * this.m.TurnsLeft + "%[/color] Ranged Defense"
			},
			{
				id = 18,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The effect lessens every turn"
			}
		]);
		return tooltip;
	}

	o.onAdded = function () {
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in ::Tactical) && ::Tactical.State.isBattleEnded()) {
			this.removeSelf();
			return;
		}
		if (actor.getCurrentProperties().IsResistantToAnyStatuses && ::Math.rand(1, 100) <= 50) {
			if (!actor.isHiddenToPlayer()) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " resists being shellshocked thanks to their unnatural physiology");
			}

			this.removeSelf();
		} else {
			this.m.TurnsLeft = ::Math.max(1, 3 + actor.getCurrentProperties().NegativeStatusEffectDuration);

			if (this.m.SoundOnUse.len() != 0) {
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 0.8, actor.getPos());
			}

			actor.checkMorale(-1, 0);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (this.m.Stacks * 5) + "%[/color] " + ::Legends.S.inlineIcon(["damage_dealt", "melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "bravery", "initiative"]);
	}
});
