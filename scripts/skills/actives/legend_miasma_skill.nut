this.legend_miasma_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMiasma);
		this.m.Description = "Release a cloud of noxious gasses that affect living beings.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/miasma_spell", 3);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/humans/human_coughing", 4);
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 5;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 40;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 8;
	}

	function getTooltip()
	{
		return [
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
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Deals 5-10 damage per turn over four turns"
			}
		];
	}

	function isViableTarget( _user, _target )
	{
		if (_target.isAlliedWith(_user))
		{
			return false;
		}

		if (_target.getFlags().has("undead"))
		{
			return false;
		}

		if (_target.getTile().Properties.Effect != null)
		{
			return false;
		}

		return true;
	}

	function onUse(_user, _targetTile) {
		local targets = [_targetTile];
		targets.extend([0, 1, 2, 3, 4, 5].filter(@(_, _direction) _targetTile.hasNextTile(_direction)).map(@(_direction) _targetTile.getNextTile(_direction)));

		foreach (tile in targets) {
			::Tactical.State.spawnMiasmaOnTile(tile, _user);
		}

		return true;
	}
});
