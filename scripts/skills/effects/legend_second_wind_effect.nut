this.legend_second_wind_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		this.m.ID = "effects.legend_second_wind";
		this.m.Name = "Second Wind";
		this.m.Icon = "ui/perks/SecondWindPerk.png";
		this.m.IconMini = "mini_second_wind";
		this.m.Overlay = "perk_54_active";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has had a second wind and may not have another this combat.";
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});

