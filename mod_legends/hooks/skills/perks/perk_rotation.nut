::mods_hookExactClass("skills/perks/perk_rotation", function(o) {
	o.onAdded = function()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Rotation))
		{
			if (this.getContainer().getActor().isPlayerControlled())
			{
				::Legends.Actives.grant(this, ::Legends.Active.Rotation);
			}

			else
			{
				::Legends.Actives.grant(this, ::Legends.Active.LegendAiRotation);
			}
		}
	}

	o.onRemoved = function()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Rotation);
		::Legends.Actives.remove(this, ::Legends.Active.LegendAiRotation);
	}
});
