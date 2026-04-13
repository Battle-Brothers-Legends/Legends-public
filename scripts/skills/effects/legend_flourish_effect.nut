this.legend_flourish_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsRemoved = true,
		LastFrameApplied = 0,
		LastEnemyAppliedTo = 0,
		SkillCount = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendFlourish);
		this.m.Icon = "ui/perks/perk_41.png";
		this.m.IconMini = "legend_flourish_effect_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is prepared to do exhausting and flashy moves which will both scare the opponent and penetrate their defenses in a display of remarkable swordsmanship.";
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
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Increases fatigue use of all skills by [color=%positive%]50%[/color]"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Chance on each attack to ignore armor completely, the chance is [color=%positive%]50%[/color] of the Initiative difference between you and the target as long as you are faster"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "As long as you are faster than the target, any attack that inflicts at least [color=%positive%]1[/color] point of damage to Hitpoints triggers a morale check for the opponent with a penalty equal to [color=%negative%]20%[/color] of the Initiative difference between you and the target"
			}
		];
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
	{
		if(_targetEntity == null || !_targetEntity.isAlive())
			return;

		if(_targetEntity.getMoraleState() == Const.MoraleState.Ignore || !_targetEntity.getCurrentProperties().IsAffectedByLosingHitpoints)
			return;
		local actor = this.getContainer().getActor();
		local bonus = this.getIniDifference(actor, _targetEntity);

		if (bonus == 0)
			return;

		if((Time.getFrame() == this.m.LastFrameApplied || this.m.SkillCount == Const.SkillCounter) && _targetEntity.getID() == this.m.LastEnemyAppliedTo)
		{
			if(_damageInflictedHitpoints >= Const.Morale.OnHitMinDamage)
				spawnIcon("perk_27", _targetEntity.getTile());

			return;
		}

		if(_damageInflictedHitpoints >= 1)
			spawnIcon("perk_27", _targetEntity.getTile());

		this.m.LastFrameApplied = Time.getFrame();
		this.m.LastEnemyAppliedTo = _targetEntity.getID();
		this.m.SkillCount = Const.SkillCounter;

		if(_damageInflictedHitpoints >= 1 && _damageInflictedHitpoints < Const.Morale.OnHitMinDamage)
		{
			local threatOnHit = actor.getCurrentProperties().ThreatOnHit;
			threatOnHit += this.Math.min(20, Math.max(0, (bonus - 10) * 0.2));
			_targetEntity.checkMorale(-1, Const.Morale.OnHitBaseDifficulty * (1.0 - (_targetEntity.getHitpoints() / _targetEntity.getHitpointsMax())) - threatOnHit);
		}
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_targetEntity == null || !_targetEntity.isAlive())
			return;

		local actor = this.getContainer().getActor();
		local bonus = getIniDifference(actor, _targetEntity);
		if (bonus == 0)
			return;

		local r = this.Math.rand(1, 100);
		local chance = this.Math.min(100, this.Math.floor(bonus * 0.5));
		if (r <= chance) {
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(actor) + "\'s " + this.getName() + " completely bypasseses " + this.Const.UI.getColorizedEntityName(_targetEntity) + "\'s defenses with great flourish (Chance: " + chance + ", Rolled: " + r + ")");
			_hitInfo.DamageDirect = 1.0;
		}
	}

	function getIniDifference( _attacker, _defender )
	{
		local bonus = 0;
		if (::MSU.isNull(_attacker) || ::MSU.isNull(_defender)) return bonus;

		local defenderCurrentInitiative = _defender.getInitiative();
		local attackerCurrentInitiative = _attacker.getInitiative();

		if (attackerCurrentInitiative > defenderCurrentInitiative)
			bonus = attackerCurrentInitiative - defenderCurrentInitiative;

		return bonus;
	}

	function onAfterUpdate(_properties)
	{
		_properties.FatigueEffectMult *= 1.5;
	}

	function onCombatStarted()
	{
		m.SkillCount = 0;
		m.LastEnemyAppliedTo = 0;
		m.LastFrameApplied = 0;
	}

	function onCombatFinished()
	{
		skill.onCombatFinished();

		m.SkillCount = 0;
		m.LastEnemyAppliedTo = 0;
		m.LastFrameApplied = 0;
	}

	function onTurnStart()
	{
		if (this.m.IsRemoved)
			this.removeSelf();
	}
});
