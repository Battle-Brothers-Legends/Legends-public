this.legend_satiated_effect <- this.inherit("scripts/skills/skill", {
	m = {
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSatiatedEffect);
		this.m.Icon = "s";
		this.m.IconMini = "";
		this.m.Overlay = "";
		this.m.Type = this.Const.SkillType.DrugEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has eaten and drunken enough";
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});

