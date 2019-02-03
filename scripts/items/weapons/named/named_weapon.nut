this.named_weapon <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		NameList = []
	},
	function create()
	{
		this.weapon.create();
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Named;
		this.m.IsDroppedWhenDamaged = true;
	}

	function getRandomCharacterName( _list )
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(_list[this.Math.rand(0, _list.len() - 1)], vars);
	}

	function createRandomName()
	{
		local r = this.Math.rand(1, 100);

		if (r <= 60)
		{
			return this.Const.Strings.RandomWeaponPrefix[this.Math.rand(0, this.Const.Strings.RandomWeaponPrefix.len() - 1)] + " ";
		}
		else if (this.Math.rand(1, 2) == 1)
		{
			return this.getRandomCharacterName(this.Const.Strings.KnightNames) + "\'s ";
		}
		else
		{
			return this.getRandomCharacterName(this.Const.Strings.BanditLeaderNames) + "\'s ";
		}
	}

	function onEquip()
	{
		this.weapon.onEquip();

		if (this.m.Name.len() == 0)
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				this.setName(this.getContainer().getActor().getName() + "\'s ");
			}
			else
			{
				this.setName(this.createRandomName());
			}
		}
	}

	function onAddedToStash( _stashID )
	{
		if (this.m.Name.len() == 0)
		{
			this.setName(this.createRandomName());
		}
	}

	function setName( _prefix = "" )
	{
		this.m.Name = _prefix + this.m.NameList[this.Math.rand(0, this.m.NameList.len() - 1)];
	}

	function randomizeValues()
	{
		for( local picked = []; picked.len() != 3;  )
		{
			local r = this.Math.rand(1, 8);

			if (picked.find(r) != null)
			{
				continue;
			}

			if (r != 8 || this.m.ShieldDamage > 0)
			{
				picked.push(r);
			}

			if (r == 1)
			{
				local f = this.Math.rand(110, 130) * 0.01;
				this.m.RegularDamage = this.Math.round(this.m.RegularDamage * f);
				this.m.RegularDamageMax = this.Math.round(this.m.RegularDamageMax * f);
			}
			else if (r == 2)
			{
				this.m.ArmorDamageMult = this.m.ArmorDamageMult + this.Math.rand(15, 35) * 0.01;
			}
			else if (r == 3)
			{
				this.m.ChanceToHitHead = this.m.ChanceToHitHead + this.Math.rand(5, 10);
			}
			else if (r == 5)
			{
				this.m.DirectDamageAdd = this.Math.rand(8, 16) * 0.01;
			}
			else if (r == 6)
			{
				this.m.Condition = this.Math.round(this.m.Condition * this.Math.rand(80, 140) * 0.01) * 1.0;
				this.m.ConditionMax = this.m.Condition;
			}
			else if (r == 7)
			{
				this.m.StaminaModifier = this.Math.round(this.m.StaminaModifier * this.Math.rand(50, 90) * 0.01);
			}
			else if (r == 8 && this.m.ShieldDamage > 0)
			{
				this.m.ShieldDamage = this.Math.round(this.m.ShieldDamage * this.Math.rand(110, 130) * 0.01);
			}
		}
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeU16(this.m.RegularDamage);
		_out.writeU16(this.m.RegularDamageMax);
		_out.writeF32(this.m.ArmorDamageMult);
		_out.writeU8(this.m.ChanceToHitHead);
		_out.writeU16(this.m.ShieldDamage);
		_out.writeU16(this.m.AdditionalAccuracy);
		_out.writeF32(this.m.DirectDamageAdd);
		_out.writeF32(0);
		_out.writeF32(0);
		this.weapon.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.m.RegularDamage = _in.readU16();
		this.m.RegularDamageMax = _in.readU16();
		this.m.ArmorDamageMult = _in.readF32();
		this.m.ChanceToHitHead = _in.readU8();
		this.m.ShieldDamage = _in.readU16();
		this.m.AdditionalAccuracy = _in.readU16();
		this.m.DirectDamageAdd = _in.readF32();
		_in.readF32();
		_in.readF32();
		this.weapon.onDeserialize(_in);
		this.updateVariant();
	}

});
