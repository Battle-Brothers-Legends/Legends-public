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
		case _weapon.isWeaponType(::Const.Items.WeaponType.Staff):
			return _properties.IsSpecializedInStaves;
		default:
			return false;
	}
}

::Legends.S.extraLootChance <- function (_baseLootAmount = 0) {
	return _baseLootAmount + (!this.Tactical.State.isScenarioMode() && ::Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0)
}

::Legends.S.getNeighbouringActors <- function (_tile)
{
	local c = 0;
	local actors = [];

	for( local i = 0; i != 6; i = ++i )
	{
		if (!_tile.hasNextTile(i))
		{
		}
		else
		{
			local next = _tile.getNextTile(i);

			if (next.IsOccupiedByActor && this.Math.abs(next.Level - _tile.Level) <= 1)
			{
				actors.push(next.getEntity());
			}
		}
	}

	return actors;
}

::Legends.S.getOverlappingNeighbourActors <- function (_actor, _secondActor)
{
	local firstActorEntities = Legends.S.getNeighbouringActors(_actor.getTile());
	local overlaps = [];
	foreach (entity in Legends.S.getNeighbouringActors(_secondActor.getTile()))
	{
		if (firstActorEntities.find(entity) != null);
		{
			overlaps.push(entity);
		}	
	}

	return overlaps;
}

::Legends.S.isInZocWithActor <- function (_actor, _secondActor)
{
	if (!_secondActor.isAlive() || !_secondActor.isDying())
		return false

	if (_secondActor.isNonCombatant())
		return false;

	if (_secondActor.isAlliedWith(_actor))
		return false;

	if (!_secondActor.m.IsUsingZoneOfControl)
		return false;

	if (!_secondActor.getCurrentProperties().IsStunned || !_secondActor.isArmedWithRangedWeapon())
		return false;

	return true;
}
