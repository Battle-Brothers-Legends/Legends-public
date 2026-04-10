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

::Legends.S.getClosestSettlement <- function (_predicate = @(_, _town) true) {
	local towns = this.World.EntityManager.getSettlements().filter(_predicate);
	if (towns.len() == 0)
		return null;
	local playerTile = ::World.State.getPlayer().getTile();
	towns.sort(@(a, b) playerTile.getDistanceTo(b.getTile()) <=> playerTile.getDistanceTo(a.getTile()));
	return towns.top();
}

// Sorry chop but I really need to alias this function for my sanity
::Legends.S.isEntityNullOrDead <- function (_entity, _otherEntity = 0) {
	return ::Legends.S.skillEntityAliveCheck(_entity, _otherEntity);
}

::Legends.S.skillEntityAliveCheck <- function (_entity, _otherEntity = 0) {
	if (::Legends.S.isNull(_entity) || !_entity.isAlive() || _entity.isDying())
		return true;
	if (_otherEntity == 0)
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
		_properties.MeleeSkill += bonus;
		_properties.RangedSkill += bonus;
		_properties.MeleeDefense += this.Math.floor(bonus / 2);
		_properties.RangedDefense += this.Math.floor(bonus / 2);
		_properties.Hitpoints += this.Math.floor(bonus * 2);
		_properties.Initiative += this.Math.floor(bonus / 2);
		_properties.Stamina += bonus;
		//	b.XP += this.Math.floor(bonus * 4);
		_properties.Bravery += bonus;
		_properties.FatigueRecoveryRate += this.Math.floor(bonus / 4);
	}
}

::Legends.S.getToolEfficiency <- function () {
	// Sum combined tool efficiency modifier (eg +4 from Tool Drawers) from all brothers
	local toolEfficiencyModifier = 0;
	foreach (bro in this.World.getPlayerRoster().getAll()) {
		toolEfficiencyModifier += bro.getToolEfficiencyModifier();
	}
	// Repair tent adds ~25% efficiency (yields ~20 dura per tool instead of 15 ie. 33% increase).
	if (this.World.Assets.getStash().hasItem(::Legends.Camp.Tent.Repair)) {
		toolEfficiencyModifier += 25;
	}
	// Cap efficiency at 50%
	return this.Math.maxf(0.5, (100.0 - toolEfficiencyModifier) / 100.0);
}

::Legends.S.applyBleed <- function (_target, _actor, _hpBefore, _soundsA, _soundsB, _damage = 0, _effect = ::Legends.Effect.Bleeding) {
	local damage = 0;
	if (_damage > 0) {
		damage = _damage;
	}
	else {
		damage = _actor.getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;
	}

	if (::Legends.S.isEntityNullOrDead(_target)) {
		if (_target.getFlags().has("tail") || !_target.getCurrentProperties().IsImmuneToBleeding) {
			this.Sound.play(_soundsA[this.Math.rand(0, _soundsA.len() - 1)], this.Const.Sound.Volume.Skill, _actor.getPos());
		}
		else {
			this.Sound.play(_soundsB[this.Math.rand(0, _soundsB.len() - 1)], this.Const.Sound.Volume.Skill, _actor.getPos());
		}
	}
	else if (!_target.getCurrentProperties().IsImmuneToBleeding && _hpBefore - _target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding ) {
		::Legends.Effects.grant(_target, _effect, function(_effect) {
			if (_actor.getFaction() == this.Const.Faction.Player )
				_effect.setActor(_actor);
			_effect.setDamage(damage);
		}.bindenv(this));
		this.Sound.play(_soundsA[this.Math.rand(0, _soundsA.len() - 1)], this.Const.Sound.Volume.Skill, _actor.getPos());
	}
	else {
		this.Sound.play(_soundsB[this.Math.rand(0, _soundsB.len() - 1)], this.Const.Sound.Volume.Skill, _actor.getPos());
	}
}

::Legends.S.oneOf <- function (_value, ...) {
	if (vargv.len() == 0) {
		::logError("::Legends.S.oneOf used with empty args, returning false");
		return false;
	}
	local arr = vargv;
	if (typeof vargv[0] == "array")
		arr = vargv[0];
	foreach(val in arr) {
		if (_value == val)
			return true;
	}
	return false;
}

::Legends.S.hasItemFlag <- function (_item, _flag) {
	if (_item == null)
		return false;
	return _item.getFlags().has(_flag);
}

// it's intended to use with .pop() when filling, so the sort is opposite of what it would normally be
::Legends.S.getEmptySlotsInFormation <- function () {
	local formation = ::World.getPlayerRoster().getAll().filter(@(_, _bro) !_bro.isInReserves()).map(@(_bro) _bro.getPlaceInFormation());
	local ret = [];
	for(local i = 0; i < 27; i++) {
		if (formation.find(i) == null)
			ret.push(i);
	}
	ret.sort(function (a, b) {
		local rowA = a / 9, rowB = b / 9, colA = a % 9, colB = b % 9;
		if (rowA != rowB) // prefer further rows
			return rowA - rowB;
		local distA = ::Math.abs(colA - 4);
		local distB = ::Math.abs(colB - 4);
		return distB - distA; // prefer closer to center of row
	});
	return ret;
}

::Legends.S.logArmor <- function (_armor) {
	if (!_armor.isEquipped())
		return;

	::logWarning("Armor Layering");
	::logWarning("--------------");
	::logWarning("Durability: " + _armor.getArmorMax());
	::logWarning("StaminaMod: " + _armor.getStaminaModifier());

	local upgrade = _armor.getUpgradeIDs();
	local upgText = [];
	local clothText = "\"cloth/" + split(_armor.getID(), ".")[2] + "\", " + _armor.getVariant();

	if (upgrade[0] == null) { upgText.push("\"\""); }
		else {upgText.push("\"chain/" + split(upgrade[0], ".")[2] + "\", " + _armor.getUpgradeVariant(0))}
	if (upgrade[1] == null) { upgText.push("\"\""); }
		else {upgText.push("\"plate/" + split(upgrade[1], ".")[2] + "\", " + _armor.getUpgradeVariant(1))}
	if (upgrade[3] == null) { upgText.push("\"\""); }
		else {upgText.push("\"cloak/" + split(upgrade[3], ".")[2] + "\", " + _armor.getUpgradeVariant(3))}
	if (upgrade[2] == null) { upgText.push("\"\""); }
		else {upgText.push("\"tabard/" + split(upgrade[2], ".")[2] + "\", " + _armor.getUpgradeVariant(2))}
	if (upgrade[4] == null) { upgText.push("\"\""); }
		else {upgText.push("\"armor_upgrades/" + split(upgrade[2], ".")[2] + "\", " + _armor.getUpgradeVariant(2))}

	local toPrint = "{"       +
					"\n\tID = \"CHANGEME\"," +
					"\n\tScript = \"\"," +
					"\n\tSets = [{" +
					"\n\t\tCloth = [[1, "       + clothText  + "]]," +
					"\n\t\tChain = [[1, "       + upgText[0] + "]]," +
					"\n\t\tPlate = [[1, "       + upgText[1] + "]]," +
					"\n\t\tCloak = [[1, "       + upgText[2] + "]]," +
					"\n\t\tTabard = [[1, "      + upgText[3] + "]]," +
					"\n\t\tAttachments = [[1, " + upgText[4] + "]]," +
					"\n\t}]" +
					"\n},";

	::logWarning(toPrint);
}

::Legends.S.logHelmet <- function (_helmet) {
	if (!_helmet.isEquipped())
		return;

	::logWarning("Helmet Layering");
	::logWarning("---------------");
	::logWarning("Durability: " + _helmet.getArmorMax());
	::logWarning("StaminaMod: " + _helmet.getStaminaModifier());

	local upgrade = _helmet.getUpgradeIDs();
	local upgText = [];
	local hoodText = "\"hood/" + split(_helmet.getID(), ".")[2] + "\", " + _helmet.getVariant();

	if (upgrade[0] == null) { upgText.push("\"\""); }
		else {upgText.push("\"helm/" + split(upgrade[0], ".")[2] + "\", " + _helmet.getUpgradeVariant(0))}
	if (upgrade[1] == null) { upgText.push("\"\""); }
		else {upgText.push("\"top/" + split(upgrade[1], ".")[2] + "\", " + _helmet.getUpgradeVariant(1))}
	if (upgrade[2] == null) { upgText.push("\"\""); }
		else {upgText.push("\"vanity/" + split(upgrade[2], ".")[2] + "\", " + _helmet.getUpgradeVariant(2))}

	local toPrint = "{"       +
					"\n\tID = \"CHANGEME\"," +
					"\n\tScript = \"\"," +
					"\n\tSets = [{" +
					"\n\t\tHoods = [[1, "  + hoodText   + "]]," +
					"\n\t\tHelms = [[1, "  + upgText[0] + "]]," +
					"\n\t\tTops = [[1, "   + upgText[1] + "]]," +
					"\n\t\tVanity = [[1, " + upgText[2] + "]]," +
					"\n\t}]" +
					"\n},";

	::logWarning(toPrint);
}
