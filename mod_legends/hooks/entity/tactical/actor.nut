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

	o.getGender <- function()
	{
		return -1;
	}

	local setCurrentMovementType = o.setCurrentMovementType;
	o.setCurrentMovementType = function( _t ) // to trigger the removal of stances skill upon being moved out of will
	{
		if (_t == ::Const.Tactical.MovementType.Involuntary && !::Tactical.TurnSequenceBar.isActiveEntity(this))
			::Const.Tactical.Common.removeStances(this);

		setCurrentMovementType(_t);
	}

	/*
	o.onRender <- function ()
	{
		if (this.m.IsLoweringWeapon)
		{
			local p = (this.Time.getVirtualTimeF() - this.m.RenderAnimationStartTime) / this.Const.Items.Default.LowerWeaponDuration;

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).m.ID == "weapon.legend_named_swordstaff" || this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).m.ID == "weapon.legend_swordstaff" || this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).m.ID == "weapon.legend_mage_swordstaff")
			{
				this.getSprite("arms_icon").Rotation = this.Math.minf(1.0, p) * -70.0;
				this.moveSpriteOffset("arms_icon", this.getSpriteOffset("arms_icon"), this.createVec(46 * this.Math.minf(1.0, p), -33 * this.Math.minf(1.0, p)), this.Const.Items.Default.LowerWeaponDuration, this.m.RenderAnimationStartTime);
			}
			else if (this.m.Items.getAppearance().TwoHanded)
			{
				this.getSprite("arms_icon").Rotation = this.Math.minf(1.0, p) * -70.0;
			}
			else
			{
				this.getSprite("arms_icon").Rotation = this.Math.minf(1.0, p) * -33.0;
			}

			if (p >= 1.0)
			{
				this.m.IsLoweringWeapon = false;

				if (!this.m.IsUsingCustomRendering)
				{
					this.setRenderCallbackEnabled(false);
				}
			}
		}
		else if (this.m.IsRaisingWeapon)
		{
			local p = (this.Time.getVirtualTimeF() - this.m.RenderAnimationStartTime) / this.Const.Items.Default.RaiseWeaponDuration;

			if (this.getSpriteOffset("arms_icon").X != 0 || this.getSpriteOffset("arms_icon").Y != 0)
			{
				this.getSprite("arms_icon").Rotation = (1.0 - this.Math.minf(1.0, p)) * -70.0;
				this.moveSpriteOffset("arms_icon", this.getSpriteOffset("arms_icon"), this.createVec(46 * (1-this.Math.minf(1.0, p)), -33 * (1-this.Math.minf(1.0, p))), this.Const.Items.Default.LowerWeaponDuration, this.m.RenderAnimationStartTime);
				//this.logDebug("hey there calls");
			}
			else if (this.m.Items.getAppearance().TwoHanded)
			{
				this.getSprite("arms_icon").Rotation = (1.0 - this.Math.minf(1.0, p)) * -70.0;
			}
			else
			{
				this.getSprite("arms_icon").Rotation = (1.0 - this.Math.minf(1.0, p)) * -33.0;
			}

			if (p >= 1.0)
			{
				this.m.IsRaisingWeapon = false;

				if (!this.m.IsUsingCustomRendering)
				{
					this.setRenderCallbackEnabled(false);
				}
			}
		}
	}
	*/

	local onRender = o.onRender;
	o.onRender = function()
	{
		local isLoweringWeapon = false;
		local isRaisingWeapon = false;

		if (m.IsLoweringWeapon) {
			local mainhand = getMainhandItem();
			isLoweringWeapon = mainhand != null && ::Const.Items.LegendItemWithSpearwall.find(mainhand.getID()) != null;
			m.IsLoweringWeapon = false;
		}
		else if (m.IsRaisingWeapon) {
			isRaisingWeapon = this.getSpriteOffset("arms_icon").X != 0 || this.getSpriteOffset("arms_icon").Y != 0;
			m.IsRaisingWeapon = false;
		}

		onRender();

		if (isLoweringWeapon) {
			local p = (this.Time.getVirtualTimeF() - this.m.RenderAnimationStartTime) / this.Const.Items.Default.LowerWeaponDuration;
			this.getSprite("arms_icon").Rotation = this.Math.minf(1.0, p) * -70.0;
			this.moveSpriteOffset("arms_icon", this.getSpriteOffset("arms_icon"), this.createVec(46 * this.Math.minf(1.0, p), -33 * this.Math.minf(1.0, p)), this.Const.Items.Default.LowerWeaponDuration, this.m.RenderAnimationStartTime);

			if (p >= 1.0) {
				this.m.IsLoweringWeapon = false;

				if (!this.m.IsUsingCustomRendering)
					this.setRenderCallbackEnabled(false);
			}
			else {
				this.m.IsLoweringWeapon = true;
			}
		}
		else if (isRaisingWeapon) {
			local p = (this.Time.getVirtualTimeF() - this.m.RenderAnimationStartTime) / this.Const.Items.Default.RaiseWeaponDuration;
			this.getSprite("arms_icon").Rotation = (1.0 - this.Math.minf(1.0, p)) * -70.0;
			this.moveSpriteOffset("arms_icon", this.getSpriteOffset("arms_icon"), this.createVec(46 * (1-this.Math.minf(1.0, p)), -33 * (1-this.Math.minf(1.0, p))), this.Const.Items.Default.LowerWeaponDuration, this.m.RenderAnimationStartTime);

			if (p >= 1.0) {
				this.m.IsRaisingWeapon = false;

				if (!this.m.IsUsingCustomRendering)
					this.setRenderCallbackEnabled(false);
			}
			else{
				this.m.IsRaisingWeapon = true;
			}
		}
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
		local isAliedPtrs = []
		foreach(i, actor in otherActors) {
			isAliedPtrs.push(actor.isAlliedWith);
			actor.isAlliedWith = function(_other) {
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
		foreach (i, actor in otherActors)
			actor.isAlliedWith = isAliedPtrs[i];
		this.checkMorale = fnPtr;

		this.m.Skills.MovementCompleted(_tile);
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
		local isParrying = false, validAttackerToParry = _attacker != null && _attacker.isAlive() && !_attacker.isAlliedWith(this) && _attacker.getTile().getDistanceTo(this.getTile()) == 1 && ::Tactical.TurnSequenceBar.getActiveEntity() != null && ::Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID();
		local validSkillToParry = _skill != null && !_skill.isIgnoringRiposte() && _skill.m.IsWeaponSkill;

		if (getCurrentProperties().IsParrying && !getCurrentProperties().IsStunned && validAttackerToParry && validSkillToParry && !_attacker.getCurrentProperties().IsImmuneToDisarm && !_attacker.getSkills().hasEffect(::Legends.Effect.LegendParried)) {
			if (isHiddenToPlayer()) {
				::Legends.Effects.grant(_attacker, ::Legends.Effect.LegendParried);
				this.onBeforeRiposte(_attacker, _skill);
			}
			else {
				isParrying = true;
				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay * 1.5, onParryVisible.bindenv(this), {
					Actor = this,
					Attacker = _attacker,
					Skill = _skill
				});
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this) + " Parries the attack from " + ::Const.UI.getColorizedEntityName(_attacker));
		}
		else
		{
			this.onBeforeRiposte(_attacker,_skill);
		}

		if (isParrying) m.CurrentProperties.IsRiposting = false;
		onMissed(_attacker, _skill, _dontShake);
	}

	o.onParryVisible <- function ( _info )
	{
		// Animate and provide sound effects for the Parry, and apply the Vulnerable effect
		this.Tactical.spawnSpriteEffect("en_garde_square", this.createColor("#ffffff"), _info.Actor.getTile(), this.Const.Tactical.Settings.SkillOverlayOffsetX, this.Const.Tactical.Settings.SkillOverlayOffsetY, this.Const.Tactical.Settings.SkillOverlayScale, this.Const.Tactical.Settings.SkillOverlayScale, this.Const.Tactical.Settings.SkillOverlayStayDuration, 0, this.Const.Tactical.Settings.SkillOverlayFadeDuration);
		_info.Skill.spawnAttackEffect(_info.Attacker.getTile(), this.Const.Tactical.AttackEffectSlash);
		this.Tactical.getShaker().cancel(_info.Attacker);
		this.Tactical.getShaker().shake(_info.Attacker, _info.Actor.getTile(), 2);
		local sound = this.Const.Sound.getParrySoundByWeaponType(_info.Skill);
		// this.Sound.play("sounds/combat/legend_parried_01.wav", this.Const.Sound.Volume.Skill, _info.Actor.getPos())
		this.Sound.play(sound, this.Const.Sound.Volume.Skill, _info.Actor.getPos());
		::Legends.Effects.grant(_info.Attacker, ::Legends.Effect.LegendParried);
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_info.Attacker) + " is Vulnerable");
		// Attempt to perform a Riposte after the Parry (with a delay so that it only begins after the Parry animation is finished)
		this.onBeforeRiposte(_info.Attacker,_info.Skill,1.5);
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
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.Const.Combat.RiposteDelay * _delayMultiplier, this.onRiposte.bindenv(this), info);
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

		// Witch gets
		// todo delete it - chopeks
//		if (this.getBackground().getID() == "background.legend_witch" && this.LegendsMod.Configs().LegendMagicEnabled())
//		{
//			::Legends.Perks.grant(this, ::Legends.Perk.LegendMagicMissile);
//			perks = perks - 1;
//		}

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
		return onDamageReceived(_attacker, _skill, _hitInfo);
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
	}

	// local onResurrected = o.onResurrected;
	// o.onResurrected = function ( _info )
	// {
	//	 onResurrected(_info);
	//	 this.World.getPlayerRoster().add(_info);
	// }
	// local onInit = o.onInit;
	// o.onInit = function ()
	// {
	//	 o.onInit();
	//	 o.m.BloodSaturation = 1.5;
	//	 o.m.DeathBloodAmount = 1.5;
	//	 o.m.BloodPoolScale = 1.25;
	//	 o.m.BloodSplatterOffset = this.createVec(-1, -1);
	// }
	// }
});
