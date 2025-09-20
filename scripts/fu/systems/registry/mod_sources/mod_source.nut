::FU.Class.ModSource <- class
{
	static ModSourceDomain = null;
	static Regex = null;
	__URL = null;

	constructor( _url )
	{
		this.__URL = _url;
	}

	function getUpdateURL()
	{
		return null;
	}

	function getURL()
	{
		return this.__URL
	}
}
