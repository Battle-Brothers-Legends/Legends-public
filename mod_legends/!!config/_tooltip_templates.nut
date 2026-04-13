local colors = [
	["rune",  ::Const.UI.Color.RuneColor],
	["passive",  ::Const.UI.Color.Passive],
	["active",  ::Const.UI.Color.Active],
	["oneTimeEffect",  ::Const.UI.Color.OneTimeEffect],
	["status",  ::Const.UI.Color.Status],
	["skill",  ::Const.UI.Color.Skill],
	["perk",  ::Const.UI.Color.Perk],
	["positive", ::Const.UI.Color.PositiveValue],
	["negative", ::Const.UI.Color.NegativeValue],
	["positiveEvent", ::Const.UI.Color.PositiveEventValue],
	["negativeEvent", ::Const.UI.Color.NegativeEventValue],
	["damage", ::Const.UI.Color.DamageValue],
];

::Legends.tooltip <- function (_text, _vars = [])  {
	_vars.extend(colors);
	return ::buildTextFromTemplate(::strip(_text), _vars);
}
