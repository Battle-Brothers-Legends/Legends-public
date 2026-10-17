this.legend_zombie_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 10,
		TurnsStart = 10
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendZombiePoison);
		this.m.Description = "Zombie infection is running through %their% veins. %Their% vision is blurred, %their% speech is slurred, and it takes a great deal of effort for them to move in a coordinated fashion. The effect slowly gets worse.";
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]-" + bonus + "[/color] Action Points"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-" + bonus + "[/color] Vision"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + 10 * bonus + "[/color] Initiative"
			}
		]);
		return tooltip;
	}

	function getBonus() {
		return this.m.TurnsStart + 1 - this.m.TurnsLeft;
	}

	function resetTime() {
		this.m.TurnsLeft = ::Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		if (this.getContainer().hasTrait(::Legends.Trait.Ailing)) {
			++this.m.TurnsLeft;
		}
		this.m.TurnsStart = this.m.TurnsLeft;
	}

	function onAdded() {
		this.resetTime();
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus();
		_properties.ActionPoints -= bonus;
		_properties.Initiative -= 10 * bonus;
		_properties.Vision -= bonus;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local bonus = this.getBonus();
		return "[color=%negative%]-" + bonus + "[/color] " + ::Legends.S.inlineIcon("action_points") + ::Legends.S.inlineIcon("vision") + ", [color=%negative%]-" + (bonus * 10) + "[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
