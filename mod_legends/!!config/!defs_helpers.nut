::Legends.DefsHelpers <- {};

::Legends.DefsHelpers.convertToSnakeCase <- function (_string) {
	local res = "";
	for (local i = 0; i < _string.len(); i++) {
		local charCode = _string[i];
		if (charCode >= 65 && charCode <= 90) {
			if (i > 0) {
				res += "_";
			}
			res += (charCode + 32).tochar();
		} else {
			res += _string.slice(i, i + 1);
		}
	}

	return res;
}

local minorWords = ["of", "the", "and", "in", "on", "at", "to", "for", "a", "an", "with", "or", "by"];
::Legends.DefsHelpers.convertToDisplayName <- function (_string) {
	if (_string.find("Legend") == 0) {
		_string = _string.slice(6);
	}

	local words = [];
    local currentWord = "";

    for (local i = 0; i < _string.len(); i++) {
        local char = _string[i];
        
        if (char >= 65 && char <= 90) {
            if (currentWord.len() > 0) {
                words.push(currentWord);
                currentWord = "";
            }
        }
        currentWord += _string.slice(i, i + 1);
    }
    
    if (currentWord.len() > 0) {
        words.push(currentWord);
    }

    local res = "";
    foreach (i, word in words) {
        if (i > 0) res += " ";
		res += (i > 0 && (word.tolower() in minorWords) ? word.tolower() : word);
    }
	return res;
}