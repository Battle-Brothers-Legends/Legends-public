::FU.Class.ModSourceGitHub <- class extends ::FU.Class.ModSource
{
	static ModSourceDomain = ::FU.System.Registry.ModSourceDomain.GitHub;
	static Regex = regexp("https:\\/\\/github\\.com\\/([-\\w]+)\\/([-\\w]+)");

	constructor( _url )
	{
		if (!this.Regex.match(_url))
		{
			::logError("A GitHub link must be a link to a specific repository, e.g. 'https://github.com/FUTeam/FU' Check to make sure there's not an issue with your URL and that it is formatted the same way as the FU URL.");
			throw ::FU.Exception.InvalidValue(_url);
		}
		base.constructor(_url);
	}

	function getUpdateURL()
	{
		local capture = this.Regex.capture(this.__URL);
		return "https://api.github.com/repos/" + ::FU.regexMatch(capture, this.__URL, 1) + "/" + ::FU.regexMatch(capture, this.__URL, 2) + "/releases/latest"
	}
}
