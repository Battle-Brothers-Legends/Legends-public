this.legend_peasant_butcher <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantButcher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantButcher.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_butcher_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantButcher);
		this.m.Hitpoints = b.Hitpoints;
		this.m.ActionPoints = b.ActionPoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistButcher);
		::Legends.Actives.grant(this, ::Legends.Active.LegendPrepareBleed);

		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[7, ::Legends.Armor.Standard.butcher_apron],
			[1, ::Legends.Armor.Standard.leather_wraps]
		]));


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.headscarf],
					[1, ::Legends.Helmet.Standard.hood],
					[1, ::Legends.Helmet.Standard.headscarf],
					[1, ::Legends.Helmet.Standard.feathered_hat]
				]))
			}
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_butchers_cleaver"));
		::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSlaughterer);
		::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistButcher);
		::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.legend_champion_butcher_helmet]
		]))
	}

});

