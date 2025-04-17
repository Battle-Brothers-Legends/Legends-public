this.legend_oms_paw_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_oms_paw";
		this.m.Name = "Curious Paw";
		this.m.Description = "A preserved hand that is somewhere between that of a large man and a beast. It has been cleanly cut at the wrist and shows no sign of decay.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUnique = true;
		//this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "misc/inventory_werehand.png";
		//this.m.Sprite = "nachzehrer_trophy";
		this.m.Value = 2345;
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
				text = "Adds an addition +6 to fatigue recovery per turn. Increases the effect from morale effects and mental attacks by 50%"
			});
		}

		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.FatigueRecoveryRate += 6;
		_properties.MoraleEffectMult *= 1.50; //50% more effected by morale checks and mental attacks
	}

});

