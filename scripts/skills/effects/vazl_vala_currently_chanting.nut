this.vazl_vala_currently_chanting <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.vazl_vala_currently_chanting";
		this.m.Name = "Currently Chanting";
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.IconMini = "perk_28_mini";
		this.m.Overlay = "perk_28";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
//		this.m.IsRemovedAfterBattle = true;
	}


	function isHidden()
	{
		return false;
	}


	function getTooltip()
	{
		if (!this.isHidden())
		{
			return [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = "This character is currently chanting"
				}
			];
		}
		else
		{
			return;
		}
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});
