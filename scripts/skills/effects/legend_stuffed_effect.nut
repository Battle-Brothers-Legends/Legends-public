this.legend_stuffed_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendStuffedEffect);
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

