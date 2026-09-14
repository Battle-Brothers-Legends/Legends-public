this.legend_scroll_preview_item <- ::inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_scroll_preview";
		this.m.Name = "Scroll";
		this.m.Description = "A freshly minted scroll. Could be a masterpiece used to train your mercenaries or gibberish that will be of interest to local scribes.";
		this.m.Icon = "trade/scroll.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUsable = true;
		this.m.Value = 500;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = getName()
			},
			{
				id = 2,
				type = "description",
				text = getDescription()
			},
			{
				id = 66,
				type = "text",
				text = getValueString()
			},
			{
				id = 3,
				type = "image",
				image = getIcon()
			}
		];
	}
});
