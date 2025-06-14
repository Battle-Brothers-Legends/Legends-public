this.legend_craftable_kraken_shield <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {
		RegularDamage = 10,
		RegularDamageMax = 15,
	},
	function create()
	{
		this.named_shield.create();
		this.m.ID = "shield.legend_craftable_kraken";
		this.m.Name = "Kraken Shield";
		this.m.NameList = this.Const.Strings.ShieldNames;
		this.m.Description = "This shield, carved out of a horn plate taken from a giant kraken, is stronger than any common shield.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 9;
		this.updateVariant();
		this.m.Value = 1200;
		this.randomizeValues();
		this.resetStats();
	}

	function resetStats() {
		this.m.MeleeDefense = 24;
		this.m.RangedDefense = 24;
		this.m.StaminaModifier = -15;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_named_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_named_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_named_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_named_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_named_shield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Shieldwall);
		::Legends.Actives.grant(this, ::Legends.Active.KnockBack, function (_skill) {
			_skill.setDamage(this.m.RegularDamage, this.m.RegularDamageMax);
		}.bindenv(this));
	}

	function randomizeValues()
	{
		if (this.m.BaseProperties.len() == 0)
		{
			this.m.BaseProperties.ConditionMax <- this.m.ConditionMax;
			this.m.BaseProperties.MeleeDefense <- this.m.MeleeDefense;
			this.m.BaseProperties.RangedDefense <- this.m.RangedDefense;
			this.m.BaseProperties.StaminaModifier <- this.m.StaminaModifier;
			this.m.BaseProperties.FatigueOnSkillUse <- this.m.FatigueOnSkillUse;
			this.m.BaseProperties.RegularDamageMax <- this.m.RegularDamageMax;
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

		available.push(function ( _i )
		{
			local f = this.Math.rand(130, 180) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}

	function onSerialize( _out )
	{
		this.named_shield.onSerialize(_out);
		_out.writeU16(this.m.RegularDamage);
		_out.writeU16(this.m.RegularDamageMax);
	}

	function onDeserialize( _in )
	{
		this.named_shield.onDeserialize(_in);
		this.m.RegularDamage = _in.readU16();
		this.m.RegularDamageMax = _in.readU16();
	}

});

