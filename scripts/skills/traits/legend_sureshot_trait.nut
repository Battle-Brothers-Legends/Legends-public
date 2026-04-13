this.legend_sureshot_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendSureshot);
		this.m.Name = "Sureshot";
		this.m.Icon = "ui/traits/sureshot_trait.png";
		this.m.Description = "Takes time to hit the exact right spot on a target, this in turn makes them an easier target";
		this.m.Titles = [
			"Sureshot",
			"the Patient"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Quick)
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
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+10%[/color] Ranged Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-10[/color] Ranged Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RangedDamageMult *= 1.1;
		_properties.RangedDefense -= 10;
	}

});

