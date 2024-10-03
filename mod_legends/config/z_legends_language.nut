local gt = this.getroottable();

::Const.LegendMod.Language <- {};

gt.Const.LegendMod.Pronouns <- [
	"They",
	"they",
	"Them",
	"them",
	"Their",
	"their",
	"Theirs",
	"theirs",
	"Themselves",
	"themselves",
	"Person",
	"person",
	"People",
	"people",
	"swordsman",
	"Swordsman",
	"noble",
	"Noble",
	"Sibling",
	"sibling",
	"Sib",
	"sib",
];

gt.Const.LegendMod.PronounTable <- {
	they = ["they", "he", "she"],
	them = ["them", "him", "her"],
	their = ["their", "his", "her"],
	theirs = ["theirs", "his", "hers"],
	themselves = ["themselves", "himself", "herself"],
	person = ["person", "man", "woman"],
	people = ["people", "men", "women"],
	swordsman = ["swordsman", "swordsman", "swordwoman"],
	noble = ["noble", "nobleman", "noblewoman"],
	sibling = ["sibling", "brother", "sister"],
	sib = ["sib", "bro", "sis"],
}

// _gender = -1 for neuter, 0 for male, 1 for female
gt.Const.LegendMod.getPronoun <- function( _gender, _neuter )
{
	local capitalized = _neuter[0] < 96;
	if (capitalized) _neuter = _neuter.tolower();
	local pronoun = this.Const.LegendMod.PronounTable[_neuter][_gender + 1];

	if (capitalized)
	{
		local first = pronoun.slice(0, 1);
		first = first.toupper();
		local second = pronoun.slice(1);
		pronoun = first + second;
	}
	return pronoun;
}

gt.Const.LegendMod.ToBeVerbPronouns <- [
	["they are", ["they are", "he is", "she is"]],
	["they were", ["they were", "he was", "she was"]],
	["they will", ["they will", "he will", "she will"]], // technically not needed, but included for consistency
	["they're", ["they're", "he's", "she's"]],
	["they'll", ["they'll", "he'll", "she'll"]], // technically not needed, but included for consistency
	["are they", ["are they", "is he", "is she"]],
	["were they", ["were they", "was he", "was she"]],
]

gt.Const.LegendMod.extendVarsWithPronouns <- function( _vars, _gender, _characterIdentitySuffix = "" )
{
	// _characterIdentitySuffix allows for support for multiple characters with possibly different genders
	// For example, suppose in some event text we have 2 characters, "bro" (male) and "sis" (female)
	// Calling this function with _characterIdentitySuffix = "bro" and "sis" respectively will result in the following:
	// 		The placeholder text "%they_sis%" will be replaced with "she"
	//		The placeholder text "%Their_bro%" will be replaced with "His"
	//		etc.
	local suffix = (_characterIdentitySuffix == "" || _characterIdentitySuffix == null) ? "" : "_" + _characterIdentitySuffix;

	foreach (pronoun in this.Const.LegendMod.Pronouns)
	{
		_vars.push([
			pronoun + suffix,
			this.Const.LegendMod.getPronoun(_gender, pronoun)
		]);
	}

	// Add handling for pesky English to-be verbs and their corresponding pronouns
	foreach (pronounToBeVerb in this.Const.LegendMod.ToBeVerbPronouns)
	{
		local placeholder = pronounToBeVerb[0];
		local value = pronounToBeVerb[1][_gender + 1];

		_vars.push([
			placeholder + suffix,
			value
		]);

		// Add first-letter-capitalized versions as well
		_vars.push([
			placeholder.slice(0,1).toupper() + placeholder.slice(1) + suffix,
			value.slice(0,1).toupper() + value.slice(1),
		])

	}
}

::Const.LegendMod.Language.arrayToText <- function( _arr, _finalSeparator = "and", _highlight = false)
{
	local ret = "";
	if (_arr.len() == 0) return ret;

	// ret += ::Const.UI.getColorized(_arr[0],"#5d8ede");
	if(_highlight)
	{
		ret += ::Const.UI.getColorized(_arr[0],_highlight);	
	}
	else
	{
		ret += _arr[0];
	}
	

	if (_arr.len() == 1) return ret;

	for (local i = 1; i < _arr.len(); i++ )
	{
		local separator = (i == (_arr.len() - 1)) ? " " + _finalSeparator + " " : ", ";
		
		if(_highlight)
		{
			ret += separator + ::Const.UI.getColorized(_arr[i],_highlight);	
		}
		else
		{
			ret += separator + _arr[i];
		}
		
	}

	return ret;
}

::Const.LegendMod.Language.pluralize <- function( _len, _singular, _plural )
{
	return _len <= 1 ? _singular : _plural;
}