this.legend_arena_invictus_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		LastFrameApplied = 0,
		LastEnemyAppliedTo = 0,
		SkillCount = 0
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendArenaInvictus);
		this.m.Name = "Invictus";
		this.m.Icon = "ui/traits/trait_invictus.png";
		this.m.Description = "With a single fist raised, %fullname% stops the crowd cheering. With both raised, they shout %their% name from the stands. Gladiators rather wrestle a Lindwurm than fight %them% in the arena.";
		this.m.Overlay = "trait_invictus";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
	}

	function getTooltip()
	{
		local matches = this.getContainer().getActor().getFlags().getAsInt("ArenaFights");
		local won = this.getContainer().getActor().getFlags().getAsInt("ArenaFightsWon");

		if (won == matches)
		{
			won = "all";
		}

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription() + " So far, this character has fought in " + matches + " matches and won " + won + " of them."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+18[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=%positive%]+10[/color] Hitpoints"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+5%[/color] Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]75%[/color] chance to survive if struck down and not killed by a fatality"
			}
		];

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.Fearsome))
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Increases the penalty to the morale check from fearsome by [color=%positive%]10%[/color] of your arena wins"
			});
		}
		else
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Any attack that inflicts at least 1 point of damage to hitpoints triggers a morale check for the opponent with a penalty equal to [color=%positive%]10%[/color] of your arena wins"
			});
		}

		return ret;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.Fearsome)) return;

		if (_targetEntity == null || !_targetEntity.isAlive()) return;

		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Ignore) return;

		if ((this.Time.getFrame() == this.m.LastFrameApplied || this.m.SkillCount == this.Const.SkillCounter) && _targetEntity.getID() == this.m.LastEnemyAppliedTo)
		{
			if (_damageInflictedHitpoints >= this.Const.Morale.OnHitMinDamage)
			{
				this.spawnIcon(this.m.Overlay, _targetEntity.getTile());
			}
			return;
		}

		if (_damageInflictedHitpoints >= 1) this.spawnIcon(this.m.Overlay, _targetEntity.getTile());

		this.m.LastFrameApplied = this.Time.getFrame();
		this.m.LastEnemyAppliedTo = _targetEntity.getID();
		this.m.SkillCount = this.Const.SkillCounter;

		if (_damageInflictedHitpoints >= 1 && _damageInflictedHitpoints < this.Const.Morale.OnHitMinDamage)
		{
			_targetEntity.checkMorale(-1, this.Const.Morale.OnHitBaseDifficulty * (1.0 - _targetEntity.getHitpoints() / _targetEntity.getHitpointsMax()) - this.getContainer().getActor().getCurrentProperties().ThreatOnHit);
		}
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 18;
		_properties.Hitpoints += 10;
		_properties.DamageTotalMult *= 1.05;
		_properties.SurviveWithInjuryChanceMult *= 2.27;
	}

	function onAfterUpdate( _properties )
	{
		local won = this.getContainer().getActor().getFlags().getAsInt("ArenaFightsWon");
		_properties.ThreatOnHit += this.Math.min(10, this.Math.floor(won * 0.1));
	}

	function onCombatStarted()
	{
		this.m.SkillCount = 0;
		this.m.LastEnemyAppliedTo = 0;
		this.m.LastFrameApplied = 0;
	}

});

