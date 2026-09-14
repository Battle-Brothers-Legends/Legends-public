// this isn't currently used so i haven't renamed it
this.legend_marked_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMarkedTarget);
		this.m.Description = "This character has gotten the attention of nearby opponents and is more likely to be attacked over other potential targets.";
		this.m.Icon = "ui/perks/perk_38.png";
		this.m.IconMini = "perk_38_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 2.5;
	}

});

