this.legend_frail_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendFrail);
		this.m.Name = "Frail";
		this.m.Icon = "ui/traits/frail_trait.png";
		this.m.Description = "Weak and loose. Has to work hard to become a real warrior.";
		this.m.Titles = [
			"the Weak",
			"the Feeble"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
			::Legends.Traits.getID(::Legends.Trait.LegendFirm),
			::Legends.Traits.getID(::Legends.Trait.LegendHeavy)
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
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Hitpoints"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Fatigue"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Experience Gain"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.XPGainMult *= 0.95;
		_properties.Hitpoints -= 3;
		_properties.Stamina -= 3;
	}

});

