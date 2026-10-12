::Legends.DefsHelpers <- {
	MinorWords = ["of", "the", "and", "in", "on", "at", "to", "for", "a", "an", "with", "or", "by"]
};

/**
* Splits consts to array of strings,
* `LegendMasterOfPuppets` becomes `["Legend", "Master", "Of", "Puppets"]`
*/
::Legends.DefsHelpers.tokenizeConst <- function (_string) {
	local words = [];
	local lastIndex = 0;

	local predicate = @(_c) _c == _c.toupper() && _c != _c.tolower();

	for (local i = 1; i < _string.len(); i++) {
		if (predicate(_string.slice(i, i + 1))) {
			words.push(_string.slice(lastIndex, i));
			lastIndex = i;
		}
	}
	words.push(_string.slice(lastIndex, _string.len()));

	return words;
}

/**
* Converts const to snake case,
* `LegendMasterOfPuppets` becomes `legend_master_of_puppets`
*/
::Legends.DefsHelpers.convertToSnakeCase <- function (_string) {
	return ::Legends.DefsHelpers.tokenizeConst(_string)
		.map(@(_str) _str.tolower())
		.reduce(@(p, c) ::format("%s_%s", p, c));
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
	foreach(idx, word in words) {
		if (idx != 0 && ::Legends.DefsHelpers.MinorWords.find(word.tolower()) != null)
			transformedWords.push(word.tolower());
		else
			transformedWords.push(word);
	}
	return transformedWords.reduce(@(p, c) ::format("%s %s", p, c));
}
