this.legend_alp_nightmare_manifestation_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendAlpNightmareManifestation);
		this.m.Description = "";
		this.m.Icon = "skills/active_160.png";
		this.m.IconDisabled = "skills/active_160.png";
		this.m.Overlay = "active_160";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/alp_nightmare_01.wav",
			"sounds/enemies/dlc2/alp_nightmare_02.wav",
			"sounds/enemies/dlc2/alp_nightmare_03.wav",
			"sounds/enemies/dlc2/alp_nightmare_04.wav",
			"sounds/enemies/dlc2/alp_nightmare_05.wav",
			"sounds/enemies/dlc2/alp_nightmare_06.wav"
		];
		this.m.IsUsingActorPitch = true;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 400;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
		this.m.MinRange = 3;
		this.m.MaxRange = 10;
		this.m.MaxLevelDifference = 4;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}

		local b = this.getContainer().getActor().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault);
		local targets = b.queryTargetsInMeleeRange(this.getMinRange(), this.getMaxRange());
		local myTile = this.getContainer().getActor().getTile();

		foreach( t in targets )
		{
			if (this.onVerifyTarget(myTile, t.getTile()))
			{
				return true;
			}
		}

		return false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.getEntity().getSkills().hasEffect(::Legends.Effect.Sleeping))
			return false;

		if (this.getAvailableTiles(_targetTile).len() <= 1)
			return false;

		return this.skill.onVerifyTarget(_originTile, _targetTile);
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};

		local potential = this.getAvailableTiles(_targetTile);
		local num = ::Math.min(3, potential.len());

		for (local i = 0; i < num; ++i)
		{
			local tile = potential.remove(::Math.rand(0, potential.len() - 1));
			local type = ::MSU.Array.rand(["direwolf","human","serpent","tentacle"]);

			//this.Time.scheduleEvent(this.TimeUnit.Virtual, 100 * i, function(_a) {
				local nightmare = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_alp_nightmare_" + type, tile.Coords.X, tile.Coords.Y);
				nightmare.setFaction(_user.getFaction());
				nightmare.spawnSpecialEffect(tile);
				nightmare.assignRandomEquipment();
				nightmare.setMaster(_user);
			//}.bindenv(this), _user);
		}

		if (!_user.isHiddenToPlayer() && !_targetTile.getEntity().isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s nightmare becomes real!");

		if (_targetTile.IsVisibleForPlayer || !_user.isHiddenToPlayer())
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, this.onDelayedEffect.bindenv(this), tag);
		else
			this.onDelayedEffect(tag);

		return true;
	}

	function getAvailableTiles( _targetTile )
	{
		return this.getContainer().getActor().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault).queryDestinationsInRange(_targetTile, 1, 2);
	}

	function onDelayedEffect( _tag )
	{
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = 5;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		_tag.TargetTile.getEntity().onDamageReceived(_tag.User, this, hitInfo);
	}

});

