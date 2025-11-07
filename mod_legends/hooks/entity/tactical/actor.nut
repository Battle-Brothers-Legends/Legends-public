::mods_hookExactClass("entity/tactical/actor", function(o)
{
//	while(!("BloodSaturation" in o.m)) o = o[o.SuperName];
	o.m.KillerPercentOnKillOtherActorModifier <- 1.0;
	o.m.KillerFlatOnKillOtherActorModifier <- 0;
	o.m.BloodSaturation = 1.5;
	o.m.DeathBloodAmount = 1.5;
	o.m.BloodPoolScale = 1.25;
	o.m.HealRemainder <- 0.0;
	o.m.RiderID <- "";
	// Follows the [% chance, script|function] convention
	o.m.OnDeathLootTable <- [];
	o.m.HitInfo <- null;

	o.getGender <- function()
	{
		return -1;
	}

	local setCurrentMovementType = o.setCurrentMovementType;
	o.setCurrentMovementType = function( _t ) // to trigger the removal of stances skill upon being moved out of will
	{
		if (_t == ::Const.Tactical.MovementType.Involuntary && !::Tactical.TurnSequenceBar.isActiveEntity(this)) {
			getFlags().remove("CanNotBeStaggered"); // a hack to prevent teamplayer user from staggering ally
			::Const.Tactical.Common.removeStances(this);
		}

		setCurrentMovementType(_t);
	}

	o.querySwitchableItems <- function()
	{
		local items = [];
		local inv = this.getItems();

		if (inv.isActionAffordable([]))
		{
			for( local i = 0; i < inv.getUnlockedBagSlots(); i++ )
			{
				local item = inv.getItemAtBagSlot(i);

				if (item == null)
				{
					continue;
				}

				local slot = item.getSlotType();

				if (slot == ::Const.ItemSlot.None || slot == ::Const.ItemSlot.Bag)
				{
					continue;
				}

				local currentItem = inv.getItemAtSlot(slot);
				if (item == null)
					continue;
				if (!item.isChangeableInBattle())
					continue;

				if ((item.isItemType(::Const.Items.ItemType.Weapon) || item.isItemType(::Const.Items.ItemType.Tool) || item.isItemType(::Const.Items.ItemType.Shield) || item.isItemType(::Const.Items.ItemType.Accessory) || item.isItemType(::Const.Items.ItemType.Ammo) && item.m.Ammo != 0) && inv.isActionAffordable(currentItem != null ? [
					currentItem,
					item
				] : [
					item
				]))
				{
					items.append(item);
				}
			}
		}

		return items;
	}

	local onOtherActorDeath = o.onOtherActorDeath;
	o.onOtherActorDeath = function ( _killer, _victim, _skill )
	{
		if (!isAlive() || isDying())
			return;

		if (_killer != null && getAlliedFactions().find(_victim.getFaction()) != null) {
			m.KillerPercentOnKillOtherActorModifier = _killer.getPercentOnKillOtherActorModifier();
			m.KillerFlatOnKillOtherActorModifier = _killer.getFlatOnKillOtherActorModifier();
		}

		onOtherActorDeath(_killer, _victim, _skill);
		m.KillerPercentOnKillOtherActorModifier = 1.0;
		m.KillerFlatOnKillOtherActorModifier = 0;
	}

	local checkMorale = o.checkMorale;
	o.checkMorale = function (_change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false)
	{
		if (m.KillerPercentOnKillOtherActorModifier != 1.0)
			_difficulty = ::Math.floor(_difficulty * m.KillerPercentOnKillOtherActorModifier);

		return checkMorale(_change, _difficulty + m.KillerFlatOnKillOtherActorModifier, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	o.getPercentOnKillOtherActorModifier <- function ()
	{
		return this.getCurrentProperties().PercentOnKillOtherActorModifier;
	}

	o.getFlatOnKillOtherActorModifier <- function ()
	{
		return this.getCurrentProperties().FlatOnKillOtherActorModifier;
	}

	o.isStabled <- function ()
	{
		return false;
	}

	local isTurnDone = o.isTurnDone;
	o.isTurnDone = function()
	{
		if (!this.Tactical.getNavigator().isTravelling(this) && isPlayerControlled() && !m.CurrentProperties.IsStunned && !this.Settings.getGameplaySettings().DontAutoEndTurns)
		{
			local usableSkill = false;
			foreach (skill in this.m.Skills.queryActives())
			{
				if (skill != null && skill.isUsable() && skill.isAffordable())
				{
					usableSkill = true;
					break;
				}
			}
			return this.m.IsTurnDone || this.m.IsSkippingTurn || this.m.ActionPoints < this.Const.Movement.AutoEndTurnBelowAP && !this.m.Skills.isBusy() && !usableSkill;
		}
		return isTurnDone();
	}

	local onMovementFinish = o.onMovementFinish;
	o.onMovementFinish = function (_tile)
	{
		// Lionheart perk start
		local otherActors = [];
		for (local i = 0; i != 6; i++) {
			if (_tile.hasNextTile(i)) {
				local tile = _tile.getNextTile(i);
				if (!tile.IsOccupiedByActor)
					continue;
				otherActors.push(tile.getEntity());
			}
		}
		local isAliedPtrs = [];
		foreach(i, actor in otherActors) {
			isAliedPtrs.push(actor.isAlliedWith);
			actor.isAlliedWith = function(_other) {
				if (this == null || actor == null)
					return false;
				if (_other == null)
					return false;
				// check if checkMorale should happen when enemies are affected by it
				return isAliedPtrs[i](_other) && this.m.CurrentProperties.IsAffectedByMovementMorale;
			}.bindenv(actor);
		}
		// original does check with 40 and -1000 difficulty in this function, lionheart check just first one, so
		local fnPtr = this.checkMorale;
		this.checkMorale = function (_change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false) {
			if ( _difficulty > 0) { // check if it's the 40.0 one we want to change
				if (this.m.CurrentProperties.IsAffectedByMovementMorale && _difficulty > 0)
					return fnPtr(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine)
			} else { // if it's -1000 one, use at is was
				return fnPtr(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine)
			}
		}.bindenv(this);
		// Lionheart perk stop
		onMovementFinish(_tile);
		// restore state
		foreach (i, actor in otherActors) {
			if (actor == null)
				continue;
			actor.isAlliedWith = isAliedPtrs[i];
		}
		this.checkMorale = fnPtr;
	}

	o.isArmedWithMagicStaff <- function()
	{
		local item = this.getMainhandItem();
		return item != null && item.isWeaponType(this.Const.Items.WeaponType.MagicStaff);
	}

	o.equipItem <- function( _item)
	{
		return this.getItems().equip(_item);
	}

	o.bagItem <- function (_item)
	{
		return this.getItems().addToBag(_item);
	}

	o.setArmor <- function (_bodyPart, _value)
	{
		this.m.BaseProperties.Armor[_bodyPart] = _value;
	}

	local onMissed = o.onMissed;
	o.onMissed = function ( _attacker, _skill, _dontShake = false )
	{
		// Attempt to Parry
		local isParrying = false;
		local validAttackerToParry = _attacker != null
			&& _attacker.isAlive()
			&& !_attacker.isAlliedWith(this)
			&& _attacker.getTile().getDistanceTo(this.getTile()) == 1
			&& ::Tactical.TurnSequenceBar.getActiveEntity() != null
			&& ::Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID();
		local validSkillToParry = _skill != null
			&& !_skill.isIgnoringRiposte()
			&& _skill.m.IsWeaponSkill;

		if (this.getCurrentProperties().IsParrying
			&& !this.getCurrentProperties().IsStunned
			&& validAttackerToParry
			&& validSkillToParry
			&& !_attacker.getCurrentProperties().IsImmuneToDisarm
			&& !_attacker.getSkills().hasEffect(::Legends.Effect.LegendParried)
		) {
			if (this.isHiddenToPlayer()) {
				::Legends.Effects.grant(_attacker, ::Legends.Effect.LegendParried);
				this.onBeforeRiposte(_attacker, _skill);
			}
			else {
				isParrying = true;
				local attacker = _attacker, skill = _skill;
				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay * 1.5, this.onParryVisible.bindenv(this), {
					Actor = this, // this is technically not needed here because of bindenv
					Attacker = attacker,
					Skill = skill
				});
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this) + " Parries the attack from " + ::Const.UI.getColorizedEntityName(_attacker));
		}
		else
		{
			this.onBeforeRiposte(_attacker, _skill);
		}

		if (isParrying)
			this.m.CurrentProperties.IsRiposting = false;
		onMissed(_attacker, _skill, _dontShake);
	}

	o.onParryVisible <- function (_info)
	{
		if (_info.Attacker == null) {
			::logInfo("attacker == null, wtf?");
		}
		if (_info.Skill == null) {
			::logInfo("skill == null, wtf?");
		}
		if (_info.Actor == null) {
			::logInfo("actor == null, wtf?");
		}
		if (this == null) {
			::logInfo("this == null, wtf?");
		}
		// Animate and provide sound effects for the Parry, and apply the Vulnerable effect
		::Tactical.spawnSpriteEffect("en_garde_square", this.createColor("#ffffff"), _info.Actor.getTile(),
			::Const.Tactical.Settings.SkillOverlayOffsetX, ::Const.Tactical.Settings.SkillOverlayOffsetY,
			::Const.Tactical.Settings.SkillOverlayScale, ::Const.Tactical.Settings.SkillOverlayScale,
			::Const.Tactical.Settings.SkillOverlayStayDuration, 0, ::Const.Tactical.Settings.SkillOverlayFadeDuration
		);
		_info.Skill.spawnAttackEffect(_info.Attacker.getTile(), ::Const.Tactical.AttackEffectSlash);
		::Tactical.getShaker().cancel(_info.Attacker);
		::Tactical.getShaker().shake(_info.Attacker, _info.Actor.getTile(), 2);
		local sound = ::Const.Sound.getParrySoundByWeaponType(_info.Skill);
		// this.Sound.play("sounds/combat/legend_parried_01.wav", ::Const.Sound.Volume.Skill, _info.Actor.getPos())
		this.Sound.play(sound, ::Const.Sound.Volume.Skill, _info.Actor.getPos());
		::Legends.Effects.grant(_info.Attacker, ::Legends.Effect.LegendParried);
		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_info.Attacker) + " is Vulnerable");
		// Attempt to perform a Riposte after the Parry (with a delay so that it only begins after the Parry animation is finished)
		this.onBeforeRiposte(_info.Attacker, _info.Skill, 1.5);
	}

	// Preparation to call onRiposte(). Given its own function so it can be easily reused
	o.onBeforeRiposte <- function ( _attacker, _skill, _delayMultiplier=1 )
	{
		if (this.m.CurrentProperties.IsRiposting && _attacker != null && !_attacker.isAlliedWith(this) && _attacker.getTile().getDistanceTo(this.getTile()) == 1 && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID() && _skill != null && !_skill.isIgnoringRiposte())
		{
			local skill = this.m.Skills.getAttackOfOpportunity();

			if (skill != null)
			{
				local info = {
					User = this,
					Skill = skill,
					TargetTile = _attacker.getTile()
				};
				this.Time.scheduleEvent(this.TimeUnit.Virtual, ::Const.Combat.RiposteDelay * _delayMultiplier, this.onRiposte.bindenv(this), info);
			}

			this.getFlags().set("PerformedRiposte", true);
		}
	}

	o.resetPerks <- function ()
	{
		local perks =  0;

		// Get all items that are adding skills to this character and unequip them to remove those skills
		// Necessary, as some items may add perks
		local items = this.getItems().getAllItems().filter(@(idx, item) item.getSkills().len() != 0);
		foreach (item in items)
		{
			this.getItems().unequip(item);
		}

		local skills = this.getSkills();

		foreach( skill in skills.m.Skills)
		{
			if (!skill.isGarbage() && skill.m.IsSerialized && skill.isType(this.Const.SkillType.Perk) && !skill.isType(this.Const.SkillType.Racial))
			{
				perks += 1;
			}
		}

		perks += this.m.PerkPoints;
		this.logDebug("perks before: "+ perks);
		local hasStudent = false;
		local hasGifted = false;
		local hasAdaptive = false;

		if (this.getLevel() >= 12 && this.getSkills().hasPerk(::Legends.Perk.Student))
		{
			perks = perks - 1;
			hasStudent = true;
		}
		if (this.getSkills().hasPerk(::Legends.Perk.Gifted))
		{
			perks = perks - 1;
			hasGifted = true;
		}
		if (this.getSkills().hasPerk(::Legends.Perk.LegendAdaptive))
		{
			perks = perks - 1;
			hasAdaptive = true;
		}

		local nonRefundable = [];
		foreach (row in this.getBackground().m.PerkTree)
		{
			foreach (perk in row)
			{
				if (!perk.IsRefundable)
				{
					this.logInfo(perk.ID + " is non refundable");
					nonRefundable.push(perk.ID);
				}
			}
		}

		this.m.PerkPoints = 0;
		this.m.PerkPointsSpent = 0;

		local skillsToRemove = this.getSkills().getSkillsByFunction(@(_skill) _skill.isType(this.Const.SkillType.Perk) && _skill.m.IsSerialized && nonRefundable.find(_skill.getID()) == null);
		foreach (s in skillsToRemove)
		{
			this.getSkills().removeByID(s.getID());
		}

		perks -= nonRefundable.len();

		this.m.PerkPoints = perks;

		if (hasStudent)
		{
			this.m.PerkPointsSpent += 1;
			::Legends.Perks.grant(this, ::Legends.Perk.Student);
		}

		if (hasGifted)
		{
			this.m.PerkPointsSpent += 1;
			::Legends.Perks.grant(this, ::Legends.Perk.Gifted, function (_perk) {
				_perk.m.IsApplied = true;
			}.bindenv(this));
		}

		if (hasAdaptive)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAdaptive, function (_perk) {
				_perk.m.IsNew = true;
			}.bindenv(this));
			if (this.getLevel() >= 15)
				this.m.PerkPointsSpent += 1;
		}

		foreach (item in items)
		{
			this.getItems().equip(item);
		}
	}

	local onAppearanceChanged = o.onAppearanceChanged;
	o.onAppearanceChanged = function( _appearance, _setDirty = true )
	{
		if (!isAlive() || isDying()) return;

		foreach(key, id in ::Const.LegendOnAppearanceChangedSprites.Helmet) // for layered helmet
		{
			if (!hasSprite(id))
				continue;

			if (_appearance[key].len() != 0 && !m.IsHidingHelmet) {
				local helmet = getSprite(id);
				helmet.setBrush(_appearance[key]);
				helmet.Color = _appearance.HelmetColor;
				helmet.Visible = true;
			}
			else {
				getSprite(id).Visible = false;
			}
		}

		foreach(key, id in ::Const.LegendOnAppearanceChangedSprites.Armor) // for layered armor
		{
			if (!hasSprite(id))
				continue;

			if (_appearance[key].len() != 0) {
				local helmet = getSprite(id);
				helmet.setBrush(_appearance[key]);
				helmet.Visible = true;
			}
			else {
				getSprite(id).Visible = false;
			}
		}

		if (hasSprite("permanent_injury_scarred"))
			getSprite("permanent_injury_scarred").Visible = !_appearance.HideHead;

		if (hasSprite("permanent_injury_burned"))
			getSprite("permanent_injury_burned").Visible = !_appearance.HideHead;

		onAppearanceChanged(_appearance, _setDirty);
	}

	local setHitpoints = o.setHitpoints;
	o.setHitpoints = function( _h )
	{
		local healGoal = _h + m.HealRemainder;
		local healTick = ::Math.floor(healGoal);
		m.HealRemainder = healGoal - healTick;
		setHitpoints(healTick);
	}

	o.removeArmorUpgrade <- function ( _slot, _item)
	{
		local armor = this.getItems().getItemAtSlot(_slot);
		if (armor == null)
		{
			return null;
		}

		return armor.removeUpgrade( _item );
	}

	o.setRiderID <- function ( _id)
	{
		if (_id == null)
		{
			_id = ""
		}
		this.m.RiderID = _id;
	}

	o.getRiderID <- function()
	{
		return this.m.RiderID
	}

	o.getRider <- function()
	{
		return null;
	}

	// o.getCompanyID <- function()
	// {
	// 	return -1;
	// }

	o.setTarget <- function (_entity)
	{
		if (this.m.AIAgent == null) return;

		this.m.AIAgent.setPriorityTarget(_entity);
	}

	o.TherianthropeInfection <- function (_killer)
	{
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function ()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.OnDeathLootTable.extend([
				[5, "scripts/items/misc/legend_masterwork_fabric"],
				[5, "scripts/items/misc/legend_masterwork_metal"],
				[5, "scripts/items/misc/legend_masterwork_tools"]
			]);
		}
		return ret;
	}

	local isReallyKilled = o.isReallyKilled;
	o.isReallyKilled = function( _fatalityType )
	{
		local ret = isReallyKilled(_fatalityType);
		if (!ret) TherianthropeInfection(_killer);
		return ret;
	}

	local getSurroundedCount = o.getSurroundedCount;
	o.getSurroundedCount = function ()
	{
		return !this.isPlacedOnMap() ? 0 : getSurroundedCount();
	}

	o.setBrushAlpha <- function(level)
	{
	}

	local onDamageReceived = o.onDamageReceived;
	o.onDamageReceived = function( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyDamageMultBeforeSteelBrow = _hitInfo.BodyDamageMult;
		local ret = onDamageReceived(_attacker, _skill, _hitInfo);
		this.m.HitInfo = _hitInfo; // save hitInfo for later use
		return ret;
	}

	local getLootForTile = o.getLootForTile;
	o.getLootForTile = function (_killer, _loot) {
		if (!(_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals))
			return getLootForTile(_killer, _loot);

		foreach (entry in this.m.OnDeathLootTable) {
			if (entry[0] == 0) { // no division by zero!
				::logError("division by zero, skipping " + entry[1]);
				continue;
			}
			local chance = entry[0];
			if (chance < 0.005)
				chance = 0.005; // limited by 16 bit rand
			if (chance > 100)
				chance = 100;
			if (chance < 10 ? ::Math.rand(1, ::Math.round(100 / chance)) == 1 : Math.rand(1, 100) <= ::Math.round(chance)) {
				if (typeof(entry[1]) == "function") {
					_loot.push(entry[1]());
				} else {
					_loot.push(::new(entry[1]));
				}
			}
		}

		return getLootForTile(_killer, _loot);
	}


	local onSerialize = o.onSerialize;
	o.onSerialize = function( _out )
	{
		onSerialize(_out);
		_out.writeString(this.m.RiderID);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function( _in )
	{
		onDeserialize(_in);
		this.m.RiderID = _in.readString();
	}

	local onMovementStart = o.onMovementStart;
	o.onMovementStart = function(_tile, _numTiles)
	{
		local oldID = ::Const.Movement.HiddenStatusEffectID;
		::Const.Movement.HiddenStatusEffectID = "effects.lol_nothing"; //necro encouraged this
		onMovementStart(_tile, _numTiles);
		::Const.Movement.HiddenStatusEffectID = oldID;
	}

	local kill = o.kill;
	o.kill = function (_killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false) {
		if (!this.isHiddenToPlayer() && this.m.HitInfo)
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + "\'s " + this.Const.Strings.BodyPartName[this.m.HitInfo.BodyPart] + " is hit for [b]" + this.Math.floor(this.m.HitInfo.DamageInflictedHitpoints) + "[/b] damage");

		this.m.HitInfo = null; // yeet hit info that was saved earlier
		if (this.getFlags().has("tail")) // ignore killer when is tail
			kill(null, _skill, _fatalityType, _silent);
		else
			kill(_killer, _skill, _fatalityType, _silent);
	}

	local onDeath = o.onDeath;
	o.onDeath = function(_killer, _skill, _tile, _fatalityType) {
		if (this.getFlags().has("tail")) // ignore killer when is tail
			onDeath(null, _skill, _tile, _fatalityType);
		else
			onDeath(_killer, _skill, _tile, _fatalityType);


		// Drops net if net flags are met. It should be used in dropLoot to free space here
		if (this.getFlags().get("DropNet")){
			local net;

			if (this.getFlags().get("IsReinforcedNet"))
				net = this.new("scripts/items/tools/reinforced_throwing_net");
			else
				net = this.new("scripts/items/tools/throwing_net");

			if (!this.getFlags().get("IsByNetCasting")){
				net.m.Ammo = 0;
				net.updateAmmo();
			}

			if (net != null){
				if (net.drop(this.getTile())) {// drops the net on the tile
					::Tactical.Entities.addNetTiles(this.getTile());
				}
			}

			this.getFlags().remove("DropNet");
   			this.getFlags().remove("IsReinforcedNet");
    		this.getFlags().remove("IsByNetCasting");
		}
	}
});
