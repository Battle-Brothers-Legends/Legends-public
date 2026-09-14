::mods_hookExactClass("skills/traits/night_owl_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Some characters adapt to low light conditions better than others, and this individual is especially good at it. Halves the usual night penalties";
	}

	o.getTooltip = function ()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%positive%]+1[/color] Vision during Night time"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+15%[/color] Ranged Skill during Night time"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+15%[/color] Ranged Defense during Night time"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().hasEffect(::Legends.Effect.Night) && _properties.IsAffectedByNight)
		{
			_properties.Vision += 1;
			_properties.RangedSkillMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
		}
	}
});
