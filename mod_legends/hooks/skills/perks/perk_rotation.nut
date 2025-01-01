::mods_hookExactClass("skills/perks/perk_rotation", function(o) {
	o.onAdded = function()
	{
		if (!this.m.Container.hasSkill("actives.rotation"))
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
		this.m.Container.removeByID("actives.rotation");
		this.m.Container.removeByID("actives.legend_ai_rotation_skill");
	}
});
