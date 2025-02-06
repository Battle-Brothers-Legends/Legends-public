this.legend_daze_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDaze);
		this.m.Description = "Assault the senses of your target with a flurry of colorful sparks, whirs, and pops. Such an astonishing display is sure to leave anyone too bewildered to fight effectively. Does no damage.";
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
		this.m.IsRanged = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push(
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Leave your opponent bewildered, halving their damage, fatigue and initiative"
			}
		);
		ret.push(
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Uses Ranged skill to hit. Hit chance doubled if you also have the Taunt perk."
			}
		);

		return ret;
	}

	function getHitchance( _targetEntity )
	{
		if (!_targetEntity.isAttackable())
			return 0;

		local chance = getContainer().getActor().getCurrentProperties().getRangedSkill() - _targetEntity.getCurrentProperties().getRangedDefense();

		if (getContainer().hasPerk(::Legends.Perk.Taunt))
			chance *= 2;

		return ::Math.max(0, ::Math.min(100, chance));
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local r = this.Math.rand(1,100);

		if (r < this.getHitchance(targetEntity))
		{
			if (!targetEntity.getCurrentProperties().IsImmuneToStun)
			{
				this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

				if (targetEntity.isAlive())
				{
					::Legends.Effects.grant(targetEntity, ::Legends.Effect.LegendDazed);

					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " dazed " + this.Const.UI.getColorizedEntityName(targetEntity) + " leaving them dazed");
					}
				}

				return true;
			}
			else
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " failed to daze an immune " + this.Const.UI.getColorizedEntityName(targetEntity));
				return false;
			}
		}
		else
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " failed to daze " + this.Const.UI.getColorizedEntityName(targetEntity));
			return false;
		}

		return false;
	}

});
