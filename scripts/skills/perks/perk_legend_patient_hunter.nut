this.perk_legend_patient_hunter <- this.inherit("scripts/skills/skill", {
	m = {
		IsEffectActive = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPatientHunter);
		// this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function onTurnEnd()
	{
		::Legends.Effects.grant(this, ::Legends.Effect.LegendPatientHunter, function(_skill) {
			_skill.m.ApBonus = this.Math.min(3, this.getContainer().getActor().getActionPoints());
		}.bindenv(this));
	}
});
