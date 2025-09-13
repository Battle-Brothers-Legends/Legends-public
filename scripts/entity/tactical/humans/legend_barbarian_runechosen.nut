this.legend_barbarian_runechosen <- this.inherit("scripts/entity/tactical/human", {
	m = {
		ChosenRunes = [
			::Legends.Rune.LegendRsaEndurance,
			::Legends.Rune.LegendRsaSafety,
			::Legends.Rune.LegendRshBravery,
			::Legends.Rune.LegendRswBleeding,
			::Legends.Rune.LegendRswPoison,
			::Legends.Rune.LegendRswAccuracy,
			::Legends.Rune.LegendRswPower
		]
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendBarbarianRunechosen;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendBarbarianRunechosen.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function assignRune()
	{
		local selected = this.m.ChosenRunes[this.Math.rand(0, this.m.ChosenRunes.len() - 1)];
		local rune = ::new(::Legends.Runes.get(selected).Script);
		rune.setRuneVariant(selected);
		rune.setRuneBonus(true);
		rune.onUse(this, null);
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

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendBarbarianRunechosen);
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
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
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
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/skull_hammer",
				"weapons/barbarians/two_handed_spiked_mace",
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = [
				[1, ::Legends.Armor.Barbarian.thick_plated_barbarian_armor],
				[1, ::Legends.Armor.Barbarian.reinforced_heavy_iron_armor],
			];

			local helmet = [
				[1, ::Legends.Helmet.Barbarian.heavy_horned_plate_helmet],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_00],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_01],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_02],
			];

			local outfits = [
				[1, ::Legends.Outfit.barbarian_chosen_outfit_00],
				[1, ::Legends.Outfit.barbarian_chosen_outfit_01],
				[1, ::Legends.Outfit.barbarian_chosen_outfit_02]
			];

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}
			return;
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[1, ::Legends.Armor.Barbarian.thick_plated_barbarian_armor],
				[1, ::Legends.Armor.Barbarian.reinforced_heavy_iron_armor],
				[1, ::Legends.Armor.Standard.barbarian_chosen_armor_00],
				[1, ::Legends.Armor.Standard.barbarian_chosen_armor_01]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[1, ::Legends.Helmet.Barbarian.heavy_horned_plate_helmet],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_00],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_01],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_02],
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
		local selected = ::Legends.Runes[this.Math.rand(0, ::Legends.Runes.len() - 1)];
	}

	function makeMiniboss()
	{
		assignRune(); // make miniboss is always called so hopefully this works
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = this.Const.Items.NamedBarbarianWeapons;
		local armor = this.Const.Items.NamedBarbarianArmors;
		local helmets = this.Const.Items.NamedBarbarianHelmets;
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2)
		{
			local weightName = this.Const.World.Common.convNameToList(armor);
			this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		}
		else
		{
			local weightName = this.Const.World.Common.convNameToList(helmets);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		return true;
	}

});
