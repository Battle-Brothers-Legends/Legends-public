this.legend_hexe_ichor_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 4
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHexeIchor);
		this.m.Description = "Having imbibed a concoction of dubious ingredients, this character feels a second wind.";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DrugEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue_recovery_up.png",
				text = "[color=%positive%]+20[/color] Fatigue Recovery per turn"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "[color=%positive%]+20[/color] Health Recovery per turn"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.FatigueRecoveryRate += 20;
		_properties.HitpointsRecoveryRate += 20;
	}

	function onAdded() {
		this.m.TurnsLeft = 4;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("action_points") + " costs halved";
	}
});
