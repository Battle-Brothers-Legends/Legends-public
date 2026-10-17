::mods_hookExactClass("skills/effects/taunt_effect", function (o) {
	o.m.TurnsLeft <- 1;

	o.getDescription <- function () {
		return "Has gotten the attention of nearby opponents by throwing a set of creative insults their way.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Present yourself as a [color=%positive%]+" + this.getBonus() + "%[/color] more attractive target"
			}
		]);
		return tooltip;
	}

	o.getBonus <- function () {
		return ::Math.minf(1.5, this.getContainer().getActor().getCurrentProperties().Bravery * 0.015);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Present yourself as a [color=%positive%]+" + this.getBonus() + "%[/color] more attractive target";
	}
});
