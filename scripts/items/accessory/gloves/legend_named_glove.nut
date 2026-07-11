this.legend_named_glove <- this.inherit("scripts/items/accessory/gloves/legend_glove_item", {
	m = {
		PrefixList = this.Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true,
		Properties = {}
	},

	function create() {
		this.legend_glove_item.create();
		this.m.ItemType = this.Const.Items.ItemType.Brawler | this.Const.Items.ItemType.Named;
	}

	function getRandomCharacterName(_list) {
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[::Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[::Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(_list[::Math.rand(0, _list.len() - 1)], vars);
	}

	function createRandomName() {
		if (!this.m.UseRandomName || ::Math.rand(1, 100) <= 75) {
			if (::Math.rand(1, 100) <= 20) {
				return "";
			} else {
				return this.m.PrefixList[::Math.rand(0, this.m.PrefixList.len() - 1)] + " ";
			}
		} else if (::Math.rand(1, 2) == 1) {
			return this.getRandomCharacterName(::Const.Strings.KnightNames) + "\'s ";
		} else {
			return this.getRandomCharacterName(::Const.Strings.BanditLeaderNames) + "\'s ";
		}
	}

	function onEquip() {
		this.legend_glove_item.onEquip();

		if (this.m.Name.len() == 0) {
			if ((::Math.rand(1, 100) <= 25)
				&& (this.getArmor().getContainer().getActor() != null))
			{
				this.setName(this.getArmor().getContainer().getActor().getName() + "\'s ");
			} else {
				this.setName(this.createRandomName());
			}
		}
	}

	function onAddedToStash(_stashID) {
		if (this.m.Name.len() == 0) {
			this.setName(this.createRandomName());
		}
	}

	function setName(_prefix = "") {
		this.m.Name = _prefix + this.m.NameList[::Math.rand(0, this.m.NameList.len() - 1)];
	}

	function getTooltip() {
		local result = this.legend_glove_item.getTooltip();

		foreach (k, p in this.m.Properties)	{
			if (this.m[k] == p)
				continue;

			foreach (tooltip in result) {
				if (!tooltip.rawin("icon"))
					continue;

				if (!::Legends.Items.Named.HighlightNamedRoll[k].isRightTooltip(tooltip, this.m.properties, "gloves"))
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

	function randomizeValues() {
		if (this.m.Properties.len() == 0) {
			this.m.Properties.RegularDamage <- this.m.RegularDamage;
			this.m.Properties.RegularDamageMax <- this.m.RegularDamageMax;
			this.m.Properties.ChokeMin <- this.m.ChokeMin;
			this.m.Properties.ChokeMax <- this.m.ChokeMax;
			this.m.Properties.ArmorDamageMult <- this.m.ArmorDamageMult;
			this.m.Properties.DirectDamageMult <- this.m.DirectDamageMult;
			this.m.Properties.StaminaModifier <- this.m.StaminaModifier;
		}

		local ranges = ::Legends.Items.Named.randomizeRanges;

		local available = [];
		available.push(function (_i) {
			local f = ::Math.rand(ranges.RegularDamage[0], ranges.RegularDamage[1]) * 0.01;
			_i.m.RegularDamage = ::Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = ::Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function (_i) {
			local f = ::Math.rand(ranges.RegularDamage[0], ranges.RegularDamage[1]) * 0.01;
			_i.m.ChokeMin = ::Math.round(_i.m.ChokeMin * f);
			_i.m.ChokeMax = ::Math.round(_i.m.ChokeMax * f);
		});
		available.push(function (_i) {
			_i.m.ArmorDamageMult = _i.m.ArmorDamageMult + ::Math.rand(ranges.ArmorDamageMultGloves[0], ranges.ArmorDamageMultGloves[1]) * 0.01;
		});
		available.push(function ( _i ) {
			_i.m.DirectDamageMult = _i.m.DirectDamageMult + ::Math.rand(ranges.DirectDamageMultGloves[0], ranges.DirectDamageMultGloves[1]) * 0.01;
		});
		available.push(function (_i) {
			_i.m.StaminaModifier = ::Math.round(_i.m.StaminaModifier * ::Math.rand(ranges.StaminaModifierGloves[0], ranges.StaminaModifierGloves[1]) * 0.01);
		});

		for (local n = 2; n != 0 && available.len() != 0; n = --n) {
			local r = ::Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}

	function onSerialize(_out) {
		this.legend_glove_item.onSerialize(_out);
		_out.writeString(this.m.Name);
		_out.writeU16(this.m.RegularDamage);
		_out.writeU16(this.m.RegularDamageMax);
		_out.writeU16(this.m.ChokeMin);
		_out.writeU16(this.m.ChokeMax);
		_out.writeF32(this.m.ArmorDamageMult);
		_out.writeF32(this.m.DirectDamageMult);
	}

	function onDeserialize(_in) {
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
