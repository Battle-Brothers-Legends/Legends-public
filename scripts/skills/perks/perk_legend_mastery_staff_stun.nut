this.perk_legend_mastery_staff_stun <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecStaffStun);
	}


	function onUpdate( _properties )
	{
		_properties.IsSpecializedInStaffStun = true;
	}

});
