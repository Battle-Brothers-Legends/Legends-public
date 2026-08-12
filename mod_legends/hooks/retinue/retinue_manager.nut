::mods_hookExactClass("retinue/retinue_manager", function (o) {
	o.m.OwnedFollowerIDs <- [];

	local create = o.create;
    o.create = function () {
        create();
        this.m.Slots.resize(10);
    }

	o.clear = function () {
        this.m.Slots = [];
        this.m.Slots.resize(10);
        this.m.OwnedFollowerIDs = [];
        this.m.Followers = [];
    }

	o.getNumberOfUnlockedSlots = function () {
		return 10;
	}

	o.getCurrentFollowersForUI = function () {
		local ret = [];
		ret.resize(this.m.Slots.len());

		foreach (i, p in this.m.Slots) {
			if (p != null) {
				ret[i] = {
					Image = p.getImage(),
					ID = p.getID(),
					Slot = i
				};
			} else {
				ret[i] = {
					Image = "ui/campfire/free_slot",
					ID = "locked",
					Slot = i
				};
			}
		}

		return ret;
	}

	o.getFollowersForUI = function () {
		local ret = [];

		foreach (p in this.m.Followers) {
			if (this.hasFollower(p.getID()) || !p.isVisible()) {
				continue;
			}

			p.evaluate();
			ret.push({
				ImagePath = p.getImage() + ".png",
				ID = p.getID(),
				Name = p.getName(),
				Description = p.getDescription(),
				IsUnlocked = p.isUnlocked(),
				Cost = p.getCost(),
				Effects = p.getEffects(),
				Requirements = p.getRequirementsForUI()
			});
		}

		ret.sort(this.onFollowerCompare);
		return ret;
	}

	o.setFollower = function (_slot, _follower) {
		local visibleFollowers = this.m.Followers.filter(@(_idx, _f) _f.isVisible());
        visibleFollowers.sort(@(_a, _b) _a.getID() <=> _b.getID());
		local fixedSlot = -1;
		foreach (i, f in visibleFollowers) {
            if (f.getID() == _follower.getID()) {
                fixedSlot = i;
                break;
            }
        }
		this.m.Slots[fixedSlot] = _follower;
		if (this.m.OwnedFollowerIDs.find(_follower.getID()) == null) {
			this.m.OwnedFollowerIDs.push(_follower.getID());
		}
		_follower.setOwned();
		this.update();

		if (this.getNumberOfCurrentFollowers() == this.m.Slots.len()) {
			this.updateAchievement("FullHouse", 1, 1);
		} else {
			this.updateAchievement("CampfireCompany", 1, 1);
		}
	}

	o.hasFollower = function (_id) {
		return this.m.Slots.filter(@(_,_f) (_f != null && _f.getID() == _id) && _f.isEnabled()).len() > 0;
	}

	o.hasFollowersToRemove <- function () {
		foreach (slot in this.m.Slots) {
			if (slot != null && !slot.isEnabled()) {
				return true;
			}
		}
		return false;
	}

	o.getFollowersToRemove <- function () {
		local ret = [];
		foreach (slot in this.m.Slots) {
			if (slot != null && !slot.isEnabled()) {
				ret.push(slot);
			}
		}
		return ret;
	}

	o.removeDisabledFollowers <- function () {
		foreach (idx, slot in this.m.Slots) {
			if (slot != null && !slot.isEnabled()) {
				slot.resetLinkedBro();
				this.m.Slots[idx] = null;
			}
		}
	}

	local upgradeInventory = o.upgradeInventory;
	o.upgradeInventory = function () {
		upgradeInventory();
		::Legends.Stash.upgradeCart();
		::Legends.Stash.resize();
	}

	o.onSerialize = function (_out) {
		_out.writeU8(this.m.Slots.len());

		foreach (p in this.m.Slots) {
			if (p == null) {
				_out.writeBool(false);
			} else {
				_out.writeBool(true);
				_out.writeString(p.getID());
				p.onSerialize(_out);
			}
		}

		foreach (id in this.m.OwnedFollowerIDs) {
			// this should fix the problem with crafting recipes being saved here for whatever dumb reason
			if (::Legends.Retinue.IDs.find(id) != null) {
				_out.writeBool(true);
				_out.writeString(id);
			}
		}
		_out.writeBool(false);

		_out.writeU8(this.m.InventoryUpgrades);
	}

	o.onDeserialize = function (_in) {
		this.clear();
		this.create();
		local numPerks = _in.readU8();

		for (local i = 0; i < numPerks; i = ++i) {
			local isFollower = _in.readBool();

			if (isFollower) {
				local p = this.getFollower(_in.readString());

				if (p != null) {
					p.onDeserialize(_in);
					this.m.Slots[i] = p;
				}
			}
		}

		while (_in.readBool()) {
			local id = _in.readString();
			if (::Legends.Retinue.IDs.find(id) != null) {
				this.m.OwnedFollowerIDs.push(id);
				this.getFollower(id).setOwned();
			}
		}

		this.m.InventoryUpgrades = _in.readU8();
		this.World.Assets.resetToDefaults();
	}
});
