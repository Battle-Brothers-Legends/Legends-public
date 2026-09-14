this.legend_vala_warden_damage <- this.inherit("scripts/skills/skill", {
	m = {
		DamageBonus = 0.0
	},
	function setDamageBonus(_b)
	{
		this.m.DamageBonus = _b;
	}
	function getDamageBonus()
	{
		return (this.m.DamageBonus / 20.0);
	}
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaWardenDamage);
		this.m.Description = "Warden Damage Scaling";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}
});
