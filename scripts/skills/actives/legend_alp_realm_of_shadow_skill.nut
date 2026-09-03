this.legend_alp_realm_of_shadow_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendAlpRealmOfShadow);
		this.m.Description = "";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/miasma_spell", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 4;
	}

	function isViableTarget(_user, _target) {
		return _target.getTile().Properties.Effect == null;
	}

	function onUse(_user, _targetTile) {
		local targets = [_targetTile];
		targets.extend([0, 1, 2, 3, 4, 5].filter(@(_, _direction) _targetTile.hasNextTile(_direction)).map(@(_direction) _targetTile.getNextTile(_direction)));

		foreach (tile in targets) {
			::Tactical.State.spawnShadowMistOnTile(tile);
		}

		return true;
	}
});
