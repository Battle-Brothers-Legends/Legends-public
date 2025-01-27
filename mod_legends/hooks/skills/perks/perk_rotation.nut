::mods_hookExactClass("skills/perks/perk_rotation", function(o) {
	o.onAdded = function()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Rotation))
		{
			if (this.getContainer().getActor().isPlayerControlled())
			{
				this.m.Container.add(this.new("scripts/skills/actives/rotation"));
			}

			else
			{
				this.m.Container.add(this.new("scripts/skills/actives/legend_ai_rotation_skill"));
			}
		}
	}

	o.onRemoved = function()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Rotation);
		::Legends.Actives.remove(this, ::Legends.Active.LegendAiRotation);
	}
});
