this.perk_legend_patient_hunter <- this.inherit("scripts/skills/skill", {
	m = {
		IsEffectActive = false
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendPatientHunter);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onTurnEnd()
	{
		::Legends.Effects.grant(this, ::Legends.Effect.LegendPatientHunter, function(_skill) {
			_skill.m.ApBonus = this.Math.min(3, this.getContainer().getActor().getActionPoints());
		});
	}
});
