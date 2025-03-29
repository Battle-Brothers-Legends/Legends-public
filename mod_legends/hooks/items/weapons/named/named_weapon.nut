::mods_hookExactClass("items/weapons/named/named_weapon", function(o) {
	o.m.BaseProperties <- {};
	o.m.PossibleEffects <- [];
	o.m.EffectBounds <- [];
	o.m.EffectChanceOrBonus <- 0;
	o.m.PossibleEffectIdx <- -1;

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();

		if (this.m.PossibleEffectIdx >= 0)
		{
			local s = this.new(this.m.PossibleEffects[this.m.PossibleEffectIdx]);
			s.setBonus(this.m.EffectChanceOrBonus);
			this.addSkill(s);
		}
	}

	o.getTooltip <- function ()
	{
		local result = this.weapon.getTooltip();

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
			this.m.BaseProperties.RegularDamageMax <- this.m.RegularDamageMax;
			this.m.BaseProperties.ArmorDamageMult <- this.m.ArmorDamageMult;
			this.m.BaseProperties.ChanceToHitHead <- this.m.ChanceToHitHead;
			this.m.BaseProperties.DirectDamageAdd <- this.m.DirectDamageAdd;
			this.m.BaseProperties.StaminaModifier <- this.m.StaminaModifier;
			this.m.BaseProperties.ShieldDamage <- this.m.ShieldDamage;
			this.m.BaseProperties.AmmoMax <- this.m.AmmoMax;
			this.m.BaseProperties.AdditionalAccuracy <- this.m.AdditionalAccuracy;
			this.m.BaseProperties.FatigueOnSkillUse <- this.m.FatigueOnSkillUse;
		}

		if (this.m.ConditionMax > 1)
		{															//Vanilla = 90, 140. I think this is bullshit. - Luft
			this.m.Condition = this.Math.round(this.m.Condition * this.Math.rand(110, 140) * 0.01) * 1.0;
			this.m.ConditionMax = this.m.Condition;
		}

		local available = [];
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function ( _i )
		{
			_i.m.ArmorDamageMult = _i.m.ArmorDamageMult + this.Math.rand(10, 30) * 0.01;
		});

		if (this.m.ChanceToHitHead > 0)
		{
			available.push(function ( _i )
			{
				_i.m.ChanceToHitHead = _i.m.ChanceToHitHead + this.Math.rand(10, 20);
			});
		}

		available.push(function ( _i )
		{
			_i.m.DirectDamageAdd = _i.m.DirectDamageAdd + this.Math.rand(8, 16) * 0.01;
		});

		if (this.m.StaminaModifier <= -10)
		{
			available.push(function ( _i )
			{
				_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(50, 80) * 0.01);
			});
		}

		if (this.m.ShieldDamage >= 16)
		{
			available.push(function ( _i )
			{
				_i.m.ShieldDamage = this.Math.round(_i.m.ShieldDamage * this.Math.rand(150, 200) * 0.01);
			});
		}

		if (this.m.AmmoMax > 0)
		{
			available.push(function ( _i )
			{
				_i.m.AmmoMax = _i.m.AmmoMax + this.Math.rand(1, 3);
				_i.m.Ammo = _i.m.AmmoMax;
			});
		}

		if (this.m.AdditionalAccuracy != 0 || this.isItemType(this.Const.Items.ItemType.RangedWeapon))
		{
			available.push(function ( _i )
			{
				_i.m.AdditionalAccuracy = _i.m.AdditionalAccuracy + this.Math.rand(5, 15);
			});
		}

		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});

		if ( this.m.PossibleEffects.len() > 0 )
		{
			available.push(function ( _i )
			{
				_i.m.PossibleEffectIdx = ::Math.rand( 0, _i.m.PossibleEffects.len() - 1 );
				_i.m.EffectChanceOrBonus = ::Math.rand( _i.m.EffectBounds[_i.m.PossibleEffectIdx][0], _i.m.EffectBounds[_i.m.PossibleEffectIdx][1] );
			});
		}


		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}

	o.onSerialize = function ( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeU16(this.m.RegularDamage);
		_out.writeU16(this.m.RegularDamageMax);
		_out.writeF32(this.m.ArmorDamageMult);
		_out.writeU8(this.m.ChanceToHitHead);
		_out.writeU16(this.m.ShieldDamage);
		_out.writeI16(this.m.AdditionalAccuracy);
		_out.writeF32(this.m.DirectDamageAdd);
		_out.writeI16(this.m.FatigueOnSkillUse);
		_out.writeU16(this.m.AmmoMax);
		_out.writeI8(this.m.PossibleEffectIdx);
		_out.writeI8(this.m.EffectChanceOrBonus);
		//_out.writeF32(0);
		this.weapon.onSerialize(_out);
	}

	o.onDeserialize = function ( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.m.RegularDamage = _in.readU16();
		this.m.RegularDamageMax = _in.readU16();
		this.m.ArmorDamageMult = _in.readF32();
		this.m.ChanceToHitHead = _in.readU8();
		this.m.ShieldDamage = _in.readU16();
		this.m.AdditionalAccuracy = this.Const.Serialization.Version <= 63 ? _in.readU16() : _in.readI16();
		this.m.DirectDamageAdd = _in.readF32();
		this.m.FatigueOnSkillUse = _in.readI16();
		this.m.AmmoMax = _in.readU16();
		this.m.PossibleEffectIdx = _in.readI8();
		this.m.EffectChanceOrBonus = _in.readI8();
		//_in.readF32();
		this.weapon.onDeserialize(_in);
		this.updateVariant();
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}
});
