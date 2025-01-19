this.legend_summoned_catapult_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		this.m.ID = "effects.legend_summoned_catapult_effect";
		this.m.Name = "Summoned a Catapult";
		this.m.Icon = "ui/perks/catapult_circle.png";
		this.m.IconMini = "mini_catapult_circle";
		this.m.Overlay = "catapult_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has constructed a catapult, and may not summon another this combat.";
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});

