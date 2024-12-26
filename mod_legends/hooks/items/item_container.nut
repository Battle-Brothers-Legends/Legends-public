::mods_hookNewObject("items/item_container", function(o)
{
	o.m.Appearance.ArmorLayerChain <- "";
	o.m.Appearance.ArmorLayerPlate<- "";
	o.m.Appearance.ArmorLayerTabbard<- "";
	o.m.Appearance.ArmorLayerCloakFront <- "";
	o.m.Appearance.ArmorLayerCloakBack <- "";
	o.m.Appearance.CorpseArmorLayerChain <- "";
	o.m.Appearance.CorpseArmorLayerPlate<- "";
	o.m.Appearance.CorpseArmorLayerTabbard<- "";
	o.m.Appearance.CorpseArmorLayerCloakFront <- "";
	o.m.Appearance.CorpseArmorLayerCloakBack <- "";
	o.m.Appearance.HelmetLayerVanityLower <- "";
	o.m.Appearance.HelmetLayerVanity2Lower <- "";
	o.m.Appearance.Helmet <- "";
	o.m.Appearance.HelmetLayerHelm <- "";
	o.m.Appearance.HelmetLayerTop <- "";
	o.m.Appearance.HelmetLayerVanity <- "";
	o.m.Appearance.HelmetLayerVanity2 <- "";
	o.m.Appearance.HelmetLayerVanityLowerCorpse <- "";
	o.m.Appearance.HelmetLayerVanity2LowerCorpse <- "";
	o.m.Appearance.HelmetLayerHelmCorpse <- "";
	o.m.Appearance.HelmetLayerTopCorpse <- "";
	o.m.Appearance.HelmetLayerVanityCorpse <- "";
	o.m.Appearance.HelmetLayerVanity2Corpse <- "";

	local addToBag = o.addToBag;
	o.addToBag = function ( _item, _slot = -1 )
	{
		if (_item == null) return false;

		_item.m.AddToBagActor = getActor();
		local result = addToBag(_item, _slot);
		_item.m.AddToBagActor = null;
		return result;
	}

	o.drop <- function( item )
	{
		if (!this.m.Actor.isPlacedOnMap())
		{
			return;
		}

		local _tile = this.m.Actor.getTile();
		item.m.IsDroppedAsLoot = true;
		item.drop(_tile);
		_tile.IsContainingItemsFlipped = true;
	}

	o.dropAll = function ( _tile, _killer, _flip = false )
	{
		local IsDroppingLoot = true;
		local isPlayer = this.m.Actor.getFaction() == this.Const.Faction.Player || this.isKindOf(this.m.Actor.get(), "player");
		local emergency = false;

		if (_killer != null && !_killer.isPlayerControlled() && !this.m.Actor.isPlayerControlled() && _killer.getID() != this.m.Actor.getID() && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			IsDroppingLoot = false;
		}

		if (!this.m.Actor.isPlayerControlled() && this.m.Actor.isAlliedWithPlayer())
		{
			IsDroppingLoot = false;
		}

		if (_killer != null && _killer.isPlayerControlled() && !isPlayer && _killer.isAlliedWith(this.m.Actor))
		{
			IsDroppingLoot = false;
		}

		if (_tile == null)
		{
			if (this.m.Actor.isPlacedOnMap())
			{
				_tile = this.m.Actor.getTile();
				emergency = true;
			}
			else
			{
				return;
			}
		}

		for( local i = 0; i < this.Const.ItemSlot.COUNT; i = ++i )
		{
			for( local j = 0; j < this.m.Items[i].len(); j = ++j )
			{
				if (this.m.Items[i][j] == null || this.m.Items[i][j] == -1)
				{
				}
				else if (this.m.Items[i][j].isChangeableInBattle(null) || emergency)
				{
					if (IsDroppingLoot || this.m.Items[i][j].isItemType(this.Const.Items.ItemType.Legendary))
					{
						this.m.Items[i][j].drop(_tile);
					}
					else
					{
						this.m.Items[i][j].m.IsDroppedAsLoot = false;
					}
				}
				else if (!IsDroppingLoot && !this.m.Items[i][j].isItemType(this.Const.Items.ItemType.Legendary))
				{
					this.m.Items[i][j].m.IsDroppedAsLoot = false;
				}
			}
		}

		_tile.IsContainingItemsFlipped = _flip;
	}

	local equip = o.equip;
	o.equip = function (_item)
	{
		return _item == null ? false : equip(_item);
	}

	o.unequipNoUpdate <- function (_item)
	{
		if (_item == null || _item == -1)
		{
			return;
		}

		if (_item.getCurrentSlotType() == this.Const.ItemSlot.None || _item.getCurrentSlotType() == this.Const.ItemSlot.Bag)
		{
			this.logWarning("Attempted to unequip item " + _item.getName() + ", but is not equipped");
			return false;
		}

		for( local i = 0; i < this.m.Items[_item.getSlotType()].len(); i = ++i )
		{
			if (this.m.Items[_item.getSlotType()][i] == _item)
			{
				// _item.onUnequip();
				// _item.setContainer(null);
				// _item.setCurrentSlotType(this.Const.ItemSlot.None);
				this.m.Items[_item.getSlotType()][i] = null;

				if (_item.getBlockedSlotType() != null)
				{
					for( local i = 0; i < this.m.Items[_item.getBlockedSlotType()].len(); i = ++i )
					{
						if (this.m.Items[_item.getBlockedSlotType()][i] == -1)
						{
							this.m.Items[_item.getBlockedSlotType()][i] = null;
							break;
						}
					}
				}
				return true;
			}
		}

		return false;
	}

	o.transferToList <- function( _stash )
	{
		for( local i = 0; i < this.Const.ItemSlot.COUNT; i = ++i )
		{
			for( local j = 0; j < this.m.Items[i].len(); j = ++j )
			{
				if (this.m.Items[i][j] == null || this.m.Items[i][j] == -1)
				{
					continue
				}

				local item = this.m.Items[i][j];
				if (item.isEquipped())
				{
					this.unequip(item);
				}
				else
				{
					this.removeFromBag(item);
				}
				_stash.push(item);
				// this.logInfo("Transferred " + item.m.Name + " : " + item.getInstanceID())
				// local res = this.Stash.getItemByInstanceID(item.getInstanceID());
				// if (res == null) {
				//	 this.logInfo("saveFormation::could not find item for " + item.getInstanceID());
				//	 continue
				// }
				//toTransfer.push(item);
			}
		}

		// this.logInfo("TRANSFERED TO STASH COMPLETE. STASH SIZe = " + _stash.m.Items.len())

		// foreach( item in toTransfer )
		// {
		// 	if (_stash.add(item) == null)
		// 	{
		//		 this.logInfo("STASH ADD ITEM IS NULL")
		// 		break;
		// 	}


		// }
	}

	o.doOnFunction <- function (_function, _argsArray = null, _slotType = null)
	{
		this.m.IsUpdating = true;

		if (_argsArray == null) _argsArray = [];
		_argsArray.insert(0, null);

		if (_slotType != null)
		{
			this.doOnFunctionSlot(_function, _argsArray, this.m.Items[_slotType])
		}
		else
		{
			foreach (slot in this.m.Items)
			{
				this.doOnFunctionSlot(_function, _argsArray, slot);
			}
		}

		this.m.IsUpdating = false;
	}

	o.doOnFunctionSlot <- function (_function, _argsArray, _slot)
	{
		foreach (item in _slot)
		{
			if (item != null && item != -1)
			{
				_argsArray[0] = item;
				item[_function].acall(_argsArray);
			}
		}
	}

	o.collectGarbage = function ( _slotType = null )
	{
		if (this.m.IsUpdating)
		{
			return;
		}

		this.m.IsUpdating = true;

		if (_slotType != null)
		{
			this.collectGarbageSlot(this.m.Items[_slotType]);
		}
		else
		{
			foreach( slot in this.m.Items )
			{
				this.collectGarbageSlot(slot);
			}
		}

		this.m.IsUpdating = false;
	}

	o.collectGarbageSlot <- function ( _slot )
	{
		foreach( item in _slot )
		{
			if (item != null && item != -1 && item.isGarbage())
			{
				if (item.isEquipped())
				{
					this.unequip(item);
				}
				else
				{
					this.removeFromBag(item);
				}
			}
		}
	}

	o.onBeforeDamageReceived = function (_attacker, _skill, _hitInfo, _properties)
	{
		this.doOnFunction("onBeforeDamageReceived", [_attacker, _skill, _hitInfo, _properties]);
		this.collectGarbage();
	}

	o.onDamageReceived = function (_damage, _fatalityType, _slotType, _attacker)
	{
		this.doOnFunction("onDamageReceived", [_damage, _fatalityType, _attacker], _slotType);
		this.collectGarbage(_slotType);
	}

	o.onDamageDealt = function (_target, _skill, _hitInfo)
	{
		this.doOnFunction("onDamageDealt", [_target, _skill, _hitInfo], this.Const.ItemSlot.Mainhand);
		this.collectGarbage(this.Const.ItemSlot.Mainhand);
	}

	o.onShieldHit = function (_attacker, _skill)
	{
		this.doOnFunction("onShieldHit", [_attacker, _skill], this.Const.ItemSlot.Offhand);
		this.collectGarbage(this.Const.ItemSlot.Offhand);
	}
});
