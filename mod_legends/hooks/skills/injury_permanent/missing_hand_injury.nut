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

	local onAdded = o.onAdded;
	o.onAdded = function ()
	{
		if (!m.IsNew) {
			getContainer().getActor().getItems().getData()[::Const.ItemSlot.Offhand][0] = -1;
			return;
		}

		if (!::Tactical.isActive() && getContainer().getActor().getItems().hasEmptySlot(::Const.ItemSlot.Bag)) {
			local main = getContainer().getActor().getMainhandItem();
			local off = getContainer().getActor().getOffhandItem();

			if (main && main.getBlockedSlotType() == ::Const.ItemSlot.Offhand) {
				getContainer().getActor().getItems().unequip(main);
				getContainer().getActor().getItems().addToBag(main);
			}
			else if (off) {
				getContainer().getActor().getItems().unequip(off);
				getContainer().getActor().getItems().addToBag(off);
			}
		}

		onAdded();
		m.IsNew = false;
	}

});
