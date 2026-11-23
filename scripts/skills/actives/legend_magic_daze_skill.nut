this.legend_magic_daze_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicDaze);
		this.m.Description = "Assault the senses of your target with a conjured flurry of colorful sparks, whirs, and pops. Such an astonishing display is sure to leave anyone too bewildered to fight effectively. Does no damage. Requires a staff.";
		this.m.KilledString = "Dazed";
		this.m.Icon = "skills/daze_square.png";
		this.m.IconDisabled = "skills/daze_square_bw.png";
		this.m.Overlay = "daze_square";
		this.m.SoundOnUse = [
			"sounds/combat/stupefy_01.wav",
			"sounds/combat/stupefy_02.wav",
			"sounds/combat/stupefy_03.wav",
			"sounds/combat/stupefy_04.wav",
			"sounds/combat/stupefy_05.wav"
		];
		this.m.SoundOnHit = [
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRanged = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 12;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
	}

	function getTooltip() {
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Leave your opponent stupefied, halving their Damage, Fatigue and Initiative"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hit chance based on Resolve"
		});
		return ret;
	}

	function getHitchance(_targetEntity) {
		local chance = this.Math.round(40 + (this.getCurrentResolve() - _targetEntity.getCurrentProperties().getBravery()) / 2);
		return ::Math.max(0, ::Math.min(100, chance));
	}

	function onUse(_user, _targetTile) {
		local targetEntity = _targetTile.getEntity();
		local roll = this.Math.rand(1, 100);
		local chance = this.getHitchance(targetEntity);

		local logString = this.Const.UI.getColorizedEntityName(_user) + " tries to stupefy " + this.Const.UI.getColorizedEntityName(targetEntity) + " (Chance: " + chance + ", Rolled: " + roll + ")\n";

		if (roll <= chance) {
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

			if (!::Legends.S.isEntityNullOrDead(targetEntity)) {
				::Legends.Effects.grant(targetEntity, ::Legends.Effect.LegendDazed, function (_effect) {
					_effect.m.TurnsLeft = ::Math.max(1, 1 + this.getCurrentProperties().NegativeStatusEffectDuration);
				}.bindenv(targetEntity));

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
					this.Tactical.EventLog.log(logString + this.Const.UI.getColorizedEntityName(_user) + " stupefied " + this.Const.UI.getColorizedEntityName(targetEntity) + ".");
				}
			}
		} else {
			this.Tactical.EventLog.log(logString + this.Const.UI.getColorizedEntityName(_user) + " failed to stupefy " + this.Const.UI.getColorizedEntityName(targetEntity));
		}
	}
});
