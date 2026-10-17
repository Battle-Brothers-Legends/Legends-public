this.legend_cheered_on_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false,
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendCheeredOn);
		this.m.Description = "Encouraged by hearing just the right words, ready to give it %their% all.";
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded() {}

	function onUpdate(_properties) {
		_properties.ActionPoints += 2;
	}

	function onTurnStart() {
		if (!this.m.IsApplied) {
			local actor = this.getContainer().getActor();
			actor.setActionPoints(actor.getActionPoints() + 2);
			this.m.IsApplied = true;
		}
	}

	function onResumeTurn() {
		if (!this.m.IsApplied) {
			local actor = this.getContainer().getActor();
			actor.setActionPoints(actor.getActionPoints() + 2);
			this.m.IsApplied = true;
		}
	}

	function onTurnEnd() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+2[/color] " + ::Legends.S.inlineIcon("action_points");
	}
});
