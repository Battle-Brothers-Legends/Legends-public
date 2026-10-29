this.perk_legend_mind_over_body <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMindOverBody);
		this.m.Description = "Push your body beyond what is humanly possible through your sheer force of will.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function getBonus(_actor = null) {
		if (_actor == null && this.getContainer() == null) {
			return 0;
		}

		local actor = _actor != null ? _actor : this.getContainer().getActor();

		if (actor == null) {
			return 0;
		}

		local resolve = actor.getCurrentProperties().getBravery();
		local fraction = resolve / 60.0;
		local normal = ::Math.floor(fraction * 100);
		local bonus = normal * 0.01;

		return bonus;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	function getDynamicTooltip(_actor = null) {
		local bonus = this.getBonus(_actor);
		if (bonus > 1) {
			bonus = ::Math.pow(bonus, 0.5);
		}
		local reduction = ::Math.round((1 - 1 / bonus) * 100);
		local tooltip = [];
		if (bonus > 1) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Fatigue costs reduced by [color=%positive%]-" + reduction + "%[/color]"
			});
		} else {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character does not have enough Resolve to benefit from Mind Over Body."
			});
		}

		return tooltip;
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus();
		if (bonus > 1) {
			bonus = ::Math.pow(bonus, 0.5);
			_properties.FatigueEffectMult *= 1.0 / bonus;
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local bonus = this.getBonus();
		return (bonus > 1 ? "[color=%negative%]-" + ::Math.round((1 - 1 / ::Math.pow(bonus, 0.5)) * 100) + "%[/color] " + ::Legends.S.inlineIcon("fatigue") + " costs" : null);
	}
});
