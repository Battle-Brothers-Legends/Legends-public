this.workshop_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		ToolsCreated = 0,
		PointsNeeded = 0,
		PointsSalvaged = 0,
		ItemsDestroyed = 0,
		Stash = null,
		Salvage = null,
		Capacity = 0,
		NumBros = 0
	},
	function create()
	{
		this.camp_building.create();
		this.m.BaseCraft = 10;
		this.m.Conversion = 30.0;
		this.m.ModName = "Salvage";
		this.m.ID = ::Const.World.CampBuildings.Workshop;
		this.m.Slot = "scrap";
		this.m.Name = "Salvage Tent";
		this.m.Description = "Turn scrap into useable parts";
		this.m.BannerImage = "ui/buttons/banner_scrap.png";
		local sounds = getCampSounds(6, "scrap");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getDescription() {	//desc = desc + "The salvage tent can be upgraded by purchasing a salvage cart from a settlement merchant. An upgraded tent has a 15% increase in salvage speed and every 10 durability equals a tool.";
		return "Break down equipment into tools in selected order. Once an item reaches zero durability, it will be destroyed.";
	}

	function getModifierTooltip() {
		this.init();
		local nonNullEntries = 0;
		foreach (_, value in this.m.Salvage) {
		    if (value != null) {
        		nonNullEntries++;
			}
		}
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=%positive%]" + nonNullEntries + "[/color] items in the salvage queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=%positive%]" + this.getRequiredTime() + "[/color] hours to salvage all items in the queue."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/asset_supplies.png",
				text = "Total salvage modifier is [color=%positive%]" + mod.Craft + "[/color] units per hour."
			}
		];
		local id = 6;

		foreach( bro in mod.Modifiers )
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			id = ++id;
			id = id;
		}

		return ret;
	}

	function isHidden()	{
		return ::Legends.Settings.skipCamp() ? false : !::World.Flags.get(::Legends.Camp.Flag.Scrap);
	}

	function getUpgraded() {
		return ::Stash.hasItem(::Legends.Camp.Tent.Scrap);
	}

	function getLevel()	{
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function init()	{
		this.onInit();
		this.m.ToolsCreated = 0;
		this.m.PointsSalvaged = 0;
		this.m.ItemsDestroyed = 0;
		this.m.NumBros = this.getModifiers().Assigned;
		this.m.PointsNeeded = 0;
		foreach (item in this.m.Salvage.filter(@(_, _item) (_item != null))) {
			this.m.PointsNeeded += item.Item.getRepair();
		}
	}

	function onInit()
	{
		local items = this.getListOfEquipment();
		this.m.Stash = items.Stash;
		this.m.Salvage = items.Items;
		local capacity = this.m.Salvage.len() + this.m.Stash.len();
		this.m.Capacity = capacity;

		while (this.m.Stash.len() < capacity) {
			this.m.Stash.push(null);
		}

		while (this.m.Salvage.len() < capacity)	{
			this.m.Salvage.push(null);
		}
	}

	function getConversionRate() {
		return this.m.Conversion;
	}

	function getStash()	{
		return this.m.Stash;
	}

	function getRepairs() {
		return this.m.Salvage;
	}

	function getCapacity() {
		return this.m.Capacity;
	}

	function getResults() {
		if (this.m.ToolsCreated == 0) {
			return [];
		}

		return [
			{
				id = 11,
				icon = "ui/icons/asset_supplies.png",
				text = "You created [color=%positive%]" + ::Math.floor(this.m.ToolsCreated) + "[/color] units of tools and salvaged [color=%negative%]" + this.m.ItemsDestroyed + "[/color] pieces of equipment."
			}
		];
	}

	function getModifiers()	{
		local ret = this.camp_building.getModifiers();

		if (this.getUpgraded())	{
			ret.Consumption = 1.0 / 10.0;
		}

		return ret;
	}

	function getSalvagePoints(){
		local points = 0;
		local salvage = this.m.Salvage.filter(@(_, _item) (_item != null));
		foreach (_item in salvage) {
			points += _item.Item.getRepair();
		}
		return points;
	}

	function getRequiredSupplies() {
		return ::Math.ceil(this.getSalvagePoints() * this.getModifiers().Consumption);
	}

	function getRequiredTime() {
		this.init();
		if (this.m.Salvage == null)	{
			return 0;
		}

		return this.getModifiers().Craft > 0 ? ::Math.ceil(this.getSalvagePoints() / this.getModifiers().Craft) : 0;
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}

	function getResourceImage()	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()	{
		return this.getRequiredTime();
	}

	function getUpdateText() {
		if (this.m.PointsNeeded == 0)
			return "No salvage queued";

		if (this.getRequiredSupplies() == 0)
			return "Salvaged ... 100%";

		return "Salvaged ... " + (::Math.floor((this.m.PointsSalvaged / this.m.PointsNeeded) * 10000) / 100.0) + "%" + (::World.Assets.getArmorPartsF() == ::World.Assets.getMaxArmorParts() ? "(At max tools!)" : "");
	}

	function update() {
		if (this.m.Salvage == null || this.m.Salvage.len() == 0 || ::World.Assets.getArmorPartsF() >= ::World.Assets.getMaxArmorParts()) {
			return this.getUpdateText();
		}

		local modifiers = this.getModifiers();

		foreach(i, r in this.m.Salvage)	{
			if (r == null) {
				continue;
			}

			if (modifiers.Craft <= 0 || ::World.Assets.getArmorPartsF() >= ::World.Assets.getMaxArmorParts()) {
				break;
			}

			local consumed = r.Item.getRepair();

			if (modifiers.Craft < consumed)	{
				consumed = modifiers.Craft;
			}

			r.Item.onRepair(r.Item.getRepair() - consumed);
			modifiers.Craft -= consumed;
			this.m.PointsSalvaged += consumed;
			local created = consumed * modifiers.Consumption;
			this.m.ToolsCreated += created;
			::World.Assets.addArmorPartsF(created);

			if (r.Item.getRepair() <= 0) {
				this.m.ItemsDestroyed += 1;
				local myItem = ::World.Assets.getStash().getItemByInstanceID(r.Item.getInstanceID());
				if (myItem == null)
					continue;
				myItem = myItem.item;
				if (myItem.getRuneVariant() > 0) {
					local def = ::Legends.Runes.get(myItem.getRuneVariant());
					local rune = ::new(def.Script);
					rune.setRuneVariant(myItem.getRuneVariant());
					rune.setRuneBonus1(myItem.getRuneBonus1());
					rune.setRuneBonus2(myItem.getRuneBonus2());
					rune.updateRuneSigilToken();
					this.World.Assets.getStash().add(rune);
				}

				::World.Assets.getStash().remove(r.Item);
				this.m.Salvage[i] = null;
			}
		}

		return this.getUpdateText();
	}

	function getListOfEquipment()
	{
		local items = [];
		local stash = [];
		local stashItemsToBeSalvaged = ::Stash.getItems().filter(@(_,_item) (_item != null && !_item.isIndestructible() && _item.getCondition() > 0 && !_item.isToBeRepaired() && _item.canBeSalvaged()));
		foreach(item in stashItemsToBeSalvaged)	{
			local target = item.isToBeSalvaged() ? items : stash;
			target.push({
				Bro = null,
				Item = item
			});
		}

		items.sort(@(_a, _b) _a.Item.isToBeSalvagedQ() - _b.Item.isToBeSalvagedQ());
		return {
			Items = items,
			Stash = stash
		};
	}

	function assignAll( _filter = 0 ) {
		if (_filter == 0) {
			_filter = ::Const.Items.ItemFilter.All;
		}

		local index = 0;
		foreach (i, s in this.m.Stash) {
			if (s == null) {
				continue;
			}

			if (_filter == 99 && s.Bro != null)	{
				continue;
			} else if ((s.Item.getItemType() & _filter) == 0) {
				continue;
			}

			while (index < this.m.Salvage.len()) {
				if (this.m.Salvage[index] == null) {
					break;
				}
				index++;
			}

			s.Item.setToBeSalvaged(true, index);
			s.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
			if (index >= this.m.Salvage.len()) {
				this.m.Salvage.push(s);
			} else {
				this.m.Salvage[index] = s;
			}
			
			this.m.Stash[i] = null;
			index++;
		}
	}

	function removeAll() {
		local index = 0;

		foreach(i, s in this.m.Salvage)	{
			if (s == null) {
				continue;
			}

			while (index < this.m.Stash.len()) {
				if (this.m.Stash[index] == null) {
					break;
				}
				index++;
			}

			s.Item.setToBeSalvaged(false, 0);
			s.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
			if (index >= this.m.Stash.len()) {
				this.m.Stash.push(s);
			} else {
				this.m.Stash[index] = s;
			}

			this.m.Salvage[i] = null;
			index++;
		}
	}

	function swapItems( sourceItemOwner, sourceItemIdx, targetItemOwner, targetItemIdx )
	{
		if (targetItemOwner == null) {
			this.logError("onSwapItem #1");
			return false;
		}

		if (sourceItemOwner == targetItemOwner && sourceItemIdx == targetItemIdx) {
			return false;
		}

		local sourceList;
		local targetList;
		local isRepair = false;

		switch(sourceItemOwner)	{
		case "camp-screen-workshop-dialog-module.stash":
			sourceList = this.m.Stash;

			if (sourceItemOwner == targetItemOwner)	{
				targetList = this.m.Stash;
			} else {
				targetList = this.m.Salvage;
				isRepair = true;
			}

			break;

		case "camp-screen-workshop-dialog-module.shop":
			sourceList = this.m.Salvage;

			if (sourceItemOwner == targetItemOwner)	{
				targetList = this.m.Salvage;
				isRepair = true;
			} else {
				targetList = this.m.Stash;
			}

			break;
		}

		local sourceItem = sourceList[sourceItemIdx];

		if (sourceItem == null) {
			this.logError("onSwapItem(stash) #2");
			return false;
		}

		if (targetItemIdx != null) {
			while (targetItemIdx > targetList.len() - 1) {
				targetList.push(null);
			}

			sourceList[sourceItemIdx] = targetList[targetItemIdx];
			targetList[targetItemIdx] = sourceItem;
			sourceItem.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
			sourceItem.Item.setToBeSalvaged(isRepair, isRepair ? targetItemIdx : 0);
			return true;
		}

		foreach( i, r in targetList ) {
			if (r != null) {
				continue;
			}

			targetList[i] = sourceItem;
			sourceList[sourceItemIdx] = null;
			sourceItem.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
			sourceItem.Item.setToBeSalvaged(isRepair, isRepair ? i : 0);
			return true;
		}

		targetList.push(sourceItem);
		sourceList[sourceItemIdx] = null;
		sourceItem.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
		sourceItem.Item.setToBeSalvaged(isRepair, isRepair ? targetList.len() - 1 : 0);
		return true;
	}
});

