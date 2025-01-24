this.legend_rock_unhold_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_rock_unhold";
		this.m.Name = "Rock Unhold Passive";
		this.m.Description = "TODO";
		this.m.Icon = "skills/status_effect_79.png";
		this.m.SoundOnUse = [
			"sounds/enemies/unhold_regenerate_01.wav",
			"sounds/enemies/unhold_regenerate_02.wav",
			"sounds/enemies/unhold_regenerate_03.wav"
		];
		this.m.Type = this.Const.SkillType.Racial;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local totalBodyArmor = actor.getArmorMax(this.Const.BodyPart.Body);
		local totalHeadArmor = actor.getArmorMax(this.Const.BodyPart.Head);
		local currentBodyArmor = actor.getArmor(this.Const.BodyPart.Body);
		local currentHeadArmor = actor.getArmor(this.Const.BodyPart.Head);
		local missingBodyArmor = totalBodyArmor - currentBodyArmor;
		local missingHeadArmor = totalHeadArmor - currentHeadArmor;
		local healRateBody = totalBodyArmor * 0.1;
		local healRateHead = totalHeadArmor * 0.1;
		local addedBodyArmor = this.Math.abs(this.Math.min(missingBodyArmor, healRateBody));
		local addedHeadArmor = this.Math.abs(this.Math.min(missingHeadArmor, healRateBody));
		local newBodyArmor = currentBodyArmor + addedBodyArmor;
		local newHeadArmor = currentHeadArmor + addedHeadArmor;

		if (addedBodyArmor <= 0 && addedHeadArmor <= 0)
		{
			return;
		}

		if (!actor.getSkills().hasEffect(::Legends.Effect.SpiderPoison) && !actor.getSkills().hasEffect(::Legends.Effect.LegendRedbackSpiderPoison) && !actor.getSkills().hasEffect(::Legends.Effect.LegendRswPoisonEffect))
		{
			actor.setArmor(this.Const.BodyPart.Body, newBodyArmor);
			actor.setArmor(this.Const.BodyPart.Head, newHeadArmor);
			actor.setDirty(true);
			if (!actor.isHiddenToPlayer())
			{
				this.spawnIcon("status_effect_79", actor.getTile());

				if (this.m.SoundOnUse.len() != 0)
				{
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
				}

				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " regenerated " + addedBodyArmor + " points of body armor");
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " regenerated " + addedHeadArmor + " points of head armor");
			}
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor().get();

		if ((!this.Tactical.State.isScenarioMode() && this.Time.getRound() <= 2 || this.Tactical.State.isScenarioMode() && this.Time.getRound() <= 3) && (this.isKindOf(actor, "unhold_armored") || this.isKindOf(actor, "unhold_frost_armored")))
		{
			_properties.InitiativeForTurnOrderAdditional += 40;
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case ::Const.Damage.DamageType.Piercing:
			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.1;
				break;

			case ::Const.Damage.DamageType.Cutting:
				_properties.DamageReceivedRegularMult *= 0.4;
				break;

			case ::Const.Damage.DamageType.Blunt:
				_properties.DamageReceivedRegularMult *= 1.2;
				break;
		}
	}
});

