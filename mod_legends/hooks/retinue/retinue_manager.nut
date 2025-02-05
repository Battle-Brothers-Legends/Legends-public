::mods_hookNewObject("retinue/retinue_manager", function(o) {
	o.m.OwnedFollowerIDs <- [];

	o.hasFollower <- function ( _id )
	{
		foreach( a in this.m.Slots )
		{
			if (a != null && a.getID() == _id && a.isEnabled())
			{
				return true;
			}
		}

		return false;
	}

	o.getFollowersForUI = function ()
	{
		local ret = [];

		foreach( p in this.m.Followers )
		{
			if (this.hasFollower(p.getID()) || !p.isVisible())
			{
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

	o.setFollower = function ( _slot, _follower )
	{
		this.m.Slots[_slot] = _follower;
		if (this.m.OwnedFollowerIDs.find(_follower.getID()) == null)
		{
			this.m.OwnedFollowerIDs.push(_follower.getID());
		}
		_follower.setOwned();
		this.update();

		if (this.getNumberOfCurrentFollowers() == this.m.Slots.len())
		{
			this.updateAchievement("FullHouse", 1, 1);
		}
		else
		{
			this.updateAchievement("CampfireCompany", 1, 1);
		}
	}

	o.upgradeInventory = function ()
	{
		++this.m.InventoryUpgrades;
		if (this.World.State.getPlayer() != null)
		{
			this.World.State.getPlayer().calculateModifiers();
		}
		//this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 27);
	}

	o.hasFollowersToRemove <- function ()
	{
		foreach (slot in this.m.Slots)
		{
			if (slot != null && !slot.isEnabled())
			{
				return true;
			}
		}
		return false;
	}

	o.getFollowersToRemove <- function ()
	{
		local ret = [];
		foreach (slot in this.m.Slots)
		{
			if (slot != null && !slot.isEnabled())
			{
				ret.push(slot)
			}
		}
		return ret;
	}

	o.removeDisabledFollowers <- function ()
	{
		foreach (idx, slot in this.m.Slots)
		{
			if (slot != null && !slot.isEnabled())
			{
				slot.resetLinkedBro();
				this.m.Slots[idx] = null;
			}
		}
	}

	o.clear = function ()
	{
		this.m.Slots = [];
		this.m.Slots.resize(5);
		this.m.OwnedFollowerIDs = [];
		this.m.Followers = [];
	}

	o.onSerialize = function ( _out )
	{
		_out.writeU8(this.m.Slots.len());

		foreach( p in this.m.Slots )
		{
			if (p == null)
			{
				_out.writeBool(false);
			}
			else
			{
				_out.writeBool(true);
				_out.writeString(p.getID());
				p.onSerialize(_out);
			}
		}


		foreach (id in this.m.OwnedFollowerIDs)
		{
			// this should fix the problem with crafting recipes being saved here for whatever dumb reason
			if (::Legends.Retinue.IDs.find(id) != null) {
				_out.writeBool(true);
				_out.writeString(id);
			}
		}
		_out.writeBool(false);

		_out.writeU8(this.m.InventoryUpgrades);
	}

	o.onDeserialize = function ( _in )
	{
		this.clear();
		this.create();
		local numPerks = _in.readU8();

		for( local i = 0; i < numPerks; i = ++i )
		{
			local isFollower = _in.readBool();

			if (isFollower)
			{
				local p = this.getFollower(_in.readString());

				if (p != null)
				{
					p.onDeserialize(_in);
					this.m.Slots[i] = p;
				}
			}
		}
		if (::Legends.Mod.Serialization.isSavedVersionAtLeast("19.0.13", _in.getMetaData())) {
			while(_in.readBool()) {
				local id = _in.readString();
				if (::Legends.Retinue.IDs.find(id) != null) {
					this.m.OwnedFollowerIDs.push(id);
					this.getFollower(id).setOwned();
				}
			}
		} else {
			local ownedFollowerCount = _in.readU8();
			for (local i = 0; i < ownedFollowerCount; ++i)
			{
				local id = _in.readString();
				this.m.OwnedFollowerIDs.push(id);
				this.getFollower(id).setOwned();
			}
		}


		this.m.InventoryUpgrades = _in.readU8();
		this.World.Assets.resetToDefaults();
	}
});
