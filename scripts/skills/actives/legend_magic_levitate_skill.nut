// Basically copied from legend's levitate
this.legend_magic_levitate_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicLevitate);
		this.m.Description = "Levitate someone off the ground, granting them the ability to move freely across all terrain for one turn.";
		this.m.KilledString = "Levitated";
		this.m.Icon = "skills/levitate_square.png";
		this.m.IconDisabled = "skills/levitate_square_bw.png";
		this.m.Overlay = "levitate_square";
		this.m.SoundOnUse = [
			"sounds/humans/0/human_fatigue_01.wav"
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
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
	this.m.MaxLevelDifference = 6;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
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
			text = "Levitate someone off the ground, granting them the ability to move across all terrain freely"
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (target.getSkills().hasEffect(::Legends.Effect.LegendLevitating))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!target.isAlive())
		{
			return;
		}

		if (target.getSkills().hasEffect(::Legends.Effect.LegendLevitating))
		{
			return;
		}

		::Legends.Effects.grant(target, ::Legends.Effect.LegendLevitating);

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " levitated " + this.Const.UI.getColorizedEntityName(target));
		}
	}

});

