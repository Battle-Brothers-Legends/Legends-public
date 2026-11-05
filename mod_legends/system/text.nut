::Legends.Text <- {};

::Legends.Text.colorize <- @(_valueString, _value, _threshold = 0)"[color=" + (_value >= _threshold ? "%positive%" : "%negative%") + "]" + _valueString + "[/color]";

::Legends.Text.getSign <- @(_value)(_value == 0 ? "" : (_value > 0 ? "+" : "-"));

::Legends.Text.getSignWithEqual <- @(_value)(::Legends.Text.getSign == "" ? "=" : ::Legends.Text.getSign);

::Legends.Text.addSign <- @(_value)(_value > 0 ? "+" : "") + _value;

::Legends.Text.addSignAndColorize <- @(_value, _isPercentage = false) ::Legends.Text.colorize((_value > 0 ? "+" : "") + _value + (_isPercentage ? "%" : ""), _value);

::Legends.Text.highlightForLightBackground <- @(_text) ::Const.UI.getColorized(_text, ::Const.UI.Color.getHighlightLightBackgroundValue());

::Legends.Text.highlightForDarkBackground <- @(_text) ::Const.UI.getColorized(_text, ::Const.UI.Color.getHighlightDarkBackgroundValue());

::Legends.Text.inlineIcons <- function (_icons, _height = 16, _width = 16, _path = "gfx/ui/icons/", _extension = ".png") {
	local result = "";
	if (typeof(_icons) == "array") {
		foreach (icon in _icons) {
			result += "[leg_img](" + _path + icon + _extension + ",height=" + _height + "px,width=" + _width + "px)[/leg_img]";
		}
	} else {
		result = "[leg_img](" + _path + _icons + _extension + ",height=" + _height + "px,width=" + _width + "px)[/leg_img]";
	}
	return result;
}

::Legends.Text.pluralize <- function (_value, _text, _irregular = "") {
	if (_value != 1) {
		if (_irregular.len() > 0) {
			_text = _irregular;
		} else {
			local last = _text.slice(-1).tolower();

			if (last == "y") {
				local secondLast = _text.slice(-2, -1).tolower();
				_text = (secondLast != "a" && secondLast != "e" && secondLast != "i" && secondLast != "o" && secondLast != "u") ? (_text.slice(0, -1) + "ies") : (_text + "s");
			} else {
				local lastTwo = _text.slice(-2).tolower();
				_text += (last == "s" || last == "x" || last == "z" || lastTwo == "sh" || lastTwo == "ch") ? "es" : "s";
			}
		}
	}

	return _text;
}

::Legends.Text.isPatternInText <- @(_pattern, _text)((!_pattern || !_text) ? false : this.regexp(_pattern).search(_text));

::Legends.Text.colorizeAndPluralize <- @(_value, _color, _text = "", _percent = false, _irregular = "")"[color=%" + _color + "%]" + _value + (_percent ? "%" : "") + "[/color]" + (_text.len() > 0 ? " " + ::Legends.Text.pluralize(_value, _text, _irregular) : "");
