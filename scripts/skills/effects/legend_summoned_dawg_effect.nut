this.legend_summoned_dawg_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSummonedDawgEffect);
		this.m.Icon = "skills/dawg_circle.png";
		this.m.IconMini = "mini_dawg_circle";
		this.m.Overlay = "dawg_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription() {
		return "This character has summoned a dawg, and may not summon another this combat.";
	}

	function onCombatFinished() {
		this.removeSelf();
	}
});
