this.legend_hew_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ApplyHead = false,
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		]
	},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHew);
		this.m.Description = "An overhead strike that bears the full force on the targets entire body.";
		this.m.KilledString = "Hewed";
		this.m.Icon = "skills/active_20.png";
		this.m.IconDisabled = "skills/active_20_sw.png";
		this.m.Overlay = "active_20";
		this.m.SoundOnUse = [
			"sounds/combat/overhead_strike_01.wav",
			"sounds/combat/overhead_strike_02.wav",
			"sounds/combat/overhead_strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/overhead_strike_hit_01.wav",
			"sounds/combat/overhead_strike_hit_02.wav",
			"sounds/combat/overhead_strike_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.35;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 99;
		this.m.ChanceSmash = 0;
	}

	function getTooltip () {
		local tooltip = this.getDefaultTooltip();

		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 20 : 10;
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hits both head and body for [color=%damage%]50%[/color] each"
		});
		return tooltip;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		this.m.ApplyHead = true;
		local success = this.attackEntity(_user, target);

		if (::Legends.S.isEntityNullOrDead(_user))
			return success;

		if (success)
			::Legends.S.applyBleed(target, _user, hp, this.m.SoundsA, this.m.SoundsB);

		if (::Legends.S.isEntityNullOrDead(target))
			return success;

		this.m.ApplyHead = false;
		if (success)
		{
			hp = target.getHitpoints();
			local p = this.getContainer().buildPropertiesForUse(this, target);
			local hitInfo = clone this.Const.Tactical.HitInfo;
			local damageMult = p.MeleeDamageMult * p.DamageTotalMult;
			local damageRegular = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageRegularMult;
			local damageArmor = this.Math.rand(p.DamageRegularMin, p.DamageRegularMax) * p.DamageArmorMult;
			local damageDirect = this.Math.minf(1.0, p.DamageDirectMult * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
			hitInfo.DamageRegular = damageRegular * damageMult;
			hitInfo.DamageArmor = damageArmor * damageMult;
			hitInfo.DamageDirect = damageDirect;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 1.0;
			target.onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			::Legends.S.applyBleed(target, _user, hp, this.m.SoundsA, this.m.SoundsB);
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill != this)
			return;

		if (this.m.ApplyHead)
			_properties.HitChance[this.Const.BodyPart.Head] = 100;

		_properties.DamageTotalMult *= 0.5;
		_properties.DamageTooltipMaxMult *= 2.0;
	}
});

