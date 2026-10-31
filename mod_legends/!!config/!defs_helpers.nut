::Legends.DefsHelpers <- {
	MinorWords = ["of", "the", "and", "in", "on", "at", "to", "for", "a", "an", "with", "or", "by"]
};

/**
* Splits consts to array of strings,
* `LegendMasterOfPuppets01HTML` becomes `["Legend", "Master", "Of", "Puppets", "01", "HTML"]`
*/
::Legends.DefsHelpers.tokenizeConst <- function (_string) {
	local words = [], word = { end = 0 };
	while (word = regexp(@"\u\l+|\u+|\d+").search(_string, word.end)) {
		words.push(_string.slice(word.begin, word.end));
	}
	return words;
}

/**
* Converts const to snake case,
* `LegendMasterOfPuppets` becomes `legend_master_of_puppets`
*/
::Legends.DefsHelpers.convertToSnakeCase <- function (_string) {
	return ::Legends.DefsHelpers.tokenizeConst(_string).map(@(_str) _str.tolower()).reduce(@(p, c) ::format("%s_%s", p, c));
}

/**
* Converts const to name, strips prefix by default if exists,
* ::Legends.DefsHelpers.MinorWords array dictates which words will be converted to lowercase
* `LegendMasterOfPuppets` becomes `Master of Puppets`
*/
::Legends.DefsHelpers.convertToDisplayName <- function (_string, _strip = "Legend") {
	if (_string.find(_strip) == 0) {
		_string = _string.slice(_strip.len());
	}

	local words = ::Legends.DefsHelpers.tokenizeConst(_string);
	local transformedWords = [];
	foreach (idx, word in words) {
		if (idx != 0 && ::Legends.DefsHelpers.MinorWords.find(word.tolower()) != null) {
			transformedWords.push(word.tolower());
		} else {
			transformedWords.push(word);
		}
	}
	return transformedWords.reduce(@(p, c) ::format("%s %s", p, c));
}
