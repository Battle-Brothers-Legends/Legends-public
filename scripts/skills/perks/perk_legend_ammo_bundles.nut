this.perk_legend_ammo_bundles <- this.inherit("scripts/skills/skill", {
	m = {
		Ammo = 20
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAmmoBundles);
	}

	function getModifier()
	{
		return this.m.Ammo;
	}

	function onAdded()
	{
					if (::World.State.getPlayer() == null)
			{
				return;
			}

		::World.State.getPlayer().calculateAmmoModifier();
	}

	function onRemoved()
	{
					if (::World.State.getPlayer() == null)
			{
				return;
			}

		::World.State.getPlayer().calculateAmmoModifier();
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefenseMult *= 1.05;
	}

});
