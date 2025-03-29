if (!("AmmoTypeName" in ::Const.Items))
{
	::Const.Items.AmmoTypeName <- [
		"No Ammunition",
		"Arrows",
		"Bolts",
		"Spears",
		"Powder"
	];
}

if (!("getAmmoTypeName" in ::Const.Items))
{
	::Const.Items.getAmmoTypeName <- function( _ammoType )
	{
		local idx = ::MSU.Math.log2int(_ammoType) + 1;
		if (idx < ::Const.Items.AmmoTypeName.len())
		{
			return ::Const.Items.AmmoTypeName[idx];
		}

		throw ::MSU.Exception.KeyNotFound(_ammoType);
	}
}
if (!("addNewAmmoType" in ::Const.Items))
{
	::Const.Items.addNewAmmoType <- function( _ammoType, _ammoTypeName = "" )
	{
		if (_ammoType in ::Const.Items.AmmoType) throw ::MSU.Exception.DuplicateKey(_ammoType);

		local max = 0;
		foreach (w, value in ::Const.Items.AmmoType)
		{
			if (value > max)
			{
				max = value;
			}
		}
		::Const.Items.AmmoType[_ammoType] <- max << 1;

		if (_ammoTypeName == "")
		{
			_ammoTypeName = _ammoType;
		}

		::Const.Items.AmmoTypeName.push(_ammoTypeName);
	}	
}

::Const.Items.addNewAmmoType("Pebbles", "Pebbles");
::Const.Items.addNewAmmoType("Rocks", "Rocks");
::Const.Items.addNewAmmoType("Darts", "Darts");
::Const.Items.addNewAmmoType("Heart", "Heart");
