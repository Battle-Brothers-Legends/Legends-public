this.legend_ranged_lash_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendRangedLash);
		this.m.Description = "Aim for an opponent\'s head. Somewhat unpredictable in damage, but able to strike over or around shield cover with a bit of luck.";
		this.m.Icon = "skills/active_91.png";
		this.m.IconDisabled = "skills/active_91_sw.png";
		this.m.Overlay = "active_91";
		this.m.SoundOnUse = [
			"sounds/combat/flail_01.wav",
			"sounds/combat/flail_02.wav",
			"sounds/combat/flail_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/flail_hit_01.wav",
			"sounds/combat/flail_hit_02.wav",
			"sounds/combat/flail_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsShieldRelevant = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();

		if (!::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties ) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.IsShieldRelevant = false;
		}
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			if (_targetEntity != null && !::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				this.m.HitChanceBonus += -15;
				_properties.MeleeSkill += -15;
			}
			_properties.HitChance[this.Const.BodyPart.Head] += 100.0;
		}
	}

});

