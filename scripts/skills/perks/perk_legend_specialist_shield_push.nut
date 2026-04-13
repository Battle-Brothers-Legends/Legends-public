this.perk_legend_specialist_shield_push <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistShieldPush);
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInShieldPush = true;
	}

});
