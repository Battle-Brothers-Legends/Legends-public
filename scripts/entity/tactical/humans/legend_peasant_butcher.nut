this.legend_peasant_butcher <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendPeasantButcher;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendPeasantButcher.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.AllMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_butcher_agent");
		this.m.AIAgent.setActor(this);
		if (this.randomizeEnemyGender() == 1) {
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendPeasantButcher);
		this.m.Hitpoints = b.Hitpoints;
		this.m.ActionPoints = b.ActionPoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistButcher);

		if(::Legends.isLegendaryDifficulty())
		{
			b.Hitpoints *= 1.25;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[7, ::Legends.Armor.Standard.butcher_apron],
			[1, ::Legends.Armor.Standard.leather_wraps]
		]));


		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			if (::Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(::Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.headscarf],
					[1, ::Legends.Helmet.Standard.hood],
					[1, ::Legends.Helmet.Standard.headscarf],
					[1, ::Legends.Helmet.Standard.feathered_hat]
				]));
			}
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSlaughterer);
		::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistButcher);
		::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		this.m.Items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.legend_champion_butcher_helmet]
		]));
	}

});

