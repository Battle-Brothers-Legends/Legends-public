this.perk_legend_staff_block <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStaffBlock);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getMainhandItem() == null || !actor.getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Staff))
			return;
		if (_properties.IsImmuneToSurrounding == true || actor.getSkills().hasPerk(::Legends.Perk.Underdog))
		{
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		}
		else
		{
			_properties.SurroundedDefense += 5;
		}
	}

});
