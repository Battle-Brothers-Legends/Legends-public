this.perk_legend_clarity <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendClarity);
		this.m.Description = "A well honed mind can perceive more in each moment, making time appear slower in key instants of need.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=%positive%]+" + this.calculateBonus() + "%[/color] of any damage ignores armor"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.DamageDirectAdd += this.calculateBonus();
	}

	function calculateBonus() {
		local actor = this.getContainer().getActor();
		local bonus = 0;
		if (!actor.getSkills().hasEffect(::Legends.Effect.Dazed) && !actor.getSkills().hasEffect(::Legends.Effect.Drunk) && !actor.getSkills().hasEffect(::Legends.Effect.Taunted) && !actor.getSkills().hasEffect(::Legends.Effect.Hangover) && !actor.getSkills().hasEffect(::Legends.Effect.Staggered) && !actor.getSkills().hasEffect(::Legends.Effect.Horrified) && !actor.getSkills().hasSkill("injury.severe_concussion") && this.getContainer().getActor().getMoraleState() >= ::Const.MoraleState.Wavering) {
			bonus += 0.1;
		}
		if (actor.getSkills().hasEffect(::Legends.Effect.IronWill) || actor.getSkills().hasEffect(::Legends.Effect.RecoveryPotion) || actor.getSkills().hasEffect(::Legends.Effect.LionheartPotion) || actor.getSkills().hasEffect(::Legends.Effect.CatPotion) || actor.getSkills().hasEffect(::Legends.Effect.LegendHexeIchor)) {
			bonus += 0.1;
		}
		return bonus;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.calculateBonus() * 100 + "%[/color] " + ::Legends.S.inlineIcon("direct_damage");
	}
});
