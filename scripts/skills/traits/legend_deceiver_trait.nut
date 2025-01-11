this.legend_deceiver_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		Amount = 0.0015
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_deceiver";
		this.m.Name = "Deceiver";
		this.m.Icon = "ui/traits/deceiver_trait.png";
		this.m.Description = "This character lies all the time and has gotten good at it. They are good at bargaining, their feints are exeptional, as is their sleight of hand";
		this.m.Titles = [
			"the Lucky",
			"the Blessed"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted)
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
				id = 10,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+0.15%[/color] barter skill by lying to sales people"
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] chance to have any attacker require two successful attack rolls in order to hit"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Claims a [color=" + this.Const.UI.Color.NegativeValue + "]+50%[/color] daily wage by stealing from the company coffers"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RerollDefenseChance += 20;
		_properties.DailyWageMult *= 1.5;
	}
	
	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
	}
	
	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
	}
});

