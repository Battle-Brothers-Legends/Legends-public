::FU.Class.SystemModAddon <- class
{
	Mod = null;
	constructor( _mod )
	{
		this.Mod = _mod;
	}

	function getMod()
	{
		return this.Mod;
	}
}
