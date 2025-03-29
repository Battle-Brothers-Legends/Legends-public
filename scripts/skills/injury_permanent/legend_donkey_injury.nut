this.legend_donkey_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.legend_donkey_background";
		this.m.Name = "Donkey body";
		this.m.Icon = "ui/traits/legend_donkey_body.png";
		this.m.Description = "Can\'t use weapons, shields, ammunition or armor. The donkey does not seem bothered by these limitations.";
	}

	function getTooltip()
	{
		local ret = [
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
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded() //seems that restricting bag slots here breaks the game, will need to find a new way to restrict bag slots in the future - Luft.
	{
		local items = this.getContainer().getActor().getItems();
			//ineloquent solution for forcing the item assigned to any of these slots via hotkey to be unassigned and returned to ground or stash. We squish this code later.
			//Note that 'item.unequip();' does not work.
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Head))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Head);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Body))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Body);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Ammo))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Ammo);
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Accessory))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Accessory);
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
		items.getData()[this.Const.ItemSlot.Mainhand][0] = -1;
		items.getData()[this.Const.ItemSlot.Head][0] = -1;
		items.getData()[this.Const.ItemSlot.Body][0] = -1;
		items.getData()[this.Const.ItemSlot.Ammo][0] = -1;
		items.getData()[this.Const.ItemSlot.Accessory][0] = -1;
	}

	function onUpdate (_properties)
	{
		_properties.IsContentWithBeingInReserve = true;
	}
});