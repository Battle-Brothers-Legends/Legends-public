::mods_hookExactClass("skills/actives/puncture", function(o)
{
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		local penalty = this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers ? 50 : 65;
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-" + penalty + "%[/color] chance to hit"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Hit chance is increased by up to +50% depending on target\'s fatigue, +0% if they are fresh and +50% if they are exhausted. Additionally if your target is dazed or parried hitchance is increased by +10%,  if they are stunned or netted you gain +25%, if they are grappled, sleeping, or fleeing you gain +50%."
			},
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
		local newhand = this.m.Container.getSkillByID("trait.legend_prosthetic_hand");
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
		if (_targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod += 25;
		}
		if (_targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod += 25;
		}
		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod += 50;
		}
		local chance = (1.0 - _targetEntity.getFatiguePct()) * 50;
		return mod - this.Math.round(chance);
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			this.m.HitChanceBonus = -15;
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
