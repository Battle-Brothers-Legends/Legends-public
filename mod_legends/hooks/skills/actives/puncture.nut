::mods_hookExactClass("skills/actives/puncture", function(o)
{
	o.m.IsHalfsword <- false;
	o.m.IsGreatHalfsword <- false;

	o.setItem <- function(_item) {
		this.skill.setItem(_item);
		if (this.m.IsHalfsword) {
			this.m.Name = "Halfsword";
			this.m.Description = "A calculated attack with one hand firmly on the blade aiming in gaps of the armor. Ignores all armor but is harder to hit with and can not land critical hits for additional damage.";
			this.m.Icon = "skills/active_halfsword.png";
			this.m.IconDisabled = "skills/active_halfsword_bw.png";
			this.m.Overlay = "active_halfsword";
			this.m.ActionPointCost = this.m.IsGreatHalfsword ? 7 : 5;
			this.m.FatigueCost = this.m.IsGreatHalfsword ? 35 : 25;
			this.m.IsIgnoredAsAOO = true;
			this.m.IsHidden = true;
		}
	}

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = this.m.IsGreatHalfsword ? -80 : -65;
	}

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

	o.canDoubleGrip = function ()
	{
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = ::Legends.Traits.get(this, ::Legends.Trait.LegendProstheticHand);
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (missinghand == null || newhand != null) && main != null && off == null && main.isDoubleGrippable();
	}

	o.getHitChance <- function (_targetEntity)
	{
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
	
	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties ) {
		if (!this.m.IsHalfsword) {
			return onAfterUpdate(_properties);
		}
		else {
			this.m.IsHidden = !this.canDoubleGrip() && !this.m.Item.isItemType(this.Const.Items.ItemType.TwoHanded);
			this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			this.m.HitChanceBonus += this.getHitChance(_targetEntity);
			if (this.m.IsHalfsword && _properties.IsSpecializedInSwords)
			{
				this.m.HitChanceBonus += 15;
			}
			else if (_properties.IsSpecializedInDaggers)
			{
				this.m.HitChanceBonus += 15;
			}
			_properties.MeleeSkill += this.m.HitChanceBonus;
			_properties.DamageArmorMult *= 0.0;
			_properties.IsIgnoringArmorOnAttack = true;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;

			if (this.canDoubleGrip())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}
});
