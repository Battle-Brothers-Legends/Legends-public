this.perk_legend_ammo_bundles <- this.inherit("scripts/skills/skill", {
	m = {
		Ammo = 20
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendAmmoBundles);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
		_properties.RangedDefenseMult *= 1.05;
	}

});
