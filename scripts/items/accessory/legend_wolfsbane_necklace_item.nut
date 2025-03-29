this.legend_wolfsbane_necklace_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_wolfsbane_necklace";
		this.m.Name = "Wolfsbane Necklace";
		this.m.Description = "This necklace fashioned from wolfsbane is used to surpress therianthropic beastly transformations.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/wolfsbane_necklace.png";
		this.m.Sprite = "wolfsbane_necklace";
		this.m.Value = 100;
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

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Stops the wearer transforming into a werecreature"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.FatigueRecoveryRate += 1;
	}

	function onEquip()
	{
		this.accessory.onEquip();
		this.addSkill(::Legends.Effects.new(::Legends.Effect.LegendWolfsbane));
	}

	function onUnequip()
	{
		this.accessory.onUnequip();
		if (this.getContainer().getActor() != null)
		{
			::Legends.Effects.remove(this, ::Legends.Effect.LegendWolfsbane);
		}

	}


});

