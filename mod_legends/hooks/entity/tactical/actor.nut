::mods_hookExactClass("entity/tactical/actor", function(o)
{
//	while(!("BloodSaturation" in o.m)) o = o[o.SuperName];

	o.m.BloodSaturation = 1.5;
	o.m.DeathBloodAmount = 1.5;
	o.m.BloodPoolScale = 1.25;
	o.m.HealRemainder <- 0.0;
	o.m.RiderID <- "";

	o.onRender <- function ()
	{
		if (this.m.IsRaisingShield)
		{
			if (this.moveSpriteOffset("shield_icon", this.createVec(0, 0), this.Const.Items.Default.RaiseShieldOffset, this.Const.Items.Default.RaiseShieldDuration, this.m.RenderAnimationStartTime))
			{
				this.m.IsRaisingShield = false;

				if (!this.m.IsUsingCustomRendering)
				{
					this.setRenderCallbackEnabled(false);
				}
			}
		}
		else if (this.m.IsLoweringShield)
		{
			if (this.moveSpriteOffset("shield_icon", this.Const.Items.Default.RaiseShieldOffset, this.createVec(0, 0), this.Const.Items.Default.LowerShieldDuration, this.m.RenderAnimationStartTime))
			{
				this.m.IsLoweringShield = false;

				if (!this.m.IsUsingCustomRendering)
				{
					this.setRenderCallbackEnabled(false);
				}
			}
		}

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

		if (this.m.IsRaising)
		{
			local p = (this.Time.getVirtualTimeF() - this.m.RenderAnimationStartTime) / (this.Const.Combat.ResurrectAnimationTime * this.m.RenderAnimationSpeed);

			if (p >= 1.0)
			{
				this.setPos(this.createVec(0, 0));
				this.setAlpha(255);
				this.m.IsRaising = false;
				this.m.IsAttackable = true;

				if (!this.m.IsUsingCustomRendering)
				{
					this.setRenderCallbackEnabled(false);
				}
			}
			else
			{
				this.setPos(this.createVec(0, this.Const.Combat.ResurrectAnimationDistance * this.m.RenderAnimationDistanceMult * (1.0 - p)));
			}
		}
		else if (this.m.IsSinking)
		{
			local p = (this.Time.getVirtualTimeF() - this.m.RenderAnimationStartTime) / (this.Const.Combat.ResurrectAnimationTime * this.m.RenderAnimationSpeed);

			if (p >= 1.0)
			{
				this.setPos(this.createVec(0, this.Const.Combat.ResurrectAnimationDistance * this.m.RenderAnimationDistanceMult));
				this.m.IsSinking = false;
				this.m.IsAttackable = true;

				if (!this.m.IsUsingCustomRendering)
				{
					this.setRenderCallbackEnabled(false);
				}
			}
			else
			{
				this.setPos(this.createVec(0, this.Const.Combat.ResurrectAnimationDistance * this.m.RenderAnimationDistanceMult * p));
			}
		}

		if (this.m.IsRaisingRooted)
		{
			local from = this.createVec(this.m.RenderAnimationOffset.X, this.m.RenderAnimationOffset.Y - 100);
			this.moveSpriteOffset("status_rooted_back", from, this.m.RenderAnimationOffset, this.Const.Combat.RootedAnimationTime, this.m.RenderAnimationStartTime);

			if (this.moveSpriteOffset("status_rooted", from, this.m.RenderAnimationOffset, this.Const.Combat.RootedAnimationTime, this.m.RenderAnimationStartTime))
			{
				this.m.IsRaisingRooted = false;

				if (!this.m.IsUsingCustomRendering)
				{
					this.setRenderCallbackEnabled(false);
				}

				this.setDirty(true);
			}
		}
	}

	o.getGender <- function()
	{
		return -1;
	}

	o.onOtherActorDeath <- function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		if (_victim.getXPValue() <= 0)
		{
			return;
		}

		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult > 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow);
			if (_killer != null)
			{
				difficulty = this.Math.floor((this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow)) * _killer.getPercentOnKillOtherActorModifier()) + _killer.getFlatOnKillOtherActorModifier();
			}
			this.checkMorale(-1, difficulty, this.Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null)
		{
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.EnemyKilledDistancePow);

			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
			{
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;
			}

			this.checkMorale(1, difficulty);
		}
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
		onMovementFinish(_tile);
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
		this.getItems().addToBag(_item);
	}

	o.setArmor <- function (_bodyPart, _value)
	{
		this.m.BaseProperties.Armor[_bodyPart] = _value;
	}

	o.getFatigueCosts = function ()
	{
		local c = clone this.m.FatigueCosts;

		for( local i = 0; i < c.len(); i = ++i )
		{
			c[i] = this.Math.round((c[i] + this.m.CurrentProperties.MovementFatigueCostAdditional) * this.m.CurrentProperties.MovementFatigueCostMult * this.m.CurrentProperties.FatigueEffectMult);
		}

		return c;
	}

	local onMissed = o.onMissed;
	o.onMissed = function ( _attacker, _skill, _dontShake = false )
	{
		// Attempt to Parry
		local isParrying = false, validAttackerToParry = _attacker != null && _attacker.isAlive() && !_attacker.isAlliedWith(this) && _attacker.getTile().getDistanceTo(this.getTile()) == 1 && ::Tactical.TurnSequenceBar.getActiveEntity() != null && ::Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID();
		local validSkillToParry = _skill != null && !_skill.isIgnoringRiposte() && _skill.m.IsWeaponSkill;

		if (getCurrentProperties().IsParrying && !getCurrentProperties().IsStunned && validAttackerToParry && validSkillToParry && !_attacker.getCurrentProperties().IsImmuneToDisarm && !_attacker.getSkills().hasSkill("effects.legend_parried")) {
			if (isHiddenToPlayer()) {
				_attacker.getSkills().add(::new("scripts/skills/effects/legend_parried_effect"));
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
		_info.Attacker.getSkills().add(this.new("scripts/skills/effects/legend_parried_effect"));
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_info.Attacker) + " is Vulnerable");
		// Attempt to perform a Riposte after the Parry (with a delay so that it only begins after the Parry animation is finished)
		this.onBeforeRiposte(_info.Attacker,_info.Skill,1.5);
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

		if (this.getLevel() >= 12 && this.getSkills().hasSkill("perk.student"))
		{
			perks = perks - 1;
			hasStudent = true;
		}
		if (this.getSkills().hasSkill("perk.gifted"))
		{
			perks = perks - 1;
			hasGifted = true;
		}
		if (this.getSkills().hasSkill("perk.legend_adaptive"))
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
//			this.getSkills().add(this.new("scripts/skills/perks/perk_legend_magic_missile"));
//			perks = perks - 1;
//		}

		this.m.PerkPoints = perks;

		if (hasStudent)
		{
			this.m.PerkPointsSpent += 1;
			this.getSkills().add(this.new("scripts/skills/perks/perk_student"));
		}

		if (hasGifted)
		{
			this.m.PerkPointsSpent += 1;
			local giftedPerk = this.new("scripts/skills/perks/perk_gifted");
			giftedPerk.m.IsApplied = true;
			this.getSkills().add(giftedPerk);
		}

		if (hasAdaptive)
		{
			local giftedPerk = this.new("scripts/skills/perks/perk_legend_adaptive");
			giftedPerk.m.IsNew = false;
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
