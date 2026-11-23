this.legend_named_glove <- this.inherit("scripts/items/accessory/gloves/legend_glove_item", {
	m = {
		PrefixList = this.Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true
	},
	function create()
	{
		this.legend_glove_item.create();
		this.m.ItemType = this.Const.Items.ItemType.Brawler | this.Const.Items.ItemType.Named;
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
		if (!this.m.UseRandomName || this.Math.rand(1, 100) <= 75)
		{
			if (this.Math.rand(1, 100) <= 20)
			{
				return "";
			}
			else
			{
				return this.m.PrefixList[this.Math.rand(0, this.m.PrefixList.len() - 1)] + " ";
			}
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
		this.legend_glove_item.onEquip();

		if (this.m.Name.len() == 0)
		{
			if ((this.Math.rand(1, 100) <= 25) && (this.getArmor().getContainer().getActor() != null))
			{
				this.setName(this.getArmor().getContainer().getActor().getName() + "\'s ");
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
		local available = [];
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.ChokeMin = this.Math.round(_i.m.ChokeMin * f);
			_i.m.ChokeMax = this.Math.round(_i.m.ChokeMax * f);
		});
		available.push(function ( _i )
		{
			_i.m.ArmorDamageMult = _i.m.ArmorDamageMult + this.Math.rand(5, 15) * 0.01;
		});
		available.push(function ( _i )
		{
			_i.m.DirectDamageMult = _i.m.DirectDamageMult + this.Math.rand(5, 15) * 0.01;
		});
		available.push(function ( _i )
		{
			_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(40, 80) * 0.01);
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
		this.legend_glove_item.onSerialize(_out);
		_out.writeString(this.m.Name);
		_out.writeU16(this.m.RegularDamage);
		_out.writeU16(this.m.RegularDamageMax);
		_out.writeU16(this.m.ChokeMin);
		_out.writeU16(this.m.ChokeMax);
		_out.writeF32(this.m.ArmorDamageMult);
		_out.writeF32(this.m.DirectDamageMult);
	}

	function onDeserialize( _in )
	{
		this.legend_glove_item.onDeserialize(_in);
		this.m.Name = _in.readString();
		this.m.RegularDamage = _in.readU16();
		this.m.RegularDamageMax = _in.readU16();
		this.m.ChokeMin = _in.readU16();
		this.m.ChokeMax = _in.readU16();
		this.m.ArmorDamageMult = _in.readF32();
		this.m.DirectDamageMult = _in.readF32();
	}
});