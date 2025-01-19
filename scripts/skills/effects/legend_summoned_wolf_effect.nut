this.legend_summoned_wolf_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		this.m.ID = "effects.legend_summoned_wolf_effect";
		this.m.Name = "Summoned a Wolf";
		this.m.Icon = "ui/perks/wolf_circle.png";
		this.m.IconMini = "mini_wolf_circle";
		this.m.Overlay = "wolf_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has summoned a wolf, and may not summon another this combat.";
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});

