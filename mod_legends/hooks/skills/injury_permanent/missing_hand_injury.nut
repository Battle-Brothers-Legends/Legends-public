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
		this.getContainer().getActor().getItems().getData()[::Const.ItemSlot.Offhand][0] = null;
	}

	o.onAdded = function ()
	{
		local items = this.getContainer().getActor().getItems();

		if (!this.m.IsNew) {
			items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
			return;
		}
		local actor = this.getContainer().getActor();
		local itemToUnequip = null;
		local oh = actor.getOffhandItem();
		local mh = actor.getMainhandItem();
		if (oh != null) { // unequip offhand
			itemToUnequip = oh;
		}
		else if (mh != null && mh.getBlockedSlotType() == ::Const.ItemSlot.Offhand) { // unequip 2handers
			itemToUnequip = mh;
		}

		if (itemToUnequip != null && (!actor.isPlacedOnMap() || ("State" in ::Tactical) && ::Tactical.State.isBattleEnded()))
		{   // in case outside battle
			items.unequip(itemToUnequip);
			if (items.hasEmptySlot(::Const.ItemSlot.Bag))
			{
				items.addToBag(itemToUnequip);
			}
			else if (this.World.Assets.getStash().hasEmptySlot())
			{
				this.World.Assets.getStash().add(itemToUnequip);
			}
			else
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(itemToUnequip);
			}
		}
		else if (itemToUnequip)
		{   // during battle
			items.unequip(itemToUnequip);
			itemToUnequip.drop(actor.getTile());
		}

		items.getData()[::Const.ItemSlot.Offhand][0] = -1;

		actor.setDirty(true);
		this.m.IsNew = false;
	}

});
