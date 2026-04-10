::mods_hookExactClass("entity/tactical/humans/barbarian_chosen", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBalance);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
		this.m.Hitpoints = b.Hitpoints * 1.25;
		::Legends.S.scaleBaseProperties(b);
	}

	o.assignRandomEquipment = function ()
	{
		local weapons = [
			"weapons/named/legend_named_rusty_serrated_axe",
			"weapons/named/legend_named_rusty_warcleaver",
			"weapons/named/legend_named_horn_decorated_mace",
			"weapons/named/legend_named_rusty_greatsword"
		];
		local armor = this.Const.Items.NamedBarbarianArmors;
		local helmets = this.Const.Items.NamedBarbarianHelmets;
		local runeSelection = [];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		runeSelection = [
			::Legends.Rune.LegendRswBleeding,
			::Legends.Rune.LegendRswPoison,
			::Legends.Rune.LegendRswAccuracy,
			::Legends.Rune.LegendRswPower
		];

		local selected = runeSelection[this.Math.rand(0, runeSelection.len() - 1)];
		local rune = ::new(::Legends.Runes.get(selected).Script);
		rune.setRuneVariant(selected);
		rune.setRuneBonus(this.m.IsMiniboss);
		rune.updateRuneSigilToken();
		rune.onUse(this, null, false);

		local weightName = this.Const.World.Common.convNameToList(armor);
		this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		runeSelection = [
			::Legends.Rune.LegendRshBravery,
			::Legends.Rune.LegendRsaEndurance,
			::Legends.Rune.LegendRsaSafety
		];

		selected = runeSelection[this.Math.rand(0, runeSelection.len() - 1)];
		rune = ::new(::Legends.Runes.get(selected).Script);
		rune.setRuneVariant(selected);
		rune.setRuneBonus(this.m.IsMiniboss);
		rune.updateRuneSigilToken();
		rune.onUse(this, null, false);

		weightName = this.Const.World.Common.convNameToList(helmets);
		this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		runeSelection = [
			::Legends.Rune.LegendRshClarity,
			::Legends.Rune.LegendRshBravery,
			::Legends.Rune.LegendRshLuck
		];

		local selected = runeSelection[this.Math.rand(0, runeSelection.len() - 1)];
		local rune = ::new(::Legends.Runes.get(selected).Script);
		rune.setRuneVariant(selected);
		rune.setRuneBonus(this.m.IsMiniboss);
		rune.updateRuneSigilToken();
		rune.onUse(this, null, false);
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}
});
