this.legend_named_helmet_upgrade <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {
		PrefixList = ::Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true
	},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Named;
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

	function getTooltip(){
		local result = this.legend_helmet_upgrade.getTooltip();
		::Legends.Items.Named.ShowArmorPotential(this, result);

    	return result;
	}

	function onEquip()
	{
		this.legend_helmet_upgrade.onEquip();

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

	function randomizeValues() {
		this.m.Vision = ::Math.rand(this.m.Potential.Vision.max, this.m.Potential.Vision.min) * -1;
		this.m.StaminaModifier = ::Math.rand(this.m.Potential.StaminaModifier.max, this.m.Potential.StaminaModifier.min) * -1;
		this.m.Condition = ::Math.rand(this.m.Potential.Condition.min, this.m.Potential.Condition.max);
		this.m.ConditionMax = this.m.Condition;
	}
	function onSerialize( _out )
	{
		this.legend_helmet_upgrade.onSerialize(_out);
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeI8(this.m.Vision);

	}

	function onDeserialize( _in )
	{
		this.legend_helmet_upgrade.onDeserialize(_in);
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.m.Vision = _in.readI8();
	}

});

