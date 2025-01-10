this.legend_necromancer_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendNecromancer);
		this.m.Name = "Necromancer";
		this.m.Icon = "ui/traits/trait_icon_00.png";
		this.m.Description = "This trait is used to alter daily reputation decline for all factions.";
		this.m.IsHidden = true; //should not be shown.
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
				icon = "ui/icons/special.png",
				text = "In theroy we could just tell you how to make mustard gas in this tooltip and the feds would be none the wiser"
			}
		];
	}

	function onAdded() //removes hate undead trait
	{
		if (this.m.Container.hasTrait(::Legends.Trait.HateUndead))
		{
			::Legends.Traits.remove(this, ::Legends.Trait.HateUndead);
		}		
	}

	function onUpdate( _properties )
	{
	}

	function onNewDay()
	{
		local factions = [];
		factions.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse)); //norf
		factions.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement)); //norf but poor
		factions.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState)); //souf

		foreach( f in factions )
		{ //Relations: 0 = hostile, 100 = allied
			if (f.m.PlayerRelation > 30)
			{
			f.m.PlayerRelation = this.Math.minf(100.0, this.Math.max(0.0, f.m.PlayerRelation - 0.1));  //-0.1 reputation per day per unit in company.
			f.updatePlayerRelation();
			}
		}
	}
});

