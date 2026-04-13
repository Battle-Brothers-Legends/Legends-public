::Legends.Perks.PerkToPerkGroupMap <- {};

::Legends.Perks.PerkGroupCategoriesOrder <- [
	"Weapon",
	"Defense",
	"Traits",
	"Enemy",
	"Class",
	"Profession",
	"Magic",
	"Other"
];

// Map to get the priority of a perk group category, as ordered in ::Legends.Perks.PerkGroupCategoriesOrder
// ::Legends.Perks.PerkGroupCategoriesPriority
// {
// 	Weapon = 0,
// 	Defense = 1,
// 	Traits = 2,
// 	Enemy = 3,
// 	Class = 4,
// 	Profession = 5,
// 	Magic = 6,
// 	Other = 7
// }
::Legends.Perks.PerkGroupCategoriesPriority <- {};
foreach(key, value in ::Legends.Perks.PerkGroupCategoriesOrder)
{
	::Legends.Perks.PerkGroupCategoriesPriority[value] <- key;
}

// {
// 	Weapon = [],
// 	Defense = [],
// 	Traits = [],
// 	Enemy = [],
// 	Class = [],
// 	Profession = [],
// 	Magic = [],
// 	Other = []
// }
::Legends.Perks.buildPerkGroupCategoriesTableOfArrays <- function()
{
	local ret = {};
	foreach (category in ::Legends.Perks.PerkGroupCategoriesOrder)
	{
		ret[category] <- [];
	};
	return ret;
};

// {
// 	Weapon = {},
// 	Defense = {},
// 	Traits = {},
// 	Enemy = {},
// 	Class = {},
// 	Profession = {},
// 	Magic = {},
// 	Other = {}
// }
::Legends.Perks.buildPerkGroupCategoriesTableOfTables <- function()
{
	local ret = {};
	foreach (category in ::Legends.Perks.PerkGroupCategoriesOrder)
	{
		ret[category] <- {};
	};
	return ret;
};

// Call this when you need an array, where the index corresponds to a perk group category as ordered in ::Legends.Perks.PerkGroupCategoriesOrder
// [
// 	null,
// 	null,
// 	null,
// 	null,
// 	null,
// 	null,
// 	null,
// 	null
// ]
::Legends.Perks.buildPerkGroupCategoriesArray <- function()
{
	ret = [];
	foreach (category in ::Legends.Perks.PerkGroupCategoriesOrder)
	{
		ret.push(null);
	}
	return ret;
};

// Call this when you need an array of arrays, where the index corresponds to a perk group category as ordered in ::Legends.Perks.PerkGroupCategoriesOrder
// [
// 	[],
// 	[],
// 	[],
// 	[],
// 	[],
// 	[],
// 	[],
// 	[]
// ]
::Legends.Perks.buildPerkGroupCategoriesArrayOfArrays <- function()
{
	local ret = [];
	foreach (category in ::Legends.Perks.PerkGroupCategoriesOrder)
	{
		ret.push([]);
	}
	return ret;
};

// Record the category for each perk group that belongs to a category
foreach (key, category in ::Const.Perks)
{
	if ("GroupsCategory" in category)
	{
		// ::MSU.Log.printData("Handling Category: " + key);
		foreach (group in category.Tree)
		{
			group.Category <- category.GroupsCategory;
		}
	}
}

// Populate ::Legends.Perks.PerkToPerkGroupMap
// key: a number matching the index of the corresponding perk in ::Const.Perks.PerkDefObjects
// value: a table containing information regarding any and all perk groups that the perk belongs to
foreach (key, group in ::Const.Perks)
{
	// Only handle perk groups
	if (!("Name" in group))
		continue;

	// ::MSU.Log.printData("Handling Group: " + key);
	group.Perks <- []; // single array to store all the perkDefs that the perk group comprises
	foreach (row in group.Tree) {
		foreach (perkDef in row) {

			group.Perks.push(perkDef);

			if (!(perkDef in ::Legends.Perks.PerkToPerkGroupMap))
			{
				::Legends.Perks.PerkToPerkGroupMap[perkDef] <- {
					Groups = [],
					Const = ::Const.Perks.PerkDefObjects[perkDef].Const
				};
			}
			local category = "Category" in group ? group.Category : "Other";
			local entry = {
				ID = group.ID,
				Name = group.Name,
				Category = category
			};

			// ::MSU.Log.printData("Perk " + ::Const.Perks.PerkDefObjects[perkDef].Const + " from Group [" + key + "] categorized as [" + entry.Category + "]");
			::Legends.Perks.PerkToPerkGroupMap[perkDef].Groups.push(entry);
		}
	}
}

// Update all PerkDefObjects to add PerkGroups
foreach (perk in ::Const.Perks.PerkDefObjects)
{
	local key = ::Legends.Perk[perk.Const];

	// Handle Perks that do not belong to any Perk Group
	if (!(key in ::Legends.Perks.PerkToPerkGroupMap))
	{
		local entry = {
			ID = "Other",
			Name = "Other",
			Category = "Other"
		};

		perk.PerkGroups <- [];
		perk.PerkGroups.push(entry);

		continue;
	}

	// Handle Perks that belong to Perk Groups
	if ("PerkGroups" in perk)
	{
		perk.PerkGroups = ::Legends.Perks.PerkToPerkGroupMap[key].Groups;
	}
	else
	{
		perk.PerkGroups <- ::Legends.Perks.PerkToPerkGroupMap[key].Groups;
	}
}

// Check and resolve any perk group ID mismatches
foreach (key, value in ::Const.Perks)
{
	if ("Name" in value && key != value.ID)
	{
		::logWarning("Detected mismatched perk group key and ID: ::Const.Perks." + key + ".ID = " + value.ID);
		::Const.Perks[key].ID = key;
		::logWarning("Updated mismatched perk group key and ID: ::Const.Perks." + key + ".ID = " + value.ID);
	}
}

/**
 * 	Check if the Perk Group's perks can all be found in a given table of perkDefs
 *
 *	Will throw error if ::Const.Perks[_id].ID does not match the variable name
 * 	For example, the following must be true:
 * 	::Const.Perks.Foo.ID = "Foo"
 *
 * 	@param _id - The ID of a perk group
 *	@param _perkDefsTable - A table whose keys are perkDefs
 *
 * 	@return a boolean
 */
::Legends.Perks.isPerkGroupFullyRepresented <- function (_id, _perkDefsTable)
{
	if (_id == "Other")
	{
		return false;
	}

	foreach (perkDef in ::Const.Perks[_id].Perks)
	{
		if (!(perkDef in _perkDefsTable))
		{
			return false;
		}
	}
	return true;
}
