// Members counted for company strength and roster-size ambitions. This is a
// separate view: the real roster still owns every member and enforces capacity.
// Mods may define isExcludedFromCompanySize() on a roster entity to opt it out.
::FU.GetCompanyRoster <- function()
{
	local result = [];
	foreach (bro in ::World.getPlayerRoster().getAll())
		if (!("isExcludedFromCompanySize" in bro) || !bro.isExcludedFromCompanySize()) result.push(bro);
	return result;
};
