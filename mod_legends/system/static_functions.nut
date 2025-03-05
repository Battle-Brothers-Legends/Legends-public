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

::Legends.S.isCharacterWeaponSpecialized <- function( _properties, _weapon )
{
	switch (true)
	{
		case _weapon.isWeaponType(this.Const.WeaponType.Axe):
			return _properties.IsSpecializedInAxes;
		case _weapon.isWeaponType(this.Const.WeaponType.Bow):
			return _properties.IsSpecializedInBows;
		case _weapon.isWeaponType(this.Const.WeaponType.Crossbow):
			return _properties.IsSpecializedInCrossbows;
		case _weapon.isWeaponType(this.Const.WeaponType.Dagger):
			return _properties.IsSpecializedInDaggers;
		case _weapon.isWeaponType(this.Const.WeaponType.Flail):
			return _properties.IsSpecializedInFlails;
		case _weapon.isWeaponType(this.Const.WeaponType.Hammer):
			return _properties.IsSpecializedInHammers;
		case _weapon.isWeaponType(this.Const.WeaponType.Mace):
			return _properties.IsSpecializedInMaces;
		case _weapon.isWeaponType(this.Const.WeaponType.Sling):
			return _properties.IsSpecializedInSlings;
		case _weapon.isWeaponType(this.Const.WeaponType.Spear):
			return _properties.IsSpecializedInSpears;
		case _weapon.isWeaponType(this.Const.WeaponType.Sword):
			return _properties.IsSpecializedInSwords;
		case _weapon.isWeaponType(this.Const.WeaponType.Throwing):
			return _properties.IsSpecializedInThrowing;
		default:
			return false;
	}
}
