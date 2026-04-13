this.legend_warfork_disarm_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		this.m.ID = "actives.legend_warfork_disarm";
		this.m.Name = "Disarm";
		this.m.Description = "Use the warfork\'s particular shape to temporarily disarm an opponent on a hit. A disarmed opponent can not use any weapon skills, but may still use other skills and move freely. Unarmed targets can not be disarmed.";
		this.m.Icon = "skills/active_legend_warfork_disarm.png";
		this.m.IconDisabled = "skills/active_legend_warfork_disarm_bw.png";
		this.m.Overlay = "active_legend_warfork_disarm";
		this.m.SoundOnHit = [
			"sounds/combat/repel_hit_01.wav",
			"sounds/combat/repel_hit_02.wav",
			"sounds/combat/repel_hit_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/impale_01.wav",
			"sounds/combat/impale_02.wav",
			"sounds/combat/impale_03.wav"
		];
		this.m.SoundOnHit = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.0;
		this.m.HitChanceBonus = -20;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
	}

	function getTooltip() {
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2" + "[/color] tiles"
		});

		if (this.m.HitChanceBonus != 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]" + this.m.HitChanceBonus + "%[/color] chance to hit"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to disarm on a hit"
		});
		return ret;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms) {
			this.m.HitChanceBonus = -10;
		}
		else {
			this.m.HitChanceBonus = -20;
		}
	}

	function onUse( _user, _targetTile ) {
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);

		if (success) {
			if (!target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsImmuneToDisarm) {
				::Legends.Effects.grant(target, ::Legends.Effect.Disarmed);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has disarmed " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
				}
			}
		}
		else {
			if (this.m.SoundOnMiss.len() != 0) {
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			_user.getSkills().onTargetMissed(this, target);
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
			{
				_properties.MeleeSkill -= 20;
			}
			else
			{
				_properties.MeleeSkill -= 10;
				this.m.HitChanceBonus += 10;
			}

			_properties.DamageTotalMult = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		}
	}

});

