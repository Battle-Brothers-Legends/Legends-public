this.legend_seductive_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		Amount = 0.003
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendSeductive);
		this.m.Name = "Seductive";
		this.m.Icon = "ui/traits/trait_seductive.png";
		this.m.Description = "Although many things can be taken at the point of a sword, some things will always be more potent than cold steel; the flash of an eyelash, the locking of a gaze...";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
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
				icon = "ui/icons/asset_money.png",
				text = "[color=%positive%]+0.3%[/color] barter skill"
			},
		];
	}

	function getModifier()
	{
		return this.m.Amount;
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

