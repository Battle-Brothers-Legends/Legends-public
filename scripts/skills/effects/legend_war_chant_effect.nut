this.legend_war_chant_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		Bonus = null
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendWarChant);
		this.m.Description = "Has been warmed up to fight.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Only affected by half of [color=%effect%]War Chant[/color]"
		});
		return tooltip;
	}

	function onRefresh() {
		local actor = this.getContainer().getActor();
		actor.setFatigue(::Math.max(0, actor.getFatigue() - ::Math.max(1, ::Math.floor(this.m.Bonus * 0.5))));
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		actor.setFatigue(::Math.max(0, actor.getFatigue() - this.m.Bonus));
	}

	function onRemoved() {
		this.m.Bonus = null;
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Only affected by half of [color=%effect%]War Chant[/color]";
	}
});
