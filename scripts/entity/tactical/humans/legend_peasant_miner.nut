this.legend_peasant_miner <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantMiner;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantMiner.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMiner);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistMiner);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecHammer);
		this.getSprite("socket").setBrush("bust_base_militia");
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
			::Legends.Perks.grant(this, ::Legends.Perk.Indomitable);
			::Legends.Perks.grant(this, ::Legends.Perk.Recover);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[8, ::Legends.Armor.Standard.linen_tunic]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, ::Legends.Helmet.Standard.mouth_piece],
				[1, ::Legends.Helmet.Standard.hood]
			]))
		}
	}

});

