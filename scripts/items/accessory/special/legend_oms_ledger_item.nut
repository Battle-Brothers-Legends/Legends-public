this.legend_oms_ledger_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_oms_tome";
		this.m.Name = "Bound Skin Ledger";
		this.m.Description = "A small ledger that is made of skin, inside the pages are names laid out in rows, some crossed or or with symbols beside them. Closing and opening the book again results in the names and markings changing once again.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUnique = true;
		//this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/oms_ledger.png";
		//this.m.Sprite = "";
		this.m.Value = 1725;
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
				text = "Melee damage received from undead reduced by 50%"
			});
		}

		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		if (this.Tactical.Entities.getInstancesNum(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID()) != 0)
		{
			_properties.DamageReceivedMeleeMult *= 0.50;
		}
	}

});

