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
			text = "Additionally if your target is dazed or parried hitchance is increased by [color=%positive%]+10%[/color], if they are stunned or rooted you gain [color=%positive%]+25%[/color], if they are grappled, sleeping, or fleeing you gain [color=%positive%]+50%[/color]"
		}]);
		return tooltip;
	}

	o.canDoubleGrip = function () {
		local actor = this.getContainer().getActor();
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = ::Legends.Traits.get(this, ::Legends.Trait.LegendProstheticHand);
		local main = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local hasXbow = off != null && ::MSU.String.endsWith(off.getID(), "_hand_crossbow");
		local hasNet = off != null && ::MSU.String.endsWith(off.getID(), "_net") && actor.getCurrentProperties().IsSpecializedInNets;
		return (missinghand == null || newhand != null) && main != null && (off == null || hasXbow || hasNet) && main.isDoubleGrippable();
	}

	o.getHitChance <- function (_targetEntity) {
		if (_targetEntity == null)
			return 0;

		local mod = 0;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendDazed))
			mod += 10;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendParried))
			mod += 10;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrappled))
			mod += 50;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Stunned))
			mod += 25;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Sleeping))
			mod += 50;
		if (_targetEntity.getCurrentProperties().IsRooted)
			mod += 25;
		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
			mod += 50;
		local chance = _targetEntity.getFatiguePct() * 50;
		return mod + this.Math.round(chance);
	}
	
	o.onAfterUpdate = function ( _properties ) {
		if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
		}

		this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0; 
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			this.m.HitChanceBonus += this.getHitChance(_targetEntity);
			if (::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem())) {
				this.m.HitChanceBonus += 15;
			}
			_properties.MeleeSkill += this.m.HitChanceBonus;
			_properties.DamageArmorMult *= 0.0;
			_properties.DamageDirectAdd = 0;
			_properties.IsIgnoringArmorOnAttack = true;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;

			if (this.canDoubleGrip()) {
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}
});
