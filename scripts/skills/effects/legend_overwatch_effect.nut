this.legend_overwatch_effect <- ::inherit("scripts/skills/skill", {
	m = {
		MaxFreeAttackCount = 5
		OverwatchZone = [] // an array contains all affected tiles
	},
	function setOverwatchZone( _array )
	{
		m.OverwatchZone = _array;
	}

	function create()
	{
		this.m.ID = "effects.legend_overwatch_effect";
		this.m.Name = "Overwatch";
		this.m.Description = "This character has been watched over certain zone, allowing this character to perform any basic ranged attack against any enemy moves within that zone. Last till the start of next turn.";
		this.m.Icon = "skills/MarkTargetSkill.png";
		this.m.IconMini = "mini_mark_target";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getTooltip()
	{
		return [
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
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Automatically performs ranged attack against any enemy walks into your overwatch zone but that attack deals [color=%negative%]25%[/color] less Damage"
			},
		];
	}

	function onAdded()
	{
		// add the attack count
		getContainer().getActor().m.WatcherAttackCount = m.MaxFreeAttackCount;

		// set up the overwatch zone
		::Tactical.Entities.addOverwatchZone(getContainer().getActor(), m.ZoneOfControl);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == null || !_skill.isRanged() || ::Tactical.TurnSequenceBar.isActiveEntity(getContainer().getActor()))
			return;

		_properties.RangedDamageMult *= 0.75; // i think the drawback of dealing less damage is good enough
	}

	function onDeath( _fatalityType )
	{
		onRemoved();
	}

	function onRemoved()
	{
		::Tactical.Entities.removeOverwatchZone(getContainer().getActor());
	}

	function onTurnStarted()
	{
		removeSelf(); // let treat this as riposte, last till the start of next turn
	}

});
