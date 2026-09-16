this.perk_legend_specialist_musician <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponTypes = [
			::Const.Items.WeaponType.Musical
		],
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistMusician);
		this.m.IconMini = "perk_spec_bard_mini";
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null && item.isWeaponType(::Const.Items.WeaponType.Musical))
			_properties.MeleeDefense += 10;
	}
});
