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
		local item = actor.getOffhandItem();
		if (item == null)
			item = actor.getMainhandItem();

		if (item == null)
			return; // no weps case

		if (!(item.getBlockedSlotType() == ::Const.ItemSlot.Offhand || item.getCurrentSlotType() == ::Const.ItemSlot.Offhand))
			return; // some items do not have offhand as blocked even when they're offhand like shields

		if (item && (!actor.isPlacedOnMap() || ::FU.HasTacticalState() && ::FU.IsBattleEnded()))
		{   // in case outside battle
			items.unequip(item);
			if (items.hasEmptySlot(::Const.ItemSlot.Bag))
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
		{   // during battle
			items.unequip(item);
			item.drop(actor.getTile());
		}

		items.getData()[::Const.ItemSlot.Offhand][0] = -1;

		actor.setDirty(true);
		this.m.IsNew = false;
	}

});
