this.legend_firefield_skill <- this.inherit("scripts/skills/skill", {
	m = {
		FireDuration = 3
	},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFirefield);
		this.m.Description = "Unleash a raging inferno at the target location that burns all beings, damaging them twice.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/fire", 6);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/humans/0/human_light", 4);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted + 10;
		this.m.Delay = 0;
		this.m.IsTargetingActor = false;
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
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 50;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 6;
	}

	function getTooltip() {
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]" + this.getMaxRange() + "[/color] tiles on even ground"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts an additional [color=%damage%]15[/color] - [color=%damage%]30[/color] damage per turn for three turns across six tiles. Burns allies. Requires a staff"
			}
		]);
		return ret;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			return false;
		}

		if (_originTile.Level + 1 < _targetTile.Level) {
			return false;
		}

		return true;
	}

	function onTargetSelected(_targetTile) {
		local affectedTiles = [];
		affectedTiles.push(_targetTile);

		for (local i = 0; i != 6; i = ++i) {
			if (!_targetTile.hasNextTile(i)) {
			} else {
				local tile = _targetTile.getNextTile(i);
				affectedTiles.push(tile);
			}
		}

		foreach (t in affectedTiles) {
			::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
	}

	function onAfterUpdate(_properties) {
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		if (!actor.isArmedWithMagicStaff()) {
			return false;
		}

		return !::Tactical.isActive() || this.skill.isUsable() && !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions());
	}

	function onUse(_user, _targetTile) {
		local targets = [_targetTile];
		targets.extend([0, 1, 2, 3, 4, 5].filter(@(_, _direction) _targetTile.hasNextTile(_direction)).map(@(_direction) _targetTile.getNextTile(_direction)));

		foreach (tile in targets) {
			::Tactical.State.spawnFireFirefieldOnTile(tile, _user, true, this.m.FireDuration);
		}

		return true;
	}
});
