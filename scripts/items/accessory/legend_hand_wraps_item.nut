this.legend_hand_wraps_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		isBrawlerItem = true
	},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_hand_wraps";
		this.m.Name = "Pugilist Hand Wraps";
		this.m.Description = "Simple cloth wrapped around the hands, protects the wearer from the impact of his own punches and allows them to hit harder.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/hand_wraps.png";
		this.m.Value = 35;
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

		result.extend(
		[
			{
				id = 15,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+2-6[/color] more damage on unarmed attacks."
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] more damage (multiplicative) on [color=#400080]Choke[/color]."
			}
		]);
		return result;
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_01.wav", this.Const.Sound.Volume.Inventory);
	}
});
