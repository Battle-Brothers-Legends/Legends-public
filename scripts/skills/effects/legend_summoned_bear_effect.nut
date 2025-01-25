this.legend_summoned_bear_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSummonedBearEffect);
		this.m.Icon = "ui/perks/bear_circle.png";
		this.m.IconMini = "mini_bear_circle";
		this.m.Overlay = "bear_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has summoned a bear, and may not summon another this combat.";
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});

