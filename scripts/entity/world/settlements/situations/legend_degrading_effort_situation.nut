this.legend_degrading_effort_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legend_degrading_effort";
		this.m.Name = "Town ";
		this.m.Description = "This settlement can no longer sustain its current size and is undergoing efforts to still remain productive during these difficult times.";
		this.m.Icon = "ui/settlement_status/degrading_effort_effect.png";
		this.m.Rumors = [
			"\'Lots of people comin\' out from %direction% lately..."
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.setUpgrading(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuildingPriceMult *= 0.5;
		_modifiers.BuildingRarityMult *= 0.55;
	}

	function onRemoved( _settlement )
	{
		_settlement.changeSize(_settlement.getSize() - 1);
	}

});

