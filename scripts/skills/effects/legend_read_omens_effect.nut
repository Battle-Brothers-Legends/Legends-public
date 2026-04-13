this.legend_read_omens_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Actor = null
	},
	function setActor(_a)
	{
		this.m.Actor = _a;
	}
	function getActor()
	{
		return this.m.Actor;
	}
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendReadOmens);
		this.m.Icon = "ui/perks/omens_circle.png";
		this.m.IconMini = "mini_omens_circle";
		this.m.Overlay = "omens_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = true;
	}

	function getDescription()
	{
		return "This character has had their future foretold and has a [color=%positive%]10%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
	}

	function onUpdate( _properties )
	{
		_properties.RerollDefenseChance += 15;
	}
});

