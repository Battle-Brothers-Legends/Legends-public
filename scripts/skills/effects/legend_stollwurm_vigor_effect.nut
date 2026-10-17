this.legend_stollwurm_vigor_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendStollwurmVigor);
		this.m.Description = "Drinking the essence of a Stollwurm has made this character indomitable.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]-50%[/color] Damage Received"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being stunned"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Makes enemies less likely to attack you instead of an ally."
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.DamageReceivedTotalMult *= 0.5;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.TargetAttractionMult *= 0.5;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Stun, Knockback and Grab, [color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("damage_received") + ", less likely to be targeted";
	}
});
