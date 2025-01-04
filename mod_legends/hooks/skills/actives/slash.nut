::mods_hookExactClass("skills/actives/slash", function(o)
{
	o.m.isGreatSlash <- false;
	o.m.isGlaiveSlash <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		if (this.m.isGreatSlash)
		{
			this.m.Name = "Great Slash";
			this.m.Description = "A hefty swift slashing attack dealing average damage.";
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
		}
		else if (this.m.isGlaiveSlash)
		{
			this.m.Name = "Glaive Slash";
			this.m.Description = "A swift slashing attack dealing average damage.";
			this.m.Icon = "skills/glaive_slash.png";
			this.m.IconDisabled = "skills/glaive_slash_bw.png";
			this.m.DirectDamageMult = 0.25;
		}
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();

		tooltip.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.HitChanceBonus	+ "%[/color] chance to hit"
			}
		);

		if (this.m.isGlaiveSlash && this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears || !this.m.isGlaiveSlash && this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit from weapon mastery"
			});
		}

		return tooltip;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.isGlaiveSlash)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInSpears ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else
		{
			onAfterUpdate( _properties );
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;

			_skill.resetField("HitChanceBonus");

			if (this.m.isGlaiveSlash && this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
			else if (!this.m.isGlaiveSlash && this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
			}
		}
	}

});
