this.legend_named_armor <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {
		PrefixList = ::Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true
	},
	function create()
	{
		this.legend_armor.create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Named;
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.blockUpgrades();
		this.m.Blocked[ ::Const.Items.ArmorUpgrades.Attachment] = false;
		this.m.Blocked[ ::Const.Items.ArmorUpgrades.Rune] = false;
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
		this.legend_armor.onEquip();

		if (this.m.Name.len() == 0)
		{
			if (::Math.rand(1, 100) <= 25)
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
		this.m.Name = _prefix + this.m.NameList[::Math.rand(0, this.m.NameList.len() - 1)];
	}

	function randomizeValues() {
		this.m.StaminaModifier = ::Math.rand(this.m.Potential.StaminaModifier.max, this.m.Potential.StaminaModifier.min) * -1;
		this.m.Condition = ::Math.rand(this.m.Potential.Condition.min, this.m.Potential.Condition.max);
		this.m.ConditionMax = this.m.Condition;
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		this.legend_armor.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.legend_armor.onDeserialize(_in);
		this.updateVariant();
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}

});

