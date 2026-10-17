this.legend_knocked_over_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendKnockedOver);
		this.m.Description = "Tackled and knocked over.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-50%[/color] melee defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-70%[/color] Initiative"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]+25%[/color] damage taken"
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
		_properties.MeleeDefense *= 0.5;
		_properties.Initiative *= 0.3;
		_properties.DamageReceivedTotalMult *= 1.25;

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
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("melee_defense") + ", [color=%negative%]-70%[/color] " + ::Legends.S.inlineIcon("initiative") + ", [color=%positive%]+25%[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
