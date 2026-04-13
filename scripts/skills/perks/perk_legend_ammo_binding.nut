this.perk_legend_ammo_binding <- this.inherit("scripts/skills/skill", {
	m = {
		Ammo = 10
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAmmoBinding);
	}

	function getModifier()
	{
		return this.m.Ammo;
	}

	function onAdded()
	{
					if (this.World.State.getPlayer() == null)
			{
				return;
			}

		this.World.State.getPlayer().calculateAmmoModifier();
	}

	function onRemoved()
	{
					if (this.World.State.getPlayer() == null)
			{
				return;
			}

		this.World.State.getPlayer().calculateAmmoModifier();
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkillMult *= 1.05;
	}

});
