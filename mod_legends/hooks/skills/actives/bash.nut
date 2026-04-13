::mods_hookExactClass("skills/actives/bash", function(o)
{
	o.m.IsLuteBash <- false;
	o.m.IsDrumBash <- false;
	o.m.IsStaffBash <- false;

	o.setItem <- function (_item) {
		if (this.m.IsDrumBash)
		{
			this.m.Name = "Drum Bash";
			this.m.Description = "A drumming attack that clubs an opponent in time with the beat.";
			this.m.KilledString = "Banged like a drum";
			this.m.ActionPointCost = 2;
			this.m.FatigueCost = 7;
		}
		else if (this.m.IsLuteBash)
		{
			this.m.Name = "Lute Bash";
			this.m.Description = "A brute force attack with a string instrument";
			this.m.KilledString = "Luted";
			this.m.ActionPointCost = 3;
			this.m.FatigueCost = 9;
			this.m.ChanceSmash = 30;
		}
		else if (this.m.IsStaffBash)
		{
			this.m.Name = "Staff Bash";
			this.m.Icon = "skills/staff_bash.png";
			this.m.IconDisabled = "skills/staff_bash_bw.png";
			this.m.MaxRange = 2;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();
		if (this.m.IsDrumBash)
		{
			local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + 1) * this.Const.Combat.FatigueReceivedPerHit;
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=%damage%]" + fatPerHit + "[/color] extra fatigue"
			});
			return ret;
		}
		else if (this.m.IsStaffBash)
		{
			ret = getTooltip();
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]2[/color] tiles"
			});
			return ret;
		}
		else
		{
			return getTooltip();
		}
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.IsLuteBash)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInMaces ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else if (this.m.IsDrumBash || this.m.IsStaffBash)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else
		{
			onAfterUpdate( _properties );
		}
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.IsDrumBash)
		{
			_properties.FatigueDealtPerHitMult += 1.0;
		}
		else
		{
			onAnySkillUsed( _skill, _targetEntity, _properties );
		}
	}
});
