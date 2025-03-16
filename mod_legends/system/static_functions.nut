::Legends.S <- {};

::Legends.S.colorize <- function(_valueString, _value)
{
    local color = (_value >= 0) ? this.Const.UI.Color.PositiveValue : this.Const.UI.Color.NegativeValue;
    return "[color=" + color + "]" + _valueString + "[/color]";
}

::Legends.S.getSign <- function(_value)
{
    if(_value == 0) return "";
    return (_value > 0) ? "+" : "-";
}

::Legends.S.getChangingWord <- function( _value )
{
	if(_value >= 0) return "increase";
	return "decrease";
}

::Legends.S.patternIsInText <- function ( pattern, text )
{
	if (!pattern || !text)
	{
		return false;
	}

	return this.regexp(pattern).search(text);
};

::Legends.S.isCharacterWeaponSpecialized <- function( _properties, _weapon )
{
	switch (true)
	{
		case _weapon.isWeaponType(::Const.Items.WeaponType.Axe):
			return _properties.IsSpecializedInAxes;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Bow):
			return _properties.IsSpecializedInBows;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Crossbow):
			return _properties.IsSpecializedInCrossbows;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Dagger):
			return _properties.IsSpecializedInDaggers;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Flail):
			return _properties.IsSpecializedInFlails;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Hammer):
			return _properties.IsSpecializedInHammers;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Mace):
			return _properties.IsSpecializedInMaces;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Sling):
			return _properties.IsSpecializedInSlings;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Spear):
			return _properties.IsSpecializedInSpears;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Sword):
			return _properties.IsSpecializedInSwords;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Throwing):
			return _properties.IsSpecializedInThrowing;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Polearm):
			return _properties.IsSpecializedInPolearms;
		default:
			return false;
	}
}
