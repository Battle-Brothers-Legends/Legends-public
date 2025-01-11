this.legend_pugilist_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_pugilist";
		this.m.Name = "Pugilist";
		this.m.Icon = "ui/traits/pugilist_trait.png";
		this.m.Description = "This character has spent many years street fighting and sparring. This allows them to spot opportunities to catch opponents off guard with a jab, elbow or upper cut.  They have also taken a few hits to the head in their time and may not remember things too well";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.LegendFrail),
			::Legends.Traits.getID(::Legends.Trait.LegendPeaceful),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bleeder)
		];
	}

	function getTooltip()
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
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Melee Skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Chance To Hit Head"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] experience gain"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
		_properties.MeleeSkillMult *= 1.05;
		_properties.XPGainMult *= 0.9;
	}

});

