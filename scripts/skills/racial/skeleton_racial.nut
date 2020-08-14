this.skeleton_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.skeleton";
		this.m.Name = "Resistant to Ranged Attacks";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		if (_skill.getID() == "actives.aimed_shot" || _skill.getID() == "actives.quick_shot"  || _skill.getID() == "actives.legend_cascade"  || _skill.getID() == "actives.legend_siphon_skill")
		{
			_properties.DamageReceivedRegularMult *= 0.1;
		}
		else if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.sling_stone" || _skill.getID() == "actives.legend_piercing_shot" || _skill.getID() == "actives.fire_handgonne")
		{
			_properties.DamageReceivedRegularMult *= 0.33;
		}
		else if (_skill.getID() == "actives.throw_javelin" || _skill.getID() == "actives.legend_magic_missile" || _skill.getID() == "actives.ignite_firelance")
		{
			_properties.DamageReceivedRegularMult *= 0.25;
		}
		else if (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.thrust" || _skill.getID() == "actives.stab" || _skill.getID() == "actives.deathblow" || _skill.getID() == "actives.impale" || _skill.getID() == "actives.rupture" || _skill.getID() == "actives.prong" || _skill.getID() == "actives.lunge")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}

		 if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			_properties.DamageReceivedRegularMult *= 0.75;
		}

	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		 if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints <= this.Const.Combat.MinDamageToApplyBleeding || _targetEntity.getHitpoints() <= 0)
				{
					return;
				}

				if (!_targetEntity.isAlive())
				{
					return;
				}

				if (_targetEntity.getTags().has("undead"))
				{
					return;
				}

				if (!_targetEntity.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
				}

				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 5 : 3);
				local bleed = _targetEntity.getSkills().getSkillByID("effects.bleeding_effect");
				if (bleed == null)
				{
					if (this.getContainer().getActor().getFaction() == this.Const.Faction.Player )
					{
						effect.setActor(this.getContainer().getActor());
					}
					_targetEntity.getSkills().add(effect);
				}
				else
				{
					effect.resetTime();
				}
			}
	}

});

