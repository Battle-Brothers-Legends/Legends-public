this.legend_holyflame_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHolyflame);
		this.m.Description = "Bless an area and apply hallowed ground over a 1-tile radius for " + ::Const.UI.getColorized("2", ::Const.UI.Color.PositiveValue) + " turns. The holy shall be sanctified when entering, the damned shall be consecrated.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/fire", 6);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
	}

	function getTooltip() {
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Allies gain the Sanctified effect, becoming immune to injuries, bleeding, poison, and morale checks when taking damage"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Undead and Cultists gain the Consecrated effect, dealing damage to them each turn and removing their immunity to injuries, bleeding, and being poisoned"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will remove [color=%status%]Battle Forged[/color] from Wichts"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Undead are unable to resurrect in the area while the flame is active"
			}
		]);

		return ret;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			return false;
		}

		return true;
	}

	function isUsable() {
		return !::Tactical.isActive() || this.skill.isUsable();
	}

	function onUse(_user, _targetTile) {
		local targets = [_targetTile];
		targets.extend([0, 1, 2, 3, 4, 5].filter(@(_, _direction) _targetTile.hasNextTile(_direction)).map(@(_direction) _targetTile.getNextTile(_direction)));

		foreach (tile in targets) {
			::Tactical.State.spawnHolyFlameOnTile(tile, _user);
		}

		return true;
	}
});
