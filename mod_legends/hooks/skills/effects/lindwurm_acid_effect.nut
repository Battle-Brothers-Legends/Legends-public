::mods_hookExactClass("skills/effects/lindwurm_acid_effect", function (o) {
	o.getDescription = function () {
		return "%Their% armor is slowly being eaten away by Lindwurm's acidic blood.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		local flags = this.getContainer().getActor().getFlags();
		if (!flags.has("head_immune_to_acid")) {
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=%negative%]10%[/color] of head armor is lost each turn"
			});
		}
		if (!flags.has("body_immune_to_acid")) {
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[color=%negative%]10%[/color] of body armor is lost each turn"
			});
		}
		return tooltip;
	}

	local onAdded = o.onAdded;
	o.onAdded = function () {
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in ::Tactical) && ::Tactical.State.isBattleEnded()) {
			this.removeSelf();
			return;
		}
		onAdded();
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		local flags = this.getContainer().getActor().getFlags();
		local icons = "" + (!flags.has("body_immune_to_acid") ? ::Legends.S.inlineIcon("armor_body") : "") + (!flags.has("head_immune_to_acid") ? ::Legends.S.inlineIcon("armor_head") : "");
		return "[color=%negative%]-" + 10 * _stacks + "%[/color] " + icons + " every turn";
	}
});
