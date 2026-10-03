this.legend_summoned_wolf_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSummonedWolf);
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription() {
		return "This character has summoned a wolf, and may not summon another this combat.";
	}

	function onCombatFinished() {
		this.removeSelf();
	}
});
