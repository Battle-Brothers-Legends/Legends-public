this.legend_named_helmet <- this.inherit("scripts/items/legend_helmets/legend_helmet", {
	m = {
		PrefixList = ::Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true
	},
	function create()
	{
		this.legend_helmet.create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Named;
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
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
		local result = this.legend_helmet.getTooltip();
		if (this.m.Upgrades.filter(@(_, u) u != null).len() == 0) {
    		::Legends.Items.Named.ShowArmorPotential(this, result);
		}
    	return result;
	}

	function onEquip()
	{
		this.legend_helmet.onEquip();

		if (this.m.Name.len() == 0)
		{
			if (::Math.rand(1, 100) <= 25 && !this.getContainer().getActor() == null)
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
		this.m.Vision = ::Math.rand(this.m.Potential.Vision.max, this.m.Potential.Vision.min) * -1;
		this.m.StaminaModifier = ::Math.rand(this.m.Potential.StaminaModifier.max, this.m.Potential.StaminaModifier.min) * -1;
		this.m.Condition = ::Math.rand(this.m.Potential.Condition.min, this.m.Potential.Condition.max);
		this.m.ConditionMax = this.m.Condition;
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeI8(this.m.Vision);
		this.legend_helmet.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.m.Vision = _in.readI8();
		this.legend_helmet.onDeserialize(_in);
		this.updateVariant();
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}

});

