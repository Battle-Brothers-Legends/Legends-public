this.legend_named_armor_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {
		PrefixList = ::Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true
	},
	function create()
	{
		this.legend_armor_upgrade.create();
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

	function getTooltip(){
		local result = this.legend_armor_upgrade.getTooltip();
		::Legends.Items.Named.ShowArmorPotential(this, result);

    	return result;
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
		this.legend_armor_upgrade.onEquip();

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
		this.m.StaminaModifier = ::Math.rand(this.m.Potential.StaminaModifier.max, this.m.Potential.StaminaModifier.min) * -1;
		this.m.Condition = ::Math.rand(this.m.Potential.Condition.min, this.m.Potential.Condition.max);
		this.m.ConditionMax = this.m.Condition;
		if ("DirectDamageModifier" in this.m.Potential) {
			this.m.DirectDamageModifier = ::Math.rand(this.m.Potential.DirectDamageModifier.min, this.m.Potential.DirectDamageModifier.max) * -1.0;
		}
		if ("ResolveMultiplier" in this.m.Potential) {
			this.m.ResolveMultiplier = ::Math.rand(this.m.Potential.ResolveMultiplier.min, this.m.Potential.ResolveMultiplier.max) * 0.01;
		}
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		this.legend_armor_upgrade.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.legend_armor_upgrade.onDeserialize(_in);
	}

});

