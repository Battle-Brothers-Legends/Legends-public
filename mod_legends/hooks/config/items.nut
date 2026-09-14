// add new item type
// ::Const.Items.addNewItemType("HorseArmor");
// ::Const.Items.ItemFilter.HorseArmor <- ::Const.Items.ItemType.HorseArmor;
// ::Const.Items.addNewItemType("HorseHelmet");
::Const.Items.addNewItemType("Cultist", "Cultist Item");
::Const.Items.addNewItemType("Brawler", "Brawler Item");
::Const.Items.addNewItemType("Net", "Net Item");

// new item types to associate with class perks
// Uses the MSU Item Types feature https://github.com/MSUTeam/MSU/wiki/ItemTypes
// WARNING: due to the limitations of 32-bit signed integers, we can only have up to 31 types, and we are very close to this limit
::Const.Items.addNewItemType("Shortbow", "Shortbow Item");
::Const.Items.addNewItemType("Pitchfork", "Pitchfork Item");
::Const.Items.addNewItemType("FencingSword", "Fencing Sword Item")
