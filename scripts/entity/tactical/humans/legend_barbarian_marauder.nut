this.legend_barbarian_marauder <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendBarbarianMarauder;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendBarbarianMarauder.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);
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
		b.setValues(this.Const.Tactical.Actor.LegendBarbarianMarauder);
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
		::Legends.Actives.grant(this, ::Legends.Active.BarbarianFury);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLithe);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.SpecThrowing);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPointBlank);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
		}
	}

	function assignRandomEquipment()
	{
		local items = [
			"scripts/items/weapons/barbarians/heavy_throwing_axe",
			"scripts/items/weapons/barbarians/heavy_javelin",
			"scripts/items/weapons/barbarians/legend_barbarian_sling"
		];

		this.m.Items.equip(this.new(items[this.Math.rand(0, items.len() - 1)]));

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items = [
			"scripts/items/weapons/barbarians/axehammer",
			"scripts/items/weapons/barbarians/crude_axe",
			"scripts/items/weapons/barbarians/blunt_cleaver"
		];

		this.m.Items.addToBag(this.new(items[this.Math.rand(0, items.len() - 1)]));

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
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/legend_named_heavy_throwing_axe",
			"weapons/named/legend_named_heavy_javelin",
			"weapons/named/legend_named_sling"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		return true;
	}

});
