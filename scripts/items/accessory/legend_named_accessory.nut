this.legend_named_accessory <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		PrefixList = ::Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true
	},
	function create()
	{
		this.accessory.create();
		this.m.ItemType = ::Const.Items.ItemType.Accessory | ::Const.Items.ItemType.Named;
	}

	function getRandomCharacterName( _list )
	{
		local vars = [
			[
				"randomname",
				::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				::Const.World.LocationNames.VillageWestern[::Math.rand(0, ::Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(_list[::Math.rand(0, _list.len() - 1)], vars);
	}

	function createRandomName()
	{
		if (!this.m.UseRandomName || ::Math.rand(1, 100) <= 75)
		{
			if (::Math.rand(1, 100) <= 20)
			{
				return "";
			}
			else
			{
				return this.m.PrefixList[::Math.rand(0, this.m.PrefixList.len() - 1)] + " ";
			}
		}
		else if (::Math.rand(1, 2) == 1)
		{
			return this.getRandomCharacterName(::Const.Strings.KnightNames) + "\'s ";
		}
		else
		{
			return this.getRandomCharacterName(::Const.Strings.BanditLeaderNames) + "\'s ";
		}
	}

	function onEquip()
	{
		this.accessory.onEquip();

		if (this.m.Name.len() == 0)
		{
			if ((::Math.rand(1, 100) <= 25) && (this.getArmor().getContainer().getActor() != null))
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
		this.m.Name = _prefix + this.m.NameList[::Math.rand(0, this.m.NameList.len() - 1)];
	}

	function onSerialize( _out )
	{
		this.accessory.onSerialize(_out);
		_out.writeString(this.m.Name);
	}

	function onDeserialize( _in )
	{
		this.accessory.onDeserialize(_in);
		this.m.Name = _in.readString();
	}
});
