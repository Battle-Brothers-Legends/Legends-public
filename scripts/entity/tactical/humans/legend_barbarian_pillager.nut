this.legend_barbarian_pillager <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendBarbarianPillager;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendBarbarianPillager.XP;
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
		b.setValues(this.Const.Tactical.Actor.LegendBarbarianPillager);
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
			"scripts/items/weapons/barbarians/heavy_throwing_axe",
			"scripts/items/weapons/barbarians/heavy_javelin",
			"scripts/items/weapons/barbarians/legend_barbarian_sling",
			"scripts/items/weapons/barbarians/legend_barbarian_sling",
			"scripts/items/weapons/throwing_spear",
			"scripts/items/weapons/throwing_axe"
		];

		this.m.Items.equip(this.new(items[this.Math.rand(0, items.len() - 1)]));

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
		}

		items = [
			"scripts/items/weapons/barbarians/axehammer",
			"scripts/items/weapons/barbarians/crude_axe",
			"scripts/items/weapons/barbarians/blunt_cleaver"
		];

		this.m.Items.addToBag(this.new(items[this.Math.rand(0, items.len() - 1)]));

		local armor = [
			[33, ::Legends.Armor.Barbarian.scrap_metal_armor],
			[34, ::Legends.Armor.Barbarian.hide_and_bone_armor],
			[33, ::Legends.Armor.Barbarian.reinforced_animal_hide_armor],
			[5, ::Legends.Armor.Barbarian.legend_barbarian_southern_armor]
		];

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		local helmet = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.leather_headband],
			[1, ::Legends.Helmet.Barbarian.bear_headpiece],
			[1, ::Legends.Helmet.Barbarian.leather_helmet],
			[1, ::Legends.Helmet.Barbarian.crude_metal_helmet],
			[1, ""]
		]);
		if (helmet != null)
		{
			this.m.Items.equip(helmet);
		}
	}

});
