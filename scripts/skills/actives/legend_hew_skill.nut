this.legend_hew_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ApplyHead = false,
		SoundsA = ::Legends.S.setSounds("sounds/combat/cleave_hit_hitpoints", 3),
		SoundsB = ::Legends.S.setSounds("sounds/combat/chop_hit", 3)
	},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHew);
		this.m.Description = "An overhead strike that bears the full force on the targets entire body.";
		this.m.KilledString = "Hewed";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/overhead_strike", 3);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/combat/execute_hit", 3);
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
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 99;
		this.m.ChanceSmash = 0;
	}

	function getTooltip () {
		local tooltip = this.getDefaultTooltip();

		local specialized = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers;
		local dmg = specialized ? 20 : 10;
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		if (specialized)
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hits both head and body for [color=%damage%]60%[/color] or [color=%damage%]80%[/color] each if the target is wounded or bleeding"
			});
		else
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hits both head and body for [color=%damage%]60%[/color]"
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
		
		_properties.DamageTooltipMaxMult *= 2.0;

		if (_targetEntity != null && (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) || ::Legends.Effects.has(_targetEntity, ::Legends.Effect.Bleeding)) && _properties.IsSpecializedInCleavers)
			_properties.DamageTotalMult *= 0.8;
		else
			_properties.DamageTotalMult *= 0.6;
	}
});

