::Legends.S <- {};

::Legends.S.isNull <- ::MSU.isNull;

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
		case _weapon.isWeaponType(::Const.Items.WeaponType.Cleaver):
			return _properties.IsSpecializedInCleavers;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Crossbow):
		case _weapon.isWeaponType(::Const.Items.WeaponType.Firearm): // handgonne
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
		case _weapon.isWeaponType(::Const.Items.WeaponType.Staff):
		case _weapon.isWeaponType(::Const.Items.WeaponType.Polearm):
			return _properties.IsSpecializedInPolearms;
		case _weapon.isWeaponType(::Const.Items.WeaponType.Musical):
			return _properties.IsSpecializedInMusic;
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
		return false;

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

::Legends.S.getClosestSettlement <- function () {
	local towns = this.World.EntityManager.getSettlements();
	local nearestTown;
	local nearestDist = 9999;
	foreach (t in towns)
	{
		local d = t.getTile().getDistanceTo(::World.State.getPlayer().getTile());
		if (d < nearestDist && t.isAlliedWithPlayer() && ::World.FactionManager.getFaction(t.getFaction()).getContracts().len() != 0)
		{
			nearestTown = t;
			nearestDist = d;
		}
	}
	return nearestTown;
}

::Legends.S.skillEntityAliveCheck <- function (_entity, _otherEntity = null) {
	if (::Legends.S.isNull(_entity) || !_entity.isAlive() || _entity.isDying())
		return true;
	if (_otherEntity == null)
		return false;
	if (::Legends.S.isNull(_otherEntity) || !_otherEntity.isAlive() || _otherEntity.isDying())
		return true;
	return false;
}

::Legends.S.getDaysToScaleDifficulty <- function () {
	switch (this.World.Assets.getCombatDifficulty()) {
		case this.Const.Difficulty.Easy:
			return 120;
		case this.Const.Difficulty.Normal:
			return 90;
		case this.Const.Difficulty.Hard:
			return 60;
		case this.Const.Difficulty.Legendary:
			return 30;
		default:
			::logError("Unknown combat difficulty: " + this.World.Assets.getCombatDifficulty());
			return 0;
	}
}

::Legends.S.scaleBaseProperties <- function (_properties) {
	if (this.Tactical.State.isScenarioMode()) {
		return;
	}
	local daysToScale = this.World.getTime().Days - this.getDaysToScaleDifficulty();
	if (daysToScale > 0) {
		local bonus = this.Math.floor(daysToScale / 20.0);
		b.MeleeSkill += bonus;
		b.RangedSkill += bonus;
		b.MeleeDefense += this.Math.floor(bonus / 2);
		b.RangedDefense += this.Math.floor(bonus / 2);
		b.Hitpoints += this.Math.floor(bonus * 2);
		b.Initiative += this.Math.floor(bonus / 2);
		b.Stamina += bonus;
		//	b.XP += this.Math.floor(bonus * 4);
		b.Bravery += bonus;
		b.FatigueRecoveryRate += this.Math.floor(bonus / 4);
	}
}

::Legends.S.getToolEfficiency <- function () {
	// Sum combined tool efficiency modifier (eg +4 from Tool Drawers) from all brothers
	local toolEfficiencyModifier = 0;
	foreach (bro in this.World.getPlayerRoster().getAll()) {
		toolEfficiencyModifier += bro.getToolEfficiencyModifier();
	}
	// Cap efficiency at 50%
	return this.Math.maxf(0.5, (100.0 - toolEfficiencyModifier) / 100.0);
}

::Legends.S.oneOf <- function (_value, ...) {
	foreach(val in vargv) {
		if (_value == val)
			return true;
	}
	return false;
}
