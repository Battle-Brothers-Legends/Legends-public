::mods_hookExactClass("skills/traits/hesitant_trait", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Excluded.extend(
		[
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		]);
	}

	o.getTooltip = function ()
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
				text = "Acts last in turn order, but can be faster under the effect of [color=%status%]Adrenaline[/color]"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			_properties.InitiativeForTurnOrderAdditional -= 1000;
		}
	}
});
