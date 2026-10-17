this.legend_song_of_life_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSongOfLife);
		this.m.Description = "Has been rejuvenated.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Unaffected by Song of Life"
			}
		]);
		return tooltip;
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Unaffected by Song of Life";
	}
});
