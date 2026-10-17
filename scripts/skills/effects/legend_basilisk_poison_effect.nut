this.legend_basilisk_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 3,
		TurnsLeft = 3
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBasiliskPoison);
		this.m.Description = "%Their% veins are black and bloated, tears swell in their eyes, and %their% breathing is shallow.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-" + 20 * this.m.Stacks + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-" + 20 * this.m.Stacks + "[/color]% Max Fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue_recovery_down.png",
				text = "[color=%negative%]-" + 3 * this.m.Stacks + "[/color] Fatigue Recovery"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + 20 * this.m.Stacks + "[/color]% Initiative"
			}
		]);
		return tooltip;
	}

	function resetTime() {
		this.m.TurnsLeft = ::Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing)) {
			++this.m.TurnsLeft;
		}
		this.m.Stacks = this.m.TurnsLeft;
	}

	function onAdded() {
		this.resetTime();
	}

	function onUpdate(_properties) {
		_properties.Bravery -= 20 * this.m.Stacks;
		_properties.StaminaMult *= 1.0 - 0.2 * this.m.Stacks;
		_properties.FatigueRecoveryRate -= 3 * this.m.Stacks;
		_properties.InitiativeMult *= 1.0 - 0.2 * this.m.Stacks;
	}

	function onTurnEnd() {
		this.m.TurnsLeft--;
		this.m.Stacks = this.m.TurnsLeft;
		if (this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (this.m.Stacks * 20) + "[/color] " + ::Legends.S.inlineIcon("bravery") + ", " + "[color=%negative%]-" + (this.m.Stacks * 20) + "%[/color] " + ::Legends.S.inlineIcon("fatigue") + ::Legends.S.inlineIcon("initiative") + ", [color=%negative%]-" + (this.m.Stacks * 3) + "[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_down");
	}
});
