::mods_hookExactClass("skills/actives/split_man", function(o)
{
	o.m.IsOrcWeapon <- false;

	o.setApplyOrcWeapon <- function ( _f )
	{
		this.m.IsOrcWeapon = _f;
	}

	o.isHidden <- function() {
		local dg = this.getContainer().getActor().getSkills().getSkillByID("special.double_grip");
		local canDoubleGrip = dg != null && ("canDoubleGrip" in dg) && dg.canDoubleGrip();
		return this.m.IsOrcWeapon && !canDoubleGrip;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hits both head and body for additional damage"
		});
		return tooltip;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate( _properties );
		if (this.m.IsOrcWeapon)
			this.m.ActionPointCost = 5;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTooltipMinMult *= 1.5;
			_properties.DamageTooltipMaxMult *= 1.5;
		}
	}

});
