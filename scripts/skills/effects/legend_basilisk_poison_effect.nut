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
		local param = [
			["_20malus", 20 * this.m.Stacks],
			["_3malus", 3 * this.m.Stacks]
		];
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-%_20malus%[/color] Resolve",
				param = param
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-%_20malus%[/color]% Max Fatigue",
				param = param
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue_recovery_down.png",
				text = "[color=%negative%]-%_3malus%[/color] Fatigue Recovery",
				param = param
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-%_20malus%[/color]% Initiative",
				param = param
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/block.png",
				text = "[color=%negative%]-%_20malus%[/color]% Initiative",
				param = param
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
		_properties.BlockMult *= 1.0 - 0.2 * this.m.Stacks;
	}

	function onTurnEnd() {
		this.m.TurnsLeft--;
		this.m.Stacks = this.m.TurnsLeft;
		if (this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (this.m.Stacks * 20) + "[/color] " + ::Legends.Text.inlineIcons("bravery") + ", " + "[color=%negative%]-" + (this.m.Stacks * 20) + "%[/color] " + ::Legends.Text.inlineIcons(["fatigue", "initiative"]) + ", [color=%negative%]-" + (this.m.Stacks * 3) + "[/color] " + ::Legends.Text.inlineIcons("fatigue_recovery_down");
	}
});
