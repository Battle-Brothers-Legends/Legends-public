::FU.Class.RegistryModAddon <- class extends ::FU.Class.SystemModAddon
{
	__ModSources = null;
	__UpdateSource = null;

	constructor(_mod)
	{
		base.constructor(_mod);
		this.__ModSources = {};
	}

	function getModSource( _domain )
	{
		return this.__ModSources[_domain];
	}

	function hasModSource( _domain )
	{
		return _domain in this.__ModSources;
	}

	function addModSource( _domain, _url )
	{
		::FU.requireString(_url);
		this.__ModSources[_domain] <- ::FU.System.Registry.ModSources[_domain](_url);
	}

	function getUpdateSource()
	{
		if (!this.hasUpdateSource()) return null;
		return this.__ModSources[this.__UpdateSource];
	}

	function hasUpdateSource()
	{
		return this.__UpdateSource != null;
	}

	function setUpdateSource( _domain )
	{
		if (!(_domain in this.__ModSources))
		{
			::logError("Invalid domain value, make sure you've added this domain to the mod sources for this mod with addModSource");
			throw ::FU.Exception.InvalidValue(_domain);
		}
		if (_domain == ::FU.System.Registry.ModSourceDomain.NexusMods)
		{
			::logError("Due to the NexusMods API not being public we cannot support a NexusMods update source at this time");
			throw ::FU.Exception.InvalidValue(_domain);
		}
		this.__UpdateSource = _domain;
	}
}
