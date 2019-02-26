this.item <- {
	m = {
		ID = "",
		Name = "",
		Icon = "",
		IconLarge = "",
		Description = "",
		Categories = "",
		Variant = 0,
		Condition = 1.0,
		ConditionMax = 1.0,
		SlotType = this.Const.ItemSlot.Bag,
		CurrentSlotType = this.Const.ItemSlot.None,
		BlockedSlotType = null,
		ItemType = this.Const.Items.ItemType.None,
		ItemProperty = this.Const.Items.Property.None,
		Container = null,
		SkillPtrs = [],
		Tile = null,
		Value = 0,
		PriceMult = 1.0,
		LastEquippedByFaction = 0,
		IsGarbage = false,
		IsDroppedAsLoot = false,
		IsDroppedWhenDamaged = true,
		IsChangeableInBattle = true,
		IsIndestructible = false,
		IsToBeRepaired = false,
		IsConsumed = false,
		IsAllowedInBag = true,
		IsUsable = false,
		IsSold = false,
		IsBought = false,
		RuneVariant = 0
	},
	function setContainer( _c )
	{
		if (_c != null)
		{
			this.m.Container = this.WeakTableRef(_c);
		}
		else
		{
			this.m.Container = null;
		}
	}

	function getContainer()
	{
		return this.m.Container;
	}

	function getName()
	{
		return this.m.Name;
	}

	function getID()
	{
		return this.m.ID;
	}

	function getInstanceID()
	{
		return this.toHash(this).tostring();
	}

	function getIcon()
	{
		return this.m.Icon;
	}

	function getIconLarge()
	{
		return this.m.IconLarge != "" ? this.m.IconLarge : null;
	}

	function getIconOverlay()
	{
		return "";
	}

	function getIconLargeOverlay()
	{
		return "";
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getSlotType()
	{
		return this.m.SlotType;
	}

	function getCurrentSlotType()
	{
		return this.m.CurrentSlotType;
	}

	function getBlockedSlotType()
	{
		return this.m.BlockedSlotType;
	}

	function setCurrentSlotType( _t )
	{
		this.m.CurrentSlotType = _t;
	}

	function isItemType( _t )
	{
		return (this.m.ItemType & _t) != 0;
	}

	function getItemType()
	{
		return this.m.ItemType;
	}

	function hasProperty( _t )
	{
		return (this.m.ItemProperty & _t) != 0;
	}

	function isInBag()
	{
		return this.m.CurrentSlotType == this.Const.ItemSlot.Bag;
	}

	function isEquipped()
	{
		return this.m.CurrentSlotType != this.Const.ItemSlot.Bag && this.m.CurrentSlotType != this.Const.ItemSlot.None;
	}

	function isGarbage()
	{
		return this.m.IsGarbage;
	}

	function isChangeableInBattle()
	{
		return this.m.SlotType >= 0 ? this.m.IsChangeableInBattle && this.Const.ItemSlotChangeableInBattle[this.m.SlotType] : false;
	}

	function isDroppedAsLoot()
	{
		return this.m.IsDroppedAsLoot && (this.m.LastEquippedByFaction == 0 || this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player") || ("State" in this.World) && this.World.State != null && !this.World.FactionManager.isAlliedWithPlayer(this.m.LastEquippedByFaction));
	}

	function isDroppedWhenDamaged()
	{
		return this.m.IsDroppedWhenDamaged;
	}

	function isSold()
	{
		return this.m.IsSold;
	}

	function isBought()
	{
		return this.m.IsBought;
	}

	function isToBeRepaired()
	{
		return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	function isConsumed()
	{
		return this.m.IsConsumed;
	}

	function isIndestructible()
	{
		return this.m.IsIndestructible;
	}

	function isUsable()
	{
		return this.m.IsUsable;
	}

	function setToBeRepaired( _r )
	{
		if (_r && this.getCondition() == this.getConditionMax())
		{
			return false;
		}

		this.m.IsToBeRepaired = _r;
		return true;
	}

	function getVariant()
	{
		return this.m.Variant;
	}

	function getArmor()
	{
		return 0;
	}

	function getArmorMax()
	{
		return 0;
	}

	function getCondition()
	{
		return this.Math.floor(this.m.Condition);
	}

	function getConditionMax()
	{
		return this.Math.floor(this.m.ConditionMax);
	}

	function getValue()
	{
		return this.m.Value;
	}

	function getPriceMult()
	{
		return this.m.PriceMult;
	}

	function setValue( _v )
	{
		this.m.Value = _v;
	}

	function setPriceMult( _m )
	{
		this.m.PriceMult = _m;
	}

	function setSold( _f )
	{
	}

	function setBought( _f )
	{
	}

	function setCondition( _a )
	{
		this.m.Condition = _a;
		this.updateAppearance();
	}

	function isAmountShown()
	{
	}

	function getAmount()
	{
		return 0;
	}

	function getAmountMax()
	{
		return 0;
	}

	function getAmountColor()
	{
		return "#ffffff";
	}

	function getAmountString()
	{
		return "";
	}

	function getStaminaModifier()
	{
		return 0;
	}

	function isAllowedInBag()
	{
		if (!this.m.IsAllowedInBag || this.m.SlotType == this.Const.ItemSlot.Body || this.m.SlotType == this.Const.ItemSlot.Head || this.m.SlotType == this.Const.ItemSlot.None)
		{
			return false;
		}

		return true;
	}

	function getValueString()
	{
		if (this.getValue() != 0)
		{
			return "Worth [img]gfx/ui/tooltips/money.png[/img][b]" + this.getValue() + "[/b]";
		}
		else
		{
			return "Worth nothing.";
		}
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()]));
		}
		else
		{
			return this.Math.ceil(this.getValue() * this.getPriceMult());
		}
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
		}
	}

	function getTooltip()
	{
		local result = [
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

		if (this.m.Categories.len() != 0)
		{
			result.push({
				id = 65,
				type = "text",
				text = this.m.Categories
			});
		}

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		return result;
	}

	function removeSelf()
	{
		this.m.IsGarbage = true;
		this.m.Container.collectGarbage();
	}

	function addSkill( _skill )
	{
		_skill.setItem(this);
		this.m.SkillPtrs.push(_skill);
		this.getContainer().getActor().getSkills().add(_skill, this.m.SkillPtrs.len());
	}

	function addGenericItemSkill()
	{
		local skill = this.new("scripts/skills/items/generic_item");
		skill.setItem(this);
		this.addSkill(skill);
	}

	function removeSkill( _skill )
	{
		local idx = this.m.SkillPtrs.find(_skill);

		if (idx != null)
		{
			this.m.SkillPtrs.remove(idx);
		}

		_skill.setItem(null);
		this.getContainer().getActor().getSkills().remove(_skill);
	}

	function clearSkills()
	{
		if (this.getContainer() == null || this.getContainer().getActor() == null || this.getContainer().getActor().isNull())
		{
			return;
		}

		foreach( i, skill in this.m.SkillPtrs )
		{
			this.getContainer().getActor().getSkills().remove(skill);
		}

		this.m.SkillPtrs = [];
	}

	function removeFromContainer()
	{
		this.m.Container = null;
		this.m.CurrentSlotType = this.Const.ItemSlot.None;
	}

	function drop( _tile = null )
	{
		local isDropped = this.isDroppedAsLoot();

		if (this.m.Container != null)
		{
			if (_tile == null && this.m.Container.getActor() != null && this.m.Container.getActor().isPlacedOnMap())
			{
				_tile = this.m.Container.getActor().getTile();
			}

			if (this.m.CurrentSlotType != this.Const.ItemSlot.Bag)
			{
				this.m.Container.unequip(this);
			}
			else
			{
				this.m.Container.removeFromBag(this);
			}
		}

		if (_tile == null)
		{
			this.logWarning("Attempted to drop item, but no tile specified!");
			return;
		}

		if (isDropped)
		{
			_tile.Items.push(this);
			_tile.IsContainingItems = true;
			this.m.Tile = _tile;
			this.onDrop(_tile);
		}
	}

	function removeFromTile()
	{
		if (this.m.Tile == null)
		{
			return;
		}

		local n = this.m.Tile.Items.find(this);
		this.m.Tile.Items.remove(n);
		this.m.Tile.IsContainingItems = this.m.Tile.Items.len() != 0;
		this.m.Tile = null;
	}

	function pickup()
	{
		this.removeFromTile();
	}

	function setVariant( _v )
	{
		this.m.Variant = _v;
		this.updateVariant();
	}

	function updateVariant()
	{
	}

	function updateAppearance()
	{
	}

	function playInventorySound( _eventType )
	{
	}

	function onFactionChanged( _faction )
	{
		this.m.LastEquippedByFaction = _faction;
	}

	function onPutIntoBag()
	{
	}

	function onRemovedFromBag()
	{
		this.clearSkills();
	}

	function onPickedUp()
	{
	}

	function onDrop( _tile )
	{
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
	}

	function onUpdateProperties( _properties )
	{
	}

	function onTurnStart()
	{
	}

	function onUse( _skill )
	{
	}

	function onTotalArmorChanged()
	{
	}

	function onMovementFinished()
	{
	}

	function onCombatFinished()
	{
	}

	function onActorDied( _onTile )
	{
	}

	function onAddedToStash( _stashID )
	{
	}

	function onRemovedFromStash( _stashID )
	{
	}

	function onUse( _actor, _item = null )
	{
	}

	function onUnequip()
	{
		this.clearSkills();
	}

	function onEquip()
	{
		if (this.m.Container != null && this.m.Container.getActor() != null)
		{
			this.m.LastEquippedByFaction = this.m.Container.getActor().getFaction();
		}

		if (this.isRuned())
		{
			this.onEquipRuneSigil();
		}
	}

	function onEquipRuneSigil()
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSW_power"));
				break;

			case 2:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSW_aiming"));
				break;

			case 3:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSW_feeding"));
				break;

			case 11:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSH_clarity"));
				break;

			case 12:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSH_bravery"));
				break;

			case 13:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSH_luck"));
				break;

			case 21:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSA_endurance"));
				break;

			case 22:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSA_safety"));
				break;

			case 23:
				this.addSkill(this.new("scripts/skills/rune_sigils/vazl_RSA_resilience"));
				break;

			default:
				break;
		}
	}

	function getRuneSigilTooltip(_rune)
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				return "This item is inscribed with the rune sigil of Power:\n[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Damage inflicted"
				break;

			case 2:
				return "This item is inscribed with the rune sigil of Aiming:\n[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Melee and Ranged skills"
				break;

			case 3:
				return "This item is inscribed with the rune sigil of Feeding:\n[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of inflicted health damage recovers fatigue"
				break;

			case 11:
				return "This item is inscribed with the rune sigil of Clarity:\n[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Vision, [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Experience gain"
				break;

			case 12:
				return "This item is inscribed with the rune sigil of Bravery:\n[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Resolve, [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Resolve at all morale checks"
				break;

			case 13:
				return "This item is inscribed with the rune sigil of Luck:\n[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] chance to have any attacker require two successful attack rolls in order to hit"
				break;

			case 21:
				return "This item is inscribed with the rune sigil of Endurance:\n[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Fatigue recovery per turn, [color=" + this.Const.UI.Color.PositiveValue + "]-10%[/color] Fatigue cost and effects multiplier"
				break;

			case 22:
				return "This item is inscribed with the rune sigil of Safety:\n[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Hitpoints, [color=" + this.Const.UI.Color.PositiveValue + "]-5%[/color] Damage received"
				break;

			case 23:
				return "This item is inscribed with the rune sigil of Resilience:\n[color=" + this.Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs"
				break;

			default:
				return "This item is inscribed with a rune sigil, even though it shouldn't have been: please report this bug."
				break;
		}
	}

	function setRuneVariant(_rune)
	{
		this.m.RuneVariant = _rune;
	}

	function getRuneVariant()
	{
		return this.m.RuneVariant;
	}

	function isRuned()
	{
		if (this.m.RuneVariant > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	function updateRuneSigil()
	{
		if (this.m.Name.find("(Runed)") == null)
		{
			this.m.Name =  this.m.Name + "[color=" + this.Const.UI.Color.RuneColor + "] (Runed)[/color]";
		}
	}

	function updateRuneSigilAppearance()
	{
		local iconLargeParts = split(this.m.IconLarge, "/");
		local iconParts = split(this.m.Icon, "/");
		local text = ""
		for (local i = 0; i < iconLargeParts.len(); i = ++i)
		{
			this.logInfo(iconLargeParts[i]);
			if (i == iconLargeParts.len() - 1)
			{
				text = text + "runed_" + iconLargeParts[i]
			} else {
				text = text + iconLargeParts[i] + "/";
			}
		}
		this.m.IconLarge = text;

		text = ""
		for (local i = 0; i < iconParts.len(); i = ++i)
		{
			if (i == iconParts.len() - 1)
			{
				text = text + "runed_" + iconParts[i]
			} else {
				text = text + iconParts[i] + "/";
			}
		}
		this.m.Icon = text;
		this.m.ArmamentIcon = "runed_" + this.m.ArmamentIcon;
	}

	function onSerialize( _out )
	{
		_out.writeBool(this.m.IsToBeRepaired);
		_out.writeU16(this.m.Variant);
		_out.writeF32(this.m.Condition);
		_out.writeF32(this.m.PriceMult);
		_out.writeU8(this.m.RuneVariant);
	}

	function onDeserialize( _in )
	{
		this.m.IsToBeRepaired = _in.readBool();

		if (_in.getMetaData().getVersion() >= 28)
		{
			this.m.Variant = _in.readU16();
		}
		else
		{
			this.m.Variant = _in.readU8();
		}

		this.m.Condition = _in.readF32();
		this.m.PriceMult = _in.readF32();

		if (_in.getMetaData().getVersion() >= 48)
		{
			this.m.RuneVariant = _in.readU8();
		}		
	
		this.updateVariant();
	}

};
