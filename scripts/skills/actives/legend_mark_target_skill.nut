this.legend_mark_target_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Uses = 1
	},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMarkTarget);
		this.m.Description = "Analyse the weak points on an opponent and tell your comrades, reducing the target's Defense by 10 and increasing Damage Taken from all sources by 1% of their total Hitpoints for 2 turns.";
		this.m.KilledString = "Marked";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/legend_mark_target", 3);
		this.m.SoundOnHit = ["sounds/humans/0/human_fatigue_01.wav"];
		this.m.SoundVolume = 1.25;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsRanged = false;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 15;
		this.m.MaxLevelDifference = 3;
		this.m.IsUsingHitchance = false;
		this.m.MinRange = 1;
		this.m.MaxRange = 99; // as far as this character can see, the target tile still has to be visible to him
	}

	function getTooltip() {
		local ret = this.getDefaultUtilityTooltip().filter(@(_, _row) _row.id != 7); // without the range line, it would say 99 tiles
		ret.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Can be used on any enemy this character can see"
		},
		{
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%negative%]-10[/color] Melee Defense"
		},
		{
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=%negative%]-10[/color] Ranged Defense"
		},
		{
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Up to [color=%positive%]20%[/color] Damage Received from all sources, scaling on Hitpoints"
		}]);
		return ret;
	}

	function isUsable() {
		return this.skill.isUsable() && this.m.Uses > 0;
	}

	function onAfterUpdate(_properties) {
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse(_user, _targetTile) {
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		this.m.Uses = ::Math.max(0, this.m.Uses - 1)
		if (target.isAlive() && !target.isDying()) {
			::Legends.Effects.grant(target, ::Legends.Effect.LegendMarked);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " calls and singles out " + ::Const.UI.getColorizedEntityName(target) + " leaving them marked");
			}
		}
	}

	function onTurnStart() {
		this.m.Uses = this.getContainer().getActor().getCurrentProperties().IsSpecializedInBows ? 2 : 1;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			return false;
		}

		if (_targetTile.getEntity().isAlliedWith(this.getContainer().getActor())) {
			return false;
		}

		return true;
	}
});
