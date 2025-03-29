this.legend_broken_throwing_net <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "tool.legend_broken_throwing_net";
		this.m.Name = "Broken Throwing Net";
		this.m.Description = "A broken net that may be repaired if you have the knowledge, or sold for scrap";
		this.m.IconLarge = "tools/inventory_throwing_net_broken.png";
		this.m.Icon = "tools/throwing_net_broken_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting | this.Const.Items.ItemType.Net;
		this.m.Value = 5;
		this.m.IsDroppedAsLoot = true;
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 64,
			type = "text",
			text = "Cannot be equipped until fixed"
		});

		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
	}

	function isAmountShown()
	{
		return true;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

});

