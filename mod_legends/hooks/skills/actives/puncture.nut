::mods_hookExactClass("skills/actives/puncture", function(o)
{
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.extend([{
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Up to [color=%positive%]+50%[/color] scaling hit chance depending on the target\'s fatigue, with the maximum reached if they are exhausted."
		},
		{
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Additionally if your target is [color=%effect%]Dazed[/color] or [color=%effect%]Parried[/color] hitchance is increased by [color=%positive%]+10%[/color], if they are stunned or rooted you gain [color=%positive%]+25%[/color], if they are [color=%effect%]Grappled[/color], [color=%effect%]Tackled[/color], [color=%effect%]Fleeing[/color] you gain [color=%positive%]+50%[/color]"
		}]);
		return tooltip;
	}

	o.canDoubleGrip = function () {
		return this.getContainer().getActor().canDoubleGrip();
	}

	o.getHitChance <- function (_targetEntity) {
		if (_targetEntity == null)
			return 0;

		local mod = 0;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendStupefied))
			mod += 10;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendParried))
			mod += 10;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Dazed))
			mod += 10;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrappled))
			mod += 50;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Stunned))
			mod += 25;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Sleeping))
			mod += 50;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendKnockedOver))
			mod += 50;
		if (_targetEntity.getCurrentProperties().IsRooted)
			mod += 25;
		if (_targetEntity.getMoraleState() == ::Const.MoraleState.Fleeing)
			mod += 50;
		local chance = _targetEntity.getFatiguePct() * 50;
		return mod + ::Math.round(chance);
	}
	
	o.onAfterUpdate = function ( _properties ) {
		if (::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
		}

		this.m.FatigueCostMult = ::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) ? ::Const.Combat.WeaponSpecFatigueMult : 1.0; 
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			this.m.HitChanceBonus += this.getHitChance(_targetEntity);
			if (::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem())) {
				this.m.HitChanceBonus +=15;
			}
			_properties.MeleeSkill += this.m.HitChanceBonus;
			_properties.DamageArmorMult *= 0.0;
			_properties.DamageDirectAdd = 0;
			_properties.IsIgnoringArmorOnAttack = true;
			_properties.HitChanceMult[::Const.BodyPart.Head] = 0.0;
			_properties.HitChanceMult[::Const.BodyPart.Body] = 1.0;

			if (this.canDoubleGrip()) {
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}
});
