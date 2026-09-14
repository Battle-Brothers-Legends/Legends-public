this.legend_smuggle_box_item <- ::inherit("scripts/items/item", {
	m = {},
	function create() {
		this.item.create();
		this.m.ID = "misc.legend_smuggle_box";
		this.m.Name = "Smuggled items";
		this.m.Description = "This chest contains smuggled items. You can open it, but your employer might be not pleased about it.";
		this.m.Icon = "misc/quest_loot_box.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc;
		this.m.IsDroppedAsLoot = false;
		this.m.IsPrecious = true;
		this.m.IsSellable = false;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 0;
	}

	function onUse( _actor, _item = null ) {
		local contract = ::World.Contracts.getActiveContract();
		if (contract == null)
			return true; // if there's no contract, do nothing but consume item, pretty much item spawner protection
		if (contract.getType() != "contract.legend_camp_smuggle_contract")
			return true; // same as above

		contract.m.Flags.set("BoxOpened", true);

		local itemTypeSeed = contract.m.Flags.getAsInt("ItemTypeSeed");
		local itemSeed = contract.m.Flags.getAsInt("ItemSeed");

		local item = null;
		local idx = itemTypeSeed % 3;
		if (idx == 0) {
			local items = clone ::Const.Items.NamedWeapons;
			item = ::new("scripts/items/" + items[itemSeed % items.len()]);
		} else if (idx == 1) {
			local helmets = ::Const.World.Common.convNameToList(::Const.Items.NamedHelmets);
			item = ::Const.World.Common.pickHelmet([helmets[itemSeed % helmets.len()]]);
		} else if (idx == 2) {
			local armors = ::Const.World.Common.convNameToList(::Const.Items.NamedArmors);
			item = ::Const.World.Common.pickArmor([armors[itemSeed % armors.len()]]);
		}
		::World.Assets.getStash().makeEmptySlots(1);
		::World.Assets.getStash().add(item);

		return true;
	}
});
