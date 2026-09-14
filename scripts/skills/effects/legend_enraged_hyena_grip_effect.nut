this.legend_enraged_hyena_grip_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendEnragedHyenaGrip);
		this.m.Description = "This hyena has locked onto its prey with a powerful bite, holding them firmly in its jaws.";
		this.m.Icon = "skills/legend_enraged_hyena_bite_effect.png";
		this.m.IconMini = "legend_enraged_hyena_bite_effect_mini";
		this.m.Overlay = "legend_enraged_hyena_bite_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = false;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be removed by attacking the hyena or by disengaging"
			}
		];
	}

});
