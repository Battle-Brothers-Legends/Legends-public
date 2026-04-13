::mods_hookExactClass("skills/actives/swing", function(o)
{
	o.m.ApplyAxeMastery <- false;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = -5;
	}

	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 3 targets"
		});
		return ret;
	}

	o.isAxeMasteryApplied <- function ()
	{
		return this.m.ApplyAxeMastery;
	}

	o.setApplyAxeMastery <- function ( _f )
	{
		this.m.ApplyAxeMastery = _f;
	}

	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.ApplyAxeMastery)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill -= 5;
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 10;
			}
		}
	}

});
