this.legend_patient_hunter_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ApBonus = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPatientHunter);
		this.m.Description = "This character has carefully weighed their options and gathered their strength for maximum effectiveness.";
		this.m.Icon = "ui/perks/patient_hunter.png";
		this.m.IconMini = "patient_hunter_mini";
		this.m.Overlay = "patient_hunter_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 12,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%positive%]+" + this.m.ApBonus + "[/color] Action Points until the end of your turn"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += this.m.ApBonus;
	}

	function onTurnEnd()
	{
		this.m.ApBonus = this.Math.min(3, this.getContainer().getActor().getActionPoints());
		if (this.m.ApBonus == 0)
			this.removeSelf();
	}
});
