::FU.Class.Mod <- class
{
	ID = null;
	Name = null;
	Version = null;
	PreRelease = null;
	Metadata = null;

	// Systems
	Debug = null;
	Keybinds = null;
	ModSettings = null;
	Registry = null;
	Serialization = null;
	PersistentData = null;
	Tooltips = null;

	constructor( _id, _version, _name = null )
	{
		if (_name == null) _name = _id;
		::FU.requireString(_id, _version, _name);

		this.ID = _id;
		this.Name = _name;

		local table = ::FU.SemVer.getTable(_version);
		this.Version = table.Version;
		this.PreRelease = table.PreRelease;
		this.Metadata = table.Metadata;
		::FU.System.Registry.registerMod(this);
		::FU.System.Debug.registerMod(this);
		::FU.System.ModSettings.registerMod(this);
		::FU.System.Keybinds.registerMod(this);
		::FU.System.Serialization.registerMod(this);
		::FU.System.PersistentData.registerMod(this);
		::FU.System.Tooltips.registerMod(this);
	}

	function getName()
	{
		return this.Name;
	}

	function getID()
	{
		return this.ID;
	}

	function getShortVersionString()
	{
		return ::FU.SemVer.getShortVersionString(this);
	}

	function getVersionString()
	{
		return ::FU.SemVer.getVersionString(this);
	}

	function tostring()
	{
		return format("Mod %s, Versions %s\n", this.getID(), this.getVersionString());
	}

	function _tostring()
	{
		return this.tostring();
	}
}
