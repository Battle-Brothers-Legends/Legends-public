this.legend_barbarian_runechosen <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendBarbarianRunechosen;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendBarbarianRunechosen.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.WildMale;
		this.m.Hairs = ::Const.Hair.WildMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.setActor(this);
		this.m.OnDeathLootTable.extend([
			[5, "scripts/items/misc/legend_masterwork_fabric"],
			[5, "scripts/items/misc/legend_masterwork_metal"],
			[5, "scripts/items/misc/legend_masterwork_tools"]
		]);
		if (this.randomizeEnemyGender() == 1) {
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (::Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendBarbarianRunechosen);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		::Legends.Perks.grant(this, ::Legends.Perk.Adrenaline);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendWindReader);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Actives.grant(this, ::Legends.Active.BarbarianFury);
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
		this.m.Hitpoints = b.Hitpoints * 1.25;
		::Legends.S.scaleBaseProperties(b);
	}

	function generateName()
	{
		return ::Const.Strings.BarbarianNames[::Math.rand(0, ::Const.Strings.BarbarianNames.len() - 1)] + " " + ::Const.Strings.BarbarianTitles[::Math.rand(0, ::Const.Strings.BarbarianTitles.len() - 1)];
	}

	function assignRandomEquipment()
	{
		local wepr = ::Math.rand(1, 100);
		local weapons;
		if (wepr <= 1) {
			weapons = ::Const.Items.NamedBarbarianWeaponsHigh;
		}
		else if (wepr <= 6) {
			weapons = ::Const.Items.NamedBarbarianWeapons;
		}
		else {
			weapons = [
				"weapons/barbarians/skull_hammer",
				"weapons/barbarians/two_handed_spiked_mace",
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe"
			];
		}

		this.m.Items.equip(this.new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Barbarian.heavy_iron_armor],
			[1, ::Legends.Armor.Barbarian.thick_plated_barbarian_armor],
			[1, ::Legends.Armor.Barbarian.reinforced_heavy_iron_armor],
			[1, ::Legends.Armor.Standard.barbarian_chosen_armor_00],
			[1, ::Legends.Armor.Standard.barbarian_chosen_armor_01],
		]));

		this.m.Items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.closed_scrap_metal_helmet],
			[1, ::Legends.Helmet.Barbarian.heavy_horned_plate_helmet],
			[1, ::Legends.Helmet.Barbarian.barbarian_ritual_helmet],
			[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_00],
			[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_01],
			[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_02],
		]));
		local r = ::Math.rand(1, 3);
		local runeSelection = [];
		if (r == 1 || wepr <= 6) {
			runeSelection = [
				::Legends.Rune.LegendRswBleeding,
				::Legends.Rune.LegendRswPoison,
				::Legends.Rune.LegendRswAccuracy,
				::Legends.Rune.LegendRswPower
			];
		}
		else if (r == 2) {
			runeSelection = [
				::Legends.Rune.LegendRshBravery,
				::Legends.Rune.LegendRsaEndurance,
				::Legends.Rune.LegendRsaSafety
			];
		}
		else {
			runeSelection = [
				::Legends.Rune.LegendRshClarity,
				::Legends.Rune.LegendRshBravery,
				::Legends.Rune.LegendRshLuck
			];
		}

		local selected = runeSelection[::Math.rand(0, runeSelection.len() - 1)];
		local rune = ::new(::Legends.Runes.get(selected).Script);
		rune.setRuneVariant(selected);
		rune.setRuneBonus(this.m.IsMiniboss);
		rune.updateRuneSigilToken();
		rune.onUse(this, null, false);
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		local weapons = [
			"weapons/named/legend_named_rusty_serrated_axe",
			"weapons/named/legend_named_rusty_warcleaver",
			"weapons/named/legend_named_horn_decorated_mace",
			"weapons/named/legend_named_rusty_greatsword"
		];
		local armor = ::Const.Items.NamedBarbarianArmors;
		local helmets = ::Const.Items.NamedBarbarianHelmets;
		local r = ::Math.rand(1, 3);
		local runeSelection = [];
		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));
			runeSelection = [
				::Legends.Rune.LegendRswBleeding,
				::Legends.Rune.LegendRswPoison,
				::Legends.Rune.LegendRswAccuracy,
				::Legends.Rune.LegendRswPower
			];
		}
		else if (r == 2)
		{
			local weightName = ::Const.World.Common.convNameToList(armor);
			this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
			runeSelection = [
				::Legends.Rune.LegendRshBravery,
				::Legends.Rune.LegendRsaEndurance,
				::Legends.Rune.LegendRsaSafety
			];
		}
		else
		{
			local weightName = ::Const.World.Common.convNameToList(helmets);
			this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
			runeSelection = [
				::Legends.Rune.LegendRshClarity,
				::Legends.Rune.LegendRshBravery,
				::Legends.Rune.LegendRshLuck
			];
		}

		local selected = runeSelection[::Math.rand(0, runeSelection.len() - 1)];
		local rune = ::new(::Legends.Runes.get(selected).Script);
		rune.setRuneVariant(selected);
		rune.setRuneBonus(this.m.IsMiniboss);
		rune.updateRuneSigilToken();
		rune.onUse(this, null, false);

		return true;
	}

});
