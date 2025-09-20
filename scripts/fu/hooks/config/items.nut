::Const.Items.ItemTypeName <- array(::Const.Items.ItemType.len(), "");

foreach (itemType in ::Const.Items.ItemType)
{
	local name = "";
	switch (itemType)
	{
		case ::Const.Items.ItemType.Legendary:
			name = "Legendary Item";
			break;

		case ::Const.Items.ItemType.Named:
			name = "Famed Item";				
			break;

		case ::Const.Items.ItemType.Tool:
			name = "Tool";				
			break;

		case ::Const.Items.ItemType.Crafting:
			name = "Crafting Item";				
			break;

		case ::Const.Items.ItemType.TradeGood:
			name = "Trade Good";				
			break;
	}

	local idx = itemType == 0 ? 0 : ::FU.Math.log2int(itemType) + 1;
	::Const.Items.ItemTypeName[idx] = name;
}

::Const.Items.addNewItemType <- function( _itemType, _name = "" )
{
	if (_itemType in ::Const.Items.ItemType)
	{
		::logWarning(format("Tried to add itemtype \"%s\" but it already exists!", _itemType));
		return;
	}

	foreach (itemType, value in ::Const.Items.ItemType) ::Const.Items.ItemType[itemType] = value << 1;
	foreach (itemFilter, value in ::Const.Items.ItemFilter) ::Const.Items.ItemFilter[itemFilter] = value << 1;

	::Const.Items.ItemType[_itemType] <- 1;
	::Const.Items.ItemFilter.All = ::Const.Items.ItemFilter.All | 1;
	::Const.Items.ItemTypeName.insert(1, _name);
}

::Const.Items.getItemTypeName <- function( _itemType )
{
	local idx = _itemType == 0 ? 0 : ::FU.Math.log2int(_itemType) + 1;
	if (idx < ::Const.Items.ItemTypeName.len())
	{
		return ::Const.Items.ItemTypeName[idx];
	}

	throw ::FU.Exception.KeyNotFound(_itemType);
}

::Const.Items.WeaponType <- {
	None = 0,
	Axe = 1,
	Bow = 2,
	Cleaver = 4,
	Crossbow = 8,
	Dagger = 16,
	Firearm = 32,
	Flail = 64,
	Hammer = 128,
	Mace = 256,
	Polearm = 512,
	Sling = 1024,
	Spear = 2048,
	Sword = 4096,
	Staff = 8192,
	Throwing = 16384,
	Musical = 32768
};

::Const.Items.WeaponTypeName <- [
	"No Weapon Type",
	"Axe",
	"Bow",
	"Cleaver",
	"Crossbow",
	"Dagger",
	"Firearm",
	"Flail",
	"Hammer",
	"Mace",
	"Polearm",
	"Sling",
	"Spear",
	"Sword",
	"Staff",
	"Throwing Weapon",
	"Musical Instrument"
];

::Const.Items.getWeaponTypeName <- function( _weaponType )
{
	local idx = ::FU.Math.log2int(_weaponType) + 1;
	if (idx < ::Const.Items.WeaponTypeName.len())
	{
		return ::Const.Items.WeaponTypeName[idx];
	}

	throw ::FU.Exception.KeyNotFound(_weaponType);
}

::Const.Items.addNewWeaponType <- function( _weaponType, _weaponTypeName = "" )
{
	if (_weaponType in ::Const.Items.WeaponType) throw ::FU.Exception.DuplicateKey(_weaponType);

	local max = 0;
	foreach (w, value in ::Const.Items.WeaponType)
	{
		if (value > max)
		{
			max = value;
		}
	}
	::Const.Items.WeaponType[_weaponType] <- max << 1;

	if (_weaponTypeName == "")
	{
		_weaponTypeName = _weaponType;
	}

	::Const.Items.WeaponTypeName.push(_weaponTypeName);
}
