this.legend_exsanguinate_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ApplicableSkills = [
			::Legends.Effect.SpiderPoison,
			::Legends.Effect.LegendRedbackSpiderPoison,
			::Legends.Effect.LegendGrazed,
			::Legends.Effect.Bleeding
		]
	},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendExsanguinate);
		this.m.Description = "A strike that will punish a bleeding or poisoned opponent.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/cleave", 3);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/combat/decapitate_hit", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.35;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 50;
		this.m.ChanceSmash = 0;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Instantly triggers every [color=%status%]Bleed[/color], [color=%status%]Graze[/color] or damaging [color=%status%]Poison[/color] upon hitting your target"
		});
		return ret;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		if (_skill != this) {
			return;
		}

		if (::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return;
		}

		local targetStatus = _targetEntity.getSkills();
		foreach (skill in this.m.ApplicableSkills) {
			local effect = ::Legends.Effects.get(_targetEntity, skill);
			if (effect != null && !::Legends.S.isEntityNullOrDead(_targetEntity)) {
				effect.applyDamage();
			}
		}

		if (::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return;
		}

		local cutArtery = _targetEntity.getSkills().getSkillByID("injury.cut_artery");
		if (cutArtery != null) {
			cutArtery.applyDamage();
		}
	}
});

