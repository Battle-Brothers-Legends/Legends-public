this.legend_grappled_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendGrappled);
		this.m.Description = "Grappled to the ground and exhausted in the clinch.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-12[/color] melee defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-30%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onRefresh() {
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_87", this.getContainer().getActor().getTile());
	}

	function onRemoved() {
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned)) {
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		_properties.MeleeDefense -= 12;
		_properties.Initiative *= 0.7;

		if (!actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned)) {
			actor.getSprite("status_stunned").setBrush("bust_dazed");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-12[/color] " + ::Legends.S.inlineIcon("melee_defense") + ", [color=%negative%]-30%[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
