this.legend_summoned_hound_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSummonedHoundEffect);
		this.m.Icon = "ui/perks/dog_circle.png";
		this.m.IconMini = "mini_dog_circle";
		this.m.Overlay = "dog_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has summoned a hound, and may not summon another this combat.";
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});

