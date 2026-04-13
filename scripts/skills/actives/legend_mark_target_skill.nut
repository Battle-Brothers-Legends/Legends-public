this.legend_mark_target_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMarkTarget);
		this.m.Description = "Analyse the weak points on an opponent and tell your comrades, reducing the target's Defense by 10 and increasing Damage Taken from all sources by 1% of their total Hitpoints for 2 turns.";
		this.m.KilledString = "Marked";
		this.m.Icon = "skills/MarkTargetSkill.png";
		this.m.IconDisabled = "skills/MarkTargetSkill_bw.png";
		this.m.Overlay = "mark_target";
		this.m.SoundOnUse = [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"

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
		this.m.IsRanged = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 15;
		this.m.MaxLevelDifference = 3;
		this.m.IsUsingHitchance = false;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
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
			}
		]);
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

		if (target.isAlive() && !target.isDying())
		{
			::Legends.Effects.grant(target, ::Legends.Effect.LegendMarkedTarget);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " calls and singles out " + this.Const.UI.getColorizedEntityName(target) + " leaving them marked");
			}
		}
	}

	function onVerifyTarget( _originTile, _targetTile ) //This stops you from targeting allies with this skill
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		return true;
	}
});
