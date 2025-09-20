::FU.Class.System <- class
{
	ID = null;
	constructor( _id, _dependencies = null )
	{
		if (_dependencies == null) _dependencies = [];

		foreach (dependency in _dependencies)
		{
			local found = false;
			foreach (system in ::FU.System)
			{
				if (dependency == system.getID())
				{
					found = true;
					break;
				}
			}
			if (!found)
			{
				throw "Dependencies not yet initialized";
			}
		}
		this.ID = _id;
	}

	function getID()
	{
		return this.ID;
	}

	function registerMod( _mod )
	{
		if (typeof _mod != "instance" || !(_mod instanceof ::FU.Class.Mod))
		{
			throw ::FU.Exception.InvalidType(_mod);
		}
	}
}
