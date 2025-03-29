this.legend_alp_summon_nightmare_skill <- this.inherit("scripts/skills/skill", {
	m = {
		MinionIDs = [],
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendAlpSummonNightmare);
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
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 25;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.MaxLevelDifference = 4;
	}

	function onTurnStart()
	{
		local new = [];

		foreach(id in this.m.MinionIDs)
		{
			if (this.Tactical.getEntityByID(id) == null)
				continue;

			new.push(id);
		}

		this.m.MinionIDs = new;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.MinionIDs.len() <= 1;
	}

	function onUpdate( _properties )
	{
		if (this.Tactical.isActive())
			return;

		if (this.Time.getRound() >= 1)
			return;

		_properties.Vision -= 6;
	}

	function onUse( _user, _targetTile )
	{
		local potential = this.getAvailableTiles(_user.getTile());
		local num = ::Math.min(3 - this.m.MinionIDs.len(), potential.len());

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

				this.m.MinionIDs.push(nightmare.getID());
			//}.bindenv(this), _user);
		}

		if (!_user.isHiddenToPlayer() && !_targetTile.getEntity().isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " creates monsters from the shadow");

		return true;
	}

	function getAvailableTiles( _targetTile )
	{
		return this.getContainer().getActor().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault).queryDestinationsInRange(_targetTile, 1, 2);
	}

});

