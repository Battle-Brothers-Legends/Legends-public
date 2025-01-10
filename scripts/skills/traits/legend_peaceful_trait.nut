this.legend_peaceful_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendPeaceful);
		this.m.Name = "Peaceful";
		this.m.Icon = "ui/traits/peaceful_trait.png";
		this.m.Description = "This character is not fond of fighting, and will prefer to be in reserve.";
		this.m.Titles = [
			"the Peaceful",
			"the Mild",
			"the Gentle"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles)
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]-5[/color] Melee and Ranged Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Melee and Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Has  [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] resolve"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
		_properties.Bravery += 10;
		_properties.MeleeSkill += -5;
		_properties.RangedSkill += -5;
		_properties.MeleeDefenseMult *= 1.05;
		_properties.RangedDefenseMult *= 1.05;
	}

});

