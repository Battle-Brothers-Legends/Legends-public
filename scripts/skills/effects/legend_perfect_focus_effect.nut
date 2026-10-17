this.legend_perfect_focus_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPerfectFocus);
		this.m.Description = "Has achieved perfect focus, as if time itself has stood still.";
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = true;
		this.m.IsHidden = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Action Points increased by [color=%positive%]3[/color] (stacks)"
			}
		]);
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		actor.setActionPoints(actor.getActionPoints() + 3);
	}

	function onUpdate(_properties) {
		if (!this.isGarbage()) {
			_properties.ActionPoints += 3;
		}
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + 3 * _stacks + "[/color] " + ::Legends.S.inlineIcon("action_points");
	}
});
