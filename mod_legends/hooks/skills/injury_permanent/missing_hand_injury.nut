::mods_hookExactClass("skills/injury_permanent/missing_hand_injury", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "Uh-oh! Unless something is done about this, missing a hand will prevent this character from using shields, two-handed weapons, throwing nets and from double gripping one-handed weapons.";
	}

	o.onRemoved <- function ()
	{
		this.getContainer().getActor().getItems().getData()[this.Const.ItemSlot.Offhand][0] = null;
	}

	o.onAdded = function ()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
			return;
		local items = actor.getItems();

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) && items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() == this.Const.ItemSlot.Offhand)
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			items.unequip(item);
			if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
				item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			items.unequip(item);
			if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
				item.drop();
		}
		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
	}

});
