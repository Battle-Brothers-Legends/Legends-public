::mods_hookExactClass("skills/actives/bash", function(o)
{
	o.m.IsLuteBash <- false;
	o.m.IsDrumBash <- false;
	o.m.IsStaffBash <- false;
	o.m.IsSwordBash <- false;

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
			this.m.Name = "Staff Bash"
			this.m.Icon = "skills/staff_bash.png";
			this.m.IconDisabled = "skills/staff_bash_bw.png";
			this.m.MaxRange = 2;
		}
		else if (this.m.IsSwordBash)
		{
			this.m.Name = "Mordhau"
			this.m.Icon = "skills/active_mordhau.png";
			this.m.IconDisabled = "skills/active_mordhau_sw.png";
			this.m.ActionPointCost = 5;
			this.m.FatigueCost = 15;
		}
		this.skill.setItem(_item);
	}

	o.isHidden <- function ()
	{
		if (!this.m.IsSwordBash)
			return false;
		local actor = this.getContainer().getActor();
		local doubleGrip = this.getContainer().getSkillByID("special.double_grip");
		if (actor == null || !actor.getSkills().hasPerk(::Legends.Perk.LegendSwordMaster) && !doubleGrip.canDoubleGrip())
			return true;

		return false;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		if (this.m.IsDrumBash)
		{
			local ret = this.getDefaultTooltip();
			local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + 1) * this.Const.Combat.FatigueReceivedPerHit;
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + fatPerHit + "[/color] extra fatigue"
			});
			return ret;
		}
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
				text = "Costs [color=" + this.Const.UI.Color.NegativeValue + "]2[/color] less Fatigue (before other bonuses)"
			});
			return ret;
		}
		
		return ret;
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
			this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
		else if (this.m.IsSwordBash)
		{
			if (this.getContainer().hasPerk(::Legends.Perk.QuickHands))
			{
				this.m.ActionPointCost -= 1;
				this.m.FatigueCost -= 2;
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
		if (_skill == this && this.m.IsDrumBash)
		{
			_properties.FatigueDealtPerHitMult += 1.0;
		}
		else if (_skill == this && this.m.IsSwordBash)
		{
			_properties.ArmorDamageMult += 0.25;
			_properties.DirectDamageMult += 0.15;
			_properties.FatigueDealtPerHitMult += 2.0;
		}
		else
		{
			onAnySkillUsed( _skill, _targetEntity, _properties );
		}
	}
});
