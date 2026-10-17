this.legend_war_chant_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendWarChant);
		this.m.Description = "Has been warmed up to fight.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Unaffected by War Chant"
			}
		]);
		return tooltip;
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Unaffected by War Chant";
	}
});
