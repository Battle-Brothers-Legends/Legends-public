this.legend_stuffed_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		this.m.ID = "effects.legend_stuffed_effect";
		this.m.Name = "Stuffed";
		this.m.Icon = "";
		this.m.IconMini = "";
		this.m.Overlay = "";
		this.m.Type = this.Const.SkillType.DrugEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has eaten too much.";
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}
});

