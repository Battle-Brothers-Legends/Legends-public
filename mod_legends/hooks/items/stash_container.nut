::mods_hookNewObject("items/stash_container", function(o)
{
	o.getItemByInstanceID = function ( _instanceID )
	{
		for( local i = 0; i < this.m.Items.len(); i = ++i )
		{
			if (this.m.Items[i] != null && this.m.Items[i].getInstanceID() == _instanceID)
			{
				return {
					item = this.m.Items[i],
					index = i
				};
			}

			if (this.m.Items[i] != null && this.m.Items[i].getOldInstanceID() == _instanceID)
			{
				return {
					item = this.m.Items[i],
					index = i
				};
			}
		}

		return null;
	}
	o.getNumItemsMap <- function (_numUses = false)
	{
		local itemsMap = {};
		foreach(item in this.m.Items)
		{
			if (item == null) continue;

			if (!(item.getID() in itemsMap)) itemsMap[item.getID()] <- 0;

			itemsMap[item.getID()] = itemsMap[item.getID()] + (_numUses && "Uses" in item.m ? 8 : 1);
		}
		return itemsMap;
	}

	o.upgrade <- function ( _sourceIndex, _targetIndex )
	{
		if (this.isValidSlot(_sourceIndex) && this.isValidSlot(_targetIndex))
		{
			local sourceItem = this.m.Items[_sourceIndex];
			local targetItem = this.m.Items[_targetIndex];
			return sourceItem.onUse(null, targetItem)
		}
		return false;
	}

	o.hasItem <- function (_id)
	{
		foreach(item in this.m.Items)
		{
			if (item == null)
			{
				continue;
			}

			if (item.getID() == _id)
			{
				return true
			}
		}
		return false;
	}

	o.collectGarbage <- function ()
	{
		if (this.m.IsUpdating) return;

		this.m.IsUpdating = true;

		for(local i = 0; i < this.m.Items.len(); i = ++i)
		{
			if (this.m.Items[i] != null && this.m.Items[i].isGarbage())
			{
				this.removeByIndex(i);
			}
		}

		this.m.IsUpdating = false;
	}

	o.onSerialize = function ( _out )
	{
		_out.writeU16(this.m.Items.len());
		_out.writeU16(this.m.Capacity);

		for( local i = 0; i != this.m.Items.len(); i = ++i )
		{
			local item = this.m.Items[i];

			if (item == null)
			{
				_out.writeBool(false);
			}
			else
			{
				_out.writeBool(true);
				_out.writeI32(item.ClassNameHash);
				item.onSerialize(_out);
			}
		}
	}

	o.onDeserialize = function ( _in )
	{
		this.clear();
		local numItems = _in.readU16();
		this.m.Capacity = _in.readU16();

		if (this.m.Items.len() < numItems)
		{
			this.m.Items.resize(numItems);
		}

		for( local i = 0; i < numItems; i = ++i )
		{
			local hasItem = _in.readBool();

			if (hasItem)
			{
				local classname = this.IO.scriptFilenameByHash(_in.readI32());
				local item = this.new(classname);
				item.onDeserialize(_in);
				this.m.Items[i] = item;
			}
		}
	}
});
