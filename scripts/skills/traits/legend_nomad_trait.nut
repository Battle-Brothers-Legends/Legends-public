this.legend_nomad_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendNomad);
		this.m.Name = "Nomad";
		this.m.Icon = "ui/traits/trait_icon_00.png";
		this.m.Description = "This trait is used to alter daily reputation decline for city state factions and increase nomad relatiosn per head. Stop using breditor you cheating fuck.";
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
				text = "This trait is used to alter daily reputation decline for city state factions and increase that of the nomad faction. If you can see this tooltip then something is broken - or someone is fucking with things that they shouldn\'t be."
			}
		];
	}

	function onUpdate( _properties )
	{
	}

	function onNewDay()
	{
		local citystatefaction = [];
		local nomadfaction = [];
		citystatefaction.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState)); 
		nomadfaction.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalBandits)); 

		foreach( f in citystatefaction )
		{ //Relations: 0 = hostile, 100 = allied
			if (f.m.PlayerRelation > 30) //rests at 30
			{
				f.m.PlayerRelation = this.Math.minf(100.0, this.Math.max(0.0, f.m.PlayerRelation - 0.1));  //-0.1 reputation per day per unit in company.
				f.updatePlayerRelation();
			}
		}
		foreach( f in nomadfaction )
		{ //Relations: 0 = hostile, 100 = allied
			if (f.m.PlayerRelation > 0) //rests at 0
			{
				f.m.PlayerRelation = this.Math.minf(100.0, this.Math.max(0.0, f.m.PlayerRelation + 0.1));  //-0.1 reputation per day per unit in company.
				f.updatePlayerRelation();
			}
		}
	}
});

