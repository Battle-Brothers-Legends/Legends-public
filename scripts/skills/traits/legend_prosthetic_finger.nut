this.legend_prosthetic_finger <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticFinger);
		this.m.Name = "Prosthetic Finger";
		this.m.Icon = "ui/traits/legend_prosthetic_finger.png";
		this.m.Description = "A wooden finger with a joint for the user to force it into whatever position they need. Perfect for pointing fingers at people, but not too much else.";
	}

	function getTooltip()
	{
		local ret = [
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
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-2%[/color] Melee Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-2%[/color] Ranged Skill"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult *= 0.98;
		_properties.RangedSkillMult *= 0.98;
	}

	function onApplyAppearance()
	{
	}

});
