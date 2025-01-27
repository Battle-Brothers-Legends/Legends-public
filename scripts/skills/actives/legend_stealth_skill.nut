this.legend_stealth_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendStealth);
		this.m.Description = "Fade into the environment.";
		this.m.Icon = "skills/stealth_square.png";
		this.m.IconDisabled = "skills/stealth_square_bw.png";
		this.m.Overlay = "active_15";
		this.m.SoundOnUse = [
			"sounds/combat/shieldwall_01.wav",
			"sounds/combat/shieldwall_02.wav",
			"sounds/combat/shieldwall_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OtherTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();

		if (this.isActorVisibleToEnemy())
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Can not be used if currently visible to an opponent"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable() && !this.isActorVisibleToEnemy();
	}

	function isActorVisibleToEnemy()
	{
		return false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		if (!this.m.IsSpent)
		{
			::Legends.Effects.grant(this, ::Legends.Effect.Stealth);
			this.m.IsSpent = true;
			return true;
		}

		return false;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

});
