this.legend_curseofyears_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCurseofyears);
		this.m.Description = "This curse gives the victim a glimpse of their own mortality, briefly aging them. Imagining itself with an infirm body of advanced age, the afflicted believes it is no longer capable of youthful exertions.";
		this.m.Icon = "skills/active_117.png";
		this.m.IconDisabled = "skills/active_117_sw.png";
		this.m.Overlay = "active_117";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/alp_nightmare_01.wav",
			"sounds/enemies/dlc2/alp_nightmare_02.wav",
			"sounds/enemies/dlc2/alp_nightmare_03.wav",
			"sounds/enemies/dlc2/alp_nightmare_04.wav",
			"sounds/enemies/dlc2/alp_nightmare_05.wav",
			"sounds/enemies/dlc2/alp_nightmare_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
	}

	function getTooltip()
	{

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The damage being applied in next turn has a [color=%positive%]17%[/color] chance to cause a wound. An additional stack is added in each turn, to a maximum of [color=%positive%]83%[/color]. The damage pierces armor."
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Before damage is applied, the target has a [color=%damage%]30%[/color] chance to break the effect."
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Decrepify has a cooldown of [color=%damage%]4[/color] turns."
			}
		];
		return ret;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local opponents = actor.getAIAgent().getKnownOpponents();
		local curseofyears = 0;

		foreach( o in opponents )
		{
			if (o.Actor.getSkills().hasEffect(::Legends.Effect.LegendCurseofyears))
			{
				curseofyears = ++curseofyears;
			}
		}

		if (opponents.len() > 1 && opponents.len() - curseofyears <= 1)
		{
			return false;
		}

		return this.m.Cooldown == 0 && this.skill.isUsable();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		this.m.Cooldown = 4;
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " Died over time");
		}

		::Legends.Effects.grant(target, ::Legends.Effect.LegendCurseofyears);
		if ("addStacks" in _user)
		{
			_user.addStacks(5);
		}
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

});

