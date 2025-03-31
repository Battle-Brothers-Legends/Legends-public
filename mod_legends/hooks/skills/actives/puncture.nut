::mods_hookExactClass("skills/actives/puncture", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = -65;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Up to [color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] scaling hit chance depending on the target\'s fatigue, with the maximum reached if they are exhausted."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Additionally if your target is dazed or parried hitchance is increased by [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color], if they are stunned or netted you gain [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color], if they are grappled, sleeping, or fleeing you gain [color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color]"
			}
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Completely ignores armor"
			}
		]);
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
		{
			return 0;
		}
		local mod = 0;
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendDazed))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendParried))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrappled))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Stunned))
		{
			mod += 25;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Sleeping))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Net))
		{
			mod += 25;
		}
		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod += 50;
		}
		local chance = _targetEntity.getFatiguePct() * 50;
		return mod + this.Math.round(chance);
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			this.m.HitChanceBonus += this.getHitChance(_targetEntity);
			if (_properties.IsSpecializedInDaggers)
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
