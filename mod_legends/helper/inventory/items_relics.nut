if (!("Items" in ::Legends)) {
	::Legends.Items <- {};
}

::Legends.Items.Relics <- {};

//Used to change the description of the identified item to explain it's effect(s)
::Legends.Items.Relics.IdentifiedFlag <- "Item Identified";
::Legends.Items.Relics.UnidentifiedTooltip <- {
	id = 10,
	type = "text",
	icon = "ui/icons/special.png",
	text = "You aren\'t sure what it does. You\'ve heard of an ancient Witch living in a hut in the forest and an Oracle somewhere in the south who might know more about this"
}

::Legends.Items.Relics.Items <- [
	"accessory.legend_oms_amphora",
	"accessory.legend_oms_fate",
	"accessory.legend_oms_tome",
	"accessory.legend_oms_paw",
	"accessory.legend_oms_rib"
];

::Legends.Items.Relics.itemList <- function() {
	local items = ::World.Assets.getStash().getItems()
		.filter(@(_, item) item != null && ::Legends.S.oneOf(item.getID(), ::Legends.Items.Relics.Items));
	foreach (bro in ::World.getPlayerRoster().getAll()) {
		foreach (item in bro.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag)) {
			if (item != null && ::Legends.S.oneOf(item.getID(), ::Legends.Items.Relics.Items))
				items.push(item);
		}

		local item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
		if (item != null && ::Legends.S.oneOf(item.getID(), ::Legends.Items.Relics.Items))
			items.push(item);

	}
	return items;
};

::Legends.Items.Relics.unidentifiedList <-
	@() ::Legends.Items.Relics.itemList().filter(@(_, item) !item.getFlags().has(::Legends.Items.Relics.IdentifiedFlag));
