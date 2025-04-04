this.legend_oms_fate_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_oms_fate";
		this.m.Name = "The \'Book of Fate\'";
		this.m.Description = "This volume titled \'Book of Fate\' contains a single, thick page between two slabs of old leather from an unknown animal. The page is blank on both sides and stained throughout - some say that if the holder sees only a blank page they are fully in control of their destiny...or soon to die. This is possibly an elaborate scam, but you can\'t deny the item does feel much heavier than it should do.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUnique = true;
		//this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/oms_book_of_fate.png";
		//this.m.Sprite = "";
		this.m.Value = 1100;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		if (!this.World.Flags.get("Item Identified"))
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You aren\'t sure what it does. You\'ve heard of an ancient witch living in a hut in the forest who might know more about this"
			});
		}
		else
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Chance to survive after being struck down will always be zero. Gain +40% chance to reroll an attack that would normally hit you"
			});
		}

		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.SurviveWithInjuryChanceMult = 0.0;
		_properties.RerollDefenseChance += 40;
	}

});

