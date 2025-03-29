::Const.GetFactionArchetypesList <- function ()
{
	local result = [];
	for ( local i = 0; i < this.Const.FactionArchetypes.len(); i = ++i )
	{
		for (local j = 0; j < this.Const.FactionArchetypes[i].len(); j = ++j)
		{
			result.push([i, j]);
		}
	}
	return result
}
