this.perk_legend_horse_flying_change <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseFlyingChange);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += 1;
	}

});

