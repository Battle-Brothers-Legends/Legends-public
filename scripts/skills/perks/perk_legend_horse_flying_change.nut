this.perk_legend_horse_flying_change <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseFlyingChange);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += 1;
	}

});

