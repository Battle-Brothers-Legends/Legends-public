this.legend_magic_chain_lightning_skill <- this.inherit("scripts/skills/actives/legend_magic_attack_skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0,
		SuccessiveHitRatio = 0.8,
		SoundOnLightning = [
			"sounds/combat/dlc2/legendary_lightning_01.wav",
			"sounds/combat/dlc2/legendary_lightning_02.wav",
			"sounds/combat/electricity_01.wav",
			"sounds/combat/electricity_02.wav",
			"sounds/combat/electricity_03.wav",
			"sounds/combat/electricity_04.wav"
		]
	},

	function create() {
		this.legend_magic_attack.create();

		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicChainLightning);
		this.m.Description = "Fire a bolt of lightning at an enemy that can arc to two adjacent enemies.";
		this.m.KilledString = "Zapped";
		this.m.Icon = "skills/lightning_square.png";
		this.m.IconDisabled = "skills/lightning_square_bw.png";
		this.m.Overlay = "lightning_square";
		this.m.SoundOnUse = [
			"sounds/combat/lightning_01.wav",
			"sounds/combat/lightning_02.wav",
			"sounds/combat/lightning_03.wav",
			"sounds/combat/lightning_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/electricity_01.wav",
			"sounds/combat/electricity_02.wav",
			"sounds/combat/electricity_03.wav",
			"sounds/combat/electricity_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+1;
		this.m.Delay = 1000;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 60;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 8;
		this.m.ProjectileType = this.Const.ProjectileType.Missile;

		this.m.DirectDamageMult = 0.9;
		this.m.DamageArmorMult = 0.8;
		this.m.ResolveScaling = 2;
		this.m.BaseDamageRegularMin = 10;
		this.m.BaseDamageRegularMax = 30;
	}

	function onUpdate( _properties )
	{
		this.applyPerks();
	}

	function applyPerks() {
		if (this.m.Container.hasPerk(::Legends.Perk.LegendMasteryChainLightning))
		{
			this.m.AdditionalAccuracy = 10;
			this.m.MaxRange= 5;
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

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=%positive%] " + this.m.AdditionalAccuracy + "% [/color] chance to hit."
		});

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color] tiles on even ground, more if shooting downhill. Can hit up to three targets, doing less damage to each additional target beyond the first."
			}
		]);
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "Accuracy based on ranged skill, damage based on resolve. Requires a magic staff"
		});
		return ret;
	}

	function addResources()
	{
		foreach( r in this.m.SoundOnLightning )
		{
			this.Tactical.addResource(r);
		}
	}

	function chainAttack( _data)
	{
		local _user = _data.User;
		local _myTile = _data.MyTile;
		local _targetTile = _data.TargetTile;
		local _selectedTargets = _data.SelectedTargets;
		local _depth = _data.Depth;
		local _maxDepth = _data.MaxDepth;

		local isInitialTarget = (_depth == 0);
		local properties = _user.getCurrentProperties();

		if (isInitialTarget)
		{
			this.m.IsShowingProjectile = true;
		}
		else
		{
			this.m.IsShowingProjectile = false;
		}
		_selectedTargets.push(_targetTile.getEntity().getID());
		local success = this.attackEntity(_user, _targetTile.getEntity(), isInitialTarget);

		local effectData = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};

		this.applyEffect(effectData, 100);

		properties.DamageRegularMin = properties.DamageRegularMin * this.m.SuccessiveHitRatio;
		properties.DamageRegularMax = properties.DamageRegularMax * this.m.SuccessiveHitRatio;

		_user.setCurrentProperties(properties);

		this.logInfo("Damage Reduced.");

		if ((_depth < _maxDepth - 1) && success && _user.isAlive())
		{

			local potentialTiles = [];
			local targetTile = _targetTile;
			local target;

			for (local direction = 0; direction < 6; direction++)
			{
				if (targetTile.hasNextTile(direction))
				{
					local tile = targetTile.getNextTile(direction);

					local selectedIDs = [];

					if (tile.IsOccupiedByActor && tile.getEntity().isAttackable() && !tile.getEntity().isAlliedWith(_user) && _selectedTargets.find(tile.getEntity().getID()) == null)
					{
						potentialTiles.push(tile);
					}
				}
			}

			if (potentialTiles.len() > 0) {
				targetTile = potentialTiles[this.Math.rand(0, potentialTiles.len() - 1)];

				local data = {
					User = _user,
					MyTile = _myTile,
					TargetTile = targetTile,
					SelectedTargets = _selectedTargets,
					Depth = _depth + 1,
					MaxDepth = _maxDepth
				}
				this.chainAttack(data);
			}
		}
	}

	function onUse( _user, _targetTile )
	{

		local properties = _user.getCurrentProperties();
		this.logInfo("* Resetting damage");
		this.setDamage();
		properties.DamageRegularMin = this.m.DamageRegularMin;
		properties.DamageRegularMax = this.m.DamageRegularMax;
		properties.DamageArmorMult = this.m.DamageArmorMult;
		properties.RangedSkill += this.m.AdditionalAccuracy;
		properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

		local myTile = _user.getTile();
		local _data = {
			User = _user,
			MyTile = myTile,
			TargetTile = _targetTile,
			SelectedTargets = [],
			Depth = 0,
			MaxDepth = 5
		}
		this.chainAttack(_data);
	}

	function applyEffect(_data, _delay)
	{
		local i = 0;

		this.Time.scheduleEvent(this.TimeUnit.Virtual, _delay, function ( _data )
		{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, _data.TargetTile, this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
		}, _data);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
	}
});
