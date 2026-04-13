this.legend_magic_burning_hands <- this.inherit("scripts/skills/actives/legend_magic_attack_skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},

	function create() {
		this.legend_magic_attack.create();

		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicBurningHands);
		this.m.Description = "Unleash a cone of blistering heat from your palms.";
		this.m.KilledString = "Burned";
		this.m.Icon = "skills/burning_hands_01.png";
		this.m.IconDisabled = "skills/burning_hands_01_bw.png";
		this.m.Overlay = "mage_legend_magic_burning_hands_square";
		this.m.SoundOnUse = [
			"sounds/combat/fire_01.wav",
			"sounds/combat/fire_02.wav",
			"sounds/combat/fire_03.wav",
			"sounds/combat/fire_04.wav",
			"sounds/combat/fire_05.wav",
			"sounds/combat/fire_06.wav"
		];
		this.m.SoundOnHit = [
			"sounds/humans/0/human_light_01.wav",
			"sounds/humans/0/human_light_02.wav",
			"sounds/humans/0/human_light_03.wav",
			"sounds/humans/0/human_light_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+1;
		this.m.Delay = 1000;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsDoingForwardMove = false;
		//halved AP allows a choice between a puff or sustained application
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 60;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 8;

		this.m.DirectDamageMult = 0.3;
		this.m.DamageArmorMult = 0.7;
		this.m.ResolveScaling = 2;
		//looks small, but its balanced around fire lance which can do 80-120 if it hits both targets, this can do 90-135 damage to a group.
		this.m.BaseDamageRegularMin = 10;
		this.m.BaseDamageRegularMax = 15;
	}

	function onUpdate( _properties )
	{
		this.applyPerks();
	}

	function applyPerks() {
		if (this.m.Container.hasPerk(::Legends.Perk.LegendMasteryBurningHands))
		{
			//doubles total output
			this.m.BaseDamageRegularMin = 20;
			this.m.BaseDamageRegularMax = 30;
		}
	}

	function isUsableOn( _targetTile, _userTile = null )
	{
		if (!this.isAffordable() || !this.isUsable())
		{
			return false;
		}

		local user = this.m.Container.getActor();

		if (_userTile == null)
		{
			_userTile = user.getTile();
		}

		local d = _userTile.getDistanceTo(_targetTile);

		if (d < this.m.MinRange || d > this.getMaxRange())
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local d = _originTile.getDistanceTo(_targetTile);

		if (d < this.m.MinRange || d > this.getMaxRange())
		{
			return false;
		}

		return true;
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [];
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		// Cone type 1 means 1 adjacent tile hit
		// Cone type 2 means 2 adjacent tiles hit
		local coneType = 0;

		if (ownTile.hasNextTile(dir))
		{
			local adjacentTile = ownTile.getNextTile(dir);
			local secondTile = adjacentTile.getNextTile(dir);
			// Whether the secondTile is the same as the targeted tile
			local sameTile = ((secondTile.Pos.X == _targetTile.Pos.X) && (secondTile.Pos.Y == _targetTile.Pos.Y));
			coneType = sameTile ? 1 : 2;
		}
		else {
			// This is a literal edge case at the bottom or top of the map,
			// but we should be able to handle it with cone type 2.
			coneType = 2;
		}

		if (coneType == 1)
		{
			ret = this.getAffectedConeOne(dir, ownTile, _targetTile);
		}
		if (coneType == 2)
		{
			ret = this.getAffectedConeTwo(dir, ownTile, _targetTile);
		}
		return ret;
	}

	function getAffectedConeOne( _dir, _ownTile, _targetTile )
	{
		// 1 adjacent tile hit
		local ret = [];
		local left = _dir - 1 < 0 ? 5 : _dir - 1;
		local right = _dir + 1 > 5 ? 0 : _dir + 1;

		local forwardTile = _ownTile;
		local currentTile = forwardTile;

		local adjacentTile = _ownTile.getNextTile(_dir);

		for(local forward = 0; forward < 3; forward++) {

			if (forwardTile.hasNextTile(_dir))
			{
				forwardTile = forwardTile.getNextTile(_dir);

				// Uncomment to allow targetting the adjacent tile
				ret.push(forwardTile);

				// // Uncomment to not put in the adjacent tile
				// local sameTile = ((forwardTile.Pos.X == adjacentTile.Pos.X) && (forwardTile.Pos.Y == adjacentTile.Pos.Y));
				// if (!sameTile)
				// {
				// 	ret.push(forwardTile);
				// }

			}
			else
			{
				break;
			}

			currentTile = forwardTile;
			for (local i = 0; i < 2 - forward; i++) {
				if (currentTile.hasNextTile(right))
				{
					currentTile = currentTile.getNextTile(right);
					ret.push(currentTile);
				}
				else
				{
					break;
				}
			}

			currentTile = forwardTile;
			for(local j = 0; j < 2 - forward; j++) {
				if (currentTile.hasNextTile(left))
				{
					currentTile = currentTile.getNextTile(left);
					ret.push(currentTile);
				}
				else
				{
					break;
				}
			}
		}
		return ret;
	}

	// 2 adjacent tiles hit
	function getAffectedConeTwo( _dir, _ownTile, _targetTile )
	{
		local ret = [];
		local left = _dir - 1 < 0 ? 5 : _dir - 1;
		local currentTile = _ownTile;

		// This is super hacky, but getDirectionTo() is weirdly inconsistent when
		// not getting the direction of two tiles that are a straight line apart.
		// Basically no touchy touchy please, unless you figure out how to fix it.
		if (currentTile.hasNextTile(_dir))
		{
			local targetTile = _ownTile.getNextTile(_dir);
			if (targetTile.hasNextTile(_dir))
			{
				targetTile = targetTile.getNextTile(left);
				local sameTile = ((targetTile.Pos.X == _targetTile.Pos.X) && (targetTile.Pos.Y == _targetTile.Pos.Y));
				if (!sameTile)
				{
					_dir = _dir + 1 > 5 ? 0 : _dir + 1;
					left = _dir - 1 < 0 ? 5 : _dir - 1;
				}
			}
		}

		local leftTwo = left - 1 < 0 ? 5 : left - 1;
		local right = _dir + 1 > 5 ? 0 : _dir + 1;

		// Uncomment to allow hitting the two adjacent tiles.
		// range 1
		if (currentTile.hasNextTile(left))
		{
			ret.push(currentTile.getNextTile(left));
		}
		if (currentTile.hasNextTile(_dir))
		{
			ret.push(currentTile.getNextTile(_dir));
		}

		// range 2
		ret.push(_targetTile);

		if (_targetTile.hasNextTile(leftTwo))
		{
			ret.push(_targetTile.getNextTile(leftTwo));
		}
		if (_targetTile.hasNextTile(right))
		{
			ret.push(_targetTile.getNextTile(right));
		}

		// range 3
		if (_targetTile.hasNextTile(left))
		{
			currentTile = _targetTile.getNextTile(left);
			ret.push(currentTile);

			if (currentTile.hasNextTile(leftTwo))
			{
				currentTile = currentTile.getNextTile(leftTwo);
				ret.push(currentTile);
			}
		}
		if (_targetTile.hasNextTile(_dir)) {
			currentTile = _targetTile.getNextTile(_dir);
			ret.push(currentTile);

			if (currentTile.hasNextTile(right))
			{
				currentTile = currentTile.getNextTile(right);
				ret.push(currentTile);
			}
		}

		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local affectedTiles = this.getAffectedTiles(_targetTile);

		foreach( t in affectedTiles )
		{
			this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.DamageTotalMult;

		this.setDamage();
		local damages = this.getDamageRange();

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts [color=%damage%]" + damages[0] + "[/color] - [color=%damage%]" + damages[1] + "[/color] damage, up to [color=%damage%]" + damages[4] + "[/color] damage can ignore armor"
		});

		if (damages[3] > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=%damage%]" + damages[2] + "[/color] - [color=%damage%]" + damages[3] + "[/color] armor damage"
			});
		}

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Hits a cone of range 3, or up to 9 tiles in total. Usable in melee"
			}
		]);
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "Accuracy based on ranged skill, damage based on current resolve. Requires a magic staff"
		});
		return ret;
	}

	// Overrides legend_magic_skill.isUsable() to allow use in melee.
	function isUsable()
	{
		if (!this.getContainer().getActor().isArmedWithMagicStaff())
		{
			return false;
		}

		return !this.Tactical.isActive() || this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		// this.Sound.play(this.m.SoundOnFire[this.Math.rand(0, this.m.SoundOnFire.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, _user.getPos());

		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, this.onDelayedEffect.bindenv(this), tag);

		return true;
	}

	function onDelayedEffect( _tag )
	{
		local affectedTiles = this.getAffectedTiles(_tag.TargetTile);

		local tag = {
			Skill = _tag.Skill,
			User = _tag.User,
			Targets = affectedTiles
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, this.applyEffectToTargets.bindenv(this), tag);
	}

	function applyEffectToTargets( _tag )
	{
		local user = _tag.User;
		local targets = _tag.Targets;
		local attackSkill = user.getCurrentProperties().getRangedSkill();

		foreach( t in targets )
		{
			if (!t.IsOccupiedByActor || !t.getEntity().isAttackable())
			{
				continue;
			}

			local target = t.getEntity();
			local success = this.attackEntity(user, target, false);

			if (success)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, user.getPos());
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			this.setDamage();
			_properties.DamageRegularMin = this.m.DamageRegularMin;
			_properties.DamageRegularMax = this.m.DamageRegularMax;
			_properties.DamageArmorMult = this.m.DamageArmorMult;
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
