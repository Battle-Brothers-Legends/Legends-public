this.legend_threw_sand_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendThrewSandEffect);
		this.m.Icon = "ui/perks/throw_sand_01.png";
		this.m.IconMini = "mini_throw_sand_circle";
		this.m.Overlay = "mini_throw_sand_circle"; //needs a big throw sand if players are gonna have it
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has thrown sand from their pockets and can't do so again this battle.";
	}
});
