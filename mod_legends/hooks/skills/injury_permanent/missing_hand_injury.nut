this.mods_hookExactClass("skills/injury_permanent/missing_hand_injury", function(o)
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
		local items = this.getContainer().getActor().getItems();
		
		if (!this.m.IsNew)
		{
			items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
			return;
		}
		local actor = this.getContainer().getActor();
		local main = actor.getMainhandItem();
		local off = actor.getOffhandItem();
		local item;
		if (main && main.getBlockedSlotType() == this.Const.ItemSlot.Offhand)
			item = main;
		else if (off)
			item = off;

		if (item && (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded()))
		{
			items.unequip(item);
			if (items.hasEmptySlot(this.Const.ItemSlot.Bag))
			{
				items.addToBag(item);
			}
			else if (this.World.Assets.getStash().hasEmptySlot())
			{	
				this.World.Assets.getStash().add(item);
			}
			else
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
			}
		}
		else if (item)
		{
			items.unequip(item);
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
		this.m.IsNew = false;
	}

});
