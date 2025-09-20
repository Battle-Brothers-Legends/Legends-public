::FU.Class.ModSourceNexusMods <- class extends ::FU.Class.ModSource
{
	static ModSourceDomain = ::FU.System.Registry.ModSourceDomain.NexusMods;
	static Regex = regexp("https:\\/\\/www\\.nexusmods\\.com\\/battlebrothers\\/mods\\/(\\d+)");

	constructor( _url )
	{
		if (!this.Regex.match(_url))
		{
			::logError("A NexusMods link must be a link to a specific mod's main page, e.g. 'https://www.nexusmods.com/battlebrothers/mods/479' Check to make sure there's not an issue with your URL and that it is formatted the same way as the FU URL.");
			throw ::FU.Exception.InvalidValue(_url);
		}
		base.constructor(_url);
	}

	function getUpdateURL()
	{
		return null; // not currently supported for nexusmods
	}
}
