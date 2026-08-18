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

				if (!::Legends.Items.Named.HighlightNamedRoll[k].isRightTooltip(tooltip, this.m.BaseProperties, "shield"))
					continue;

				tooltip.icon = ::Legends.Items.Named.HighlightNamedRoll[k].Icon;
				if (::Legends.Mod.ModSettings.getSetting("ShowPotentialOnItems").getValue()) {
					tooltip.text += ::Legends.Items.Named.HighlightNamedRoll[k].Text;
				}
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
			this.m.BaseProperties.RegularDamage <- this.m.RegularDamage;
			this.m.BaseProperties.RegularDamageMax <- this.m.RegularDamageMax;
			this.m.BaseProperties.Block <- this.m.Block;
		}

		local ranges = ::Legends.Items.Named.randomizeRanges;

		if (this.m.StaminaModifier < -1) {
			this.m.StaminaModifier = this.Math.round(this.m.StaminaModifier * this.Math.rand(ranges.StaminaModifierShield[0], ranges.StaminaModifierShield[1]) * 0.01);
		}

		local available = [];
		available.push(function(_i) {
			_i.m.MeleeDefense = this.Math.round(_i.m.MeleeDefense * ::Math.rand(ranges.MeleeDefense[0], ranges.MeleeDefense[1]) * 0.01);
		});
		available.push(function(_i) {
			_i.m.RangedDefense = this.Math.round(_i.m.RangedDefense * this.Math.rand(ranges.RangedDefense[0], ranges.RangedDefense[1]) * 0.01);
		});
		available.push(function(_i) {
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(ranges.FatigueOnSkillUse[0], ranges.FatigueOnSkillUse[1]);
		});
		available.push(function(_i) {
			_i.m.Condition = this.Math.round(_i.m.Condition * this.Math.rand(ranges.ConditionShield[0], ranges.ConditionShield[1]) * 0.01) * 1.0;
			_i.m.ConditionMax = _i.m.Condition;
		});
		available.push(function ( _i ) {
			local f = ::Math.rand(ranges.RegularDamage[0], ranges.RegularDamage[1]) * 0.01;
			_i.m.RegularDamage = ::Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = ::Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function(_i) {
			_i.m.Block = this.Math.round(_i.m.Block * this.Math.rand(ranges.Block[0], ranges.Block[1]) * 0.01);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}

		this.m.Block = this;
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out ) {
		onSerialize( _out );
		_out.writeU16(this.m.Block);
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
		this.m.Block = _in.readU16();
	}
});
