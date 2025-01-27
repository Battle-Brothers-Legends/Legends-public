this.legend_enthrall_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendEnthrall);
		this.m.Icon = "skills/enthrall.png";
		this.m.IconDisabled = "skills/enthrall_bw.png";
		this.m.Overlay = "enthrall";
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted + 6;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 8;
	}

	function getDescription()
	{
		return "Pull at the strings of a single creation, compelling them to linger among you as an obedient guardian. Enthralled dead act defensively and attempt to protect you from threats."
	}

	function getTooltip()
	{
		return this.skill.getDefaultUtilityTooltip();
	}


	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (!target.getFlags().has("IsSummoned")){
			return false;
		}

		if (target.getFlags().has("IsEnthralled")){
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local agent;
		if (target.getFlags().has("zombie_minion"))
		{
			agent = this.new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
		}

		if (target.getFlags().has("skeleton"))
		{
			agent =  this.new("scripts/ai/tactical/agents/skeleton_bodyguard_agent");
		}

		if (agent == null)
		{
			return;
		}

		target.getAIAgent().setFinished(true);
		target.getAIAgent().setActor(_user);
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " enthralls " + this.Const.UI.getColorizedEntityName(target));
		target.getFlags().add("IsEnthralled", true);
	}


});
