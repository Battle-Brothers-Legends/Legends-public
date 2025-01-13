::mods_hookExactClass("skills/actives/cudgel_skill", function(o)
{
	o.m.IsSwordBash <- false;

	o.setItem <- function (_item) {
		if (this.m.IsSwordBash)
		{
			this.m.Name = "Mordhau"
			this.m.Icon = "skills/active_mordhau.png";
			this.m.IconDisabled = "skills/active_mordhau_sw.png";
			this.m.ActionPointCost = 7;
			this.m.FatigueCost = 18;
		}
		this.skill.setItem(_item);
	}

	o.isHidden <- function ()
	{
		if (!this.m.IsSwordBash)
			return false;
		local actor = this.getContainer().getActor();
		if (actor == null || !actor.getSkills().hasPerk(::Legends.Perk.LegendSwordMaster))
			return true;

		return false;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = getTooltip();
		if (this.m.IsSwordBash && this.getContainer().hasPerk(::Legends.Perk.QuickHands))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Costs [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] less AP"
			});
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Costs [color=" + this.Const.UI.Color.NegativeValue + "]3[/color] less Fatigue (before other bonuses)"
			});
			return ret;
		}
		
		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.IsSwordBash)
		{
			if (this.getContainer().hasPerk(::Legends.Perk.QuickHands))
			{
				this.m.ActionPointCost -= 1;
				this.m.FatigueCost -= 3;
			}
			this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else
		{
			onAfterUpdate( _properties );
		}
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.IsSwordBash)
		{
			_properties.ArmorDamageMult += 0.25;
			_properties.DirectDamageMult += 0.15;
		}
		onAnySkillUsed( _skill, _targetEntity, _properties );
	}
});
