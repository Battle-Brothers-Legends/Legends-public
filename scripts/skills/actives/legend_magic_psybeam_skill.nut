this.legend_magic_psybeam_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {
	},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicPsybeam);
		this.m.Description = "Launch a mental attack in the form of a ray at an enemy. Does no damage.";
		this.m.KilledString = "Stunned";
		this.m.Icon = "skills/psybeam_square_01.png";
		this.m.IconDisabled = "skills/psybeam_square_01_bw.png";
		this.m.Overlay = "mage_legend_magic_psybeam_square";
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
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 45;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Stun (or daze) your opponent for 2 rounds."
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hit chance based on ranged attack."
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		local ourSkill = _user.getCurrentProperties().getRangedSkill();
		local theirSkill = targetEntity.getCurrentProperties().getRangedDefense();
		local r = this.Math.rand(1, 100);

		local chance = ourSkill - theirSkill;
		chance = chance > 95 ? 95 : chance;
		chance = chance < 5 ? 5 : chance;

		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses psybeam on " + this.Const.UI.getColorizedEntityName(targetEntity) + " (Chance: " + chance + ", Rolled: " + r +")");

		if (r <= chance)
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

			if (targetEntity.isAlive())
			{
				if (!targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					::Legends.Effects.grant(target, ::Legends.Effect.Stunned, function(_effect) {
						_effect.addTurns(1);
					}.bindenv(this));

					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " psybeamed " + this.Const.UI.getColorizedEntityName(targetEntity) + " leaving them stunned");
					}
				}
			}
			else
			{
				::Legends.Effects.grant(targetEntity, ::Legends.Effect.LegendDazed);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " psybeamed " + this.Const.UI.getColorizedEntityName(targetEntity) + " leaving them dazed");
				}
			}
		}
	}
});
