this.legend_immobilized_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendImmobilized);
		this.m.Description = "Immobilized and can't properly defend %themselves%.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%negative%]Unable to move[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-35%[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-35%[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-35%[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/block.png",
				text = "[color=%negative%]-35%[/color] Block"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		if (!::Tactical.isActive()) {
			this.removeSelf();
			return;
		}

		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 0.65;
		_properties.RangedDefenseMult *= 0.65;
		_properties.InitiativeMult *= 0.65;
		_properties.BlockMult *= 0.65;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-35%[/color] " + ::Legends.Text.inlineIcons(["melee_defense", "ranged_defense", "initiative"], ", unable to move");
	}
});
