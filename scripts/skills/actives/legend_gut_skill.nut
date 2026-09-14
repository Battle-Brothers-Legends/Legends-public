this.legend_gut_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendGut);
		this.m.Description = "A series of thrusts to the body made in quick succession meant to gut them like a fish. Depending on how many injuries the opponent has suffered the attacks will increase.";
		this.m.KilledString = "Spilled their guts";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/impale", 3);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/combat/dlc2/lunge_attack_hit", 4);
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.Delay = 250;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Always hits the body"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Performs an additional attack for every injury on the target"
			}
		]);
		return ret;
	}

	function onAfterUpdate(_properties) {
		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse(_user, _targetTile) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectStab);
		local target = _targetTile.getEntity();
		local injuryCount = target.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len();
		local ret = this.attackEntity(_user, target);
		local timeDelay = 200;

		if ((::Tactical.TurnSequenceBar.getActiveEntity() == null || ::Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID())
			&& (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
		{
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			::Time.scheduleEvent(::TimeUnit.Virtual, 150, this.onAdditionalAttack, {
				User = _user,
				Skill = this,
				Target = target,
				IsLast = injuryCount < 1
			});

			for (local i = 0; i < injuryCount; i = ++i) {
				::Time.scheduleEvent(::TimeUnit.Virtual, timeDelay + ::Math.rand(0, 55), this.onAdditionalAttack, {
					User = _user,
					Skill = this,
					Target = target,
					IsLast = i == injuryCount - 1
				});
				timeDelay = timeDelay + 150;
			}

			return true;
		} else {
			if (target.isAlive()) {
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
				ret = this.attackEntity(_user, target) || ret;
			}

			return ret;
		}
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;
	}

	function onAdditionalAttack(_tag) {
		local user = _tag.User;
		local skill = _tag.Skill;
		local target = _tag.Target;
		local isLast = _tag.IsLast;

		if (!::Legends.S.isEntityNullOrDead(target) && !::Legends.S.isEntityNullOrDead(user)) {
			skill.spawnAttackEffect(target.getTile(), this.Const.Tactical.AttackEffectStab);
			::Sound.play(skill.m.SoundOnUse[this.Math.rand(0, skill.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, user.getPos());
			skill.attackEntity(user, target);
		}

		if (isLast) {
			skill.m.IsDoingAttackMove = true;
			skill.getContainer().setBusy(false);
		}
	}

});
