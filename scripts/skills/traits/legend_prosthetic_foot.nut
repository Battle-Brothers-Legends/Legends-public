this.legend_prosthetic_foot <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		IsUpgraded = false
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticFoot);
		this.m.Name = "Prosthetic Foot";
		this.m.Icon = "ui/traits/legend_prosthetic_foot.png";
		this.m.Description = "Amputation is a thing of life, and the wearer of this prosthetic foot was lucky enough to be given a replacement after the removal of their maimed one. It\'s awful to walk on, but at least you can walk.";
		if (this.m.IsUpgraded)
		{
			this.m.Name = "Enhanced Prosthetic Foot";
			this.m.Description = "Amputation might be a part of mercenary life, but not only can the replacement be comfortable to walk with but also useful.";
		}
	}

	function getTooltip()
	{
		local malusIni = this.m.IsUpgraded ? 5 : 10;
		local malusFat = this.m.IsUpgraded ? 1 : 3;
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
				text = "Builds up [color=%negative%]"+ malusFat + "[/color] more fatigue for each tile travelled"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-"+ malusIni + "%[/color] Initiative"
			}
		];
	}

	function onUpdate (_properties)
	{
		if (!this.m.IsUpgraded)
		{
			_properties.MovementFatigueCostAdditional += 3;
			_properties.InitiativeMult *= 0.9;
		}
		else
		{
			_properties.MovementFatigueCostAdditional += 1;
			_properties.InitiativeMult *= 0.95;
		}
	}
});
