this.legend_redback_puncture_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendRedbackPuncture);
		this.m.Description = "A well-placed attack at the opponent armor\'s weakspots with redback poison. Ignores all armor and injects the target with poison but is harder to hit with and can not land critical hits for additional damage, nor inflict additional damage with double grip. Poison does not work on undead and you must deal enough damage for the poison to enter the system.";
		this.m.KilledString = "Punctured";
		this.m.Icon = "skills/active_27.png";
		this.m.IconDisabled = "skills/active_27_sw.png";
		this.m.Overlay = "active_27";
		this.m.SoundOnUse = [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/puncture_hit_01.wav",
			"sounds/combat/puncture_hit_02.wav",
			"sounds/combat/puncture_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.HitChanceBonus = -15;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getHitChance(_targetEntity)
	{
		if (_targetEntity == null)
		{
			return 0;
		}
		local mod = 0;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendDazed))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendParried))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrappled))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Stunned))
		{
			mod += 25;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Sleeping))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Net))
		{
			mod += 25;
		}
		local chance = (1.0 - _targetEntity.getFatiguePct()) * 50;
		return mod - this.Math.round(chance);
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Hit chance determined by your targets fatigue, 0% if they are fresh and 100% if they are exhausted. If your target is dazed or parried hitchance is increased by +10%.  If they are stunned or netted you gain +25%. If they are grappled or sleeping you gain +50%. Dagger mastery doubles your chance to hit. These bonuses stack up to 100%.  "
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Completely ignores armor and applies redback poison, dealing 55 damage over 10 turns. Damage doubled vs targets in a web "
			}
		]);
		return ret;
	}

	function canDoubleGrip()
	{
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = ::Legends.Traits.get(this, ::Legends.Trait.LegendProstheticHand);
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (missinghand == null || newhand != null) && main != null && off == null && main.isDoubleGrippable();
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{

		if (_skill != this)
		{
			return
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints <= this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isAlive())
		{
			return;
		}

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
		}

		this.spawnIcon("status_effect_54", _targetEntity.getTile());
		local poison = ::Legends.Effects.get(_targetEntity, ::Legends.Effect.LegendRedbackSpiderPoison);
		local effect = ::Legends.Effects.new(::Legends.Effect.LegendRedbackSpiderPoison);
		local actor = this.getContainer().getActor();
		if (actor.getFaction() == this.Const.Faction.Player )
		{
			effect.setActor(actor);
			if (poison != null)
			{
				poison.setActor(actor);
			}
		}

		if (poison == null)
		{
			_targetEntity.getSkills().add(effect);
		}
		else
		{
			poison.resetTime();
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return
		}
		local chance = this.getHitChance(_targetEntity);
		if (_properties.IsSpecializedInDaggers)
		{
			chance += 15
		}
		_properties.MeleeSkill += chance;
		_properties.DamageArmorMult *= 0.0;
		_properties.IsIgnoringArmorOnAttack = true;
		_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;

		if (this.canDoubleGrip())
		{
			_properties.DamageTotalMult /= 1.25;
		}

		if (_targetEntity != null && _targetEntity.getSkills().hasEffect(::Legends.Effect.Web))
		{
			_properties.DamageDirectMult *= 2.0;
		}
	}

});

