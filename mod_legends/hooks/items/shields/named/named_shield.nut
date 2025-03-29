::mods_hookExactClass("items/shields/named/named_shield", function(o) {
	o.m.BaseProperties <- {};

	o.getTooltip <- function ()
	{
		local result = this.shield.getTooltip();

		foreach (k, p in this.m.BaseProperties)
		{
			if (this.m[k] == p)
				continue;

			foreach (tooltip in result)
			{
				if (!tooltip.rawin("icon"))
					continue;

				if (!::Const.HighlightNamedRoll[k].isRightTooltip(tooltip))
					continue;

				tooltip.icon = ::Const.HighlightNamedRoll[k].Icon;
				break;
			}
		}

		return result;
	}

	o.randomizeValues = function ()
	{
		if (this.m.BaseProperties.len() == 0)
		{
			this.m.BaseProperties.ConditionMax <- this.m.ConditionMax;
			this.m.BaseProperties.MeleeDefense <- this.m.MeleeDefense;
			this.m.BaseProperties.RangedDefense <- this.m.RangedDefense;
			this.m.BaseProperties.StaminaModifier <- this.m.StaminaModifier;
			this.m.BaseProperties.FatigueOnSkillUse <- this.m.FatigueOnSkillUse;
		}

		local available = [];
		available.push(function ( _i )
		{
			_i.m.MeleeDefense = this.Math.round(_i.m.MeleeDefense * this.Math.rand(130, 150) * 0.01);
		});
		available.push(function ( _i )
		{
			_i.m.RangedDefense = this.Math.round(_i.m.RangedDefense * this.Math.rand(130, 150) * 0.01);
		});
		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});
		available.push(function ( _i )
		{
			_i.m.Condition = this.Math.round(_i.m.Condition * this.Math.rand(150, 200) * 0.01) * 1.0;
			_i.m.ConditionMax = _i.m.Condition;
		});
		available.push(function ( _i )
		{
			_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(60, 90) * 0.01);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}

	o.onDeserialize = function ( _in )
	{
		this.m.ConditionMax = _in.readF32();
		this.shield.onDeserialize(_in);
		this.m.Name = _in.readString();
		this.m.StaminaModifier = _in.readI8();
		this.m.MeleeDefense = _in.readU16();
		this.m.RangedDefense = _in.readU16();
		this.m.FatigueOnSkillUse = _in.readI16();
	}
});
