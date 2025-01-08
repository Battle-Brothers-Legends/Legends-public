this.legend_peasant_farmhand <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantFarmhand;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantFarmhand.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantFarmhand);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistPitchforkSkill);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistPitchforkDamage);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ReachAdvantage);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SpecPolearm);
		this.getSprite("socket").setBrush("bust_base_militia");
			if(::Legends.isLegendaryDifficulty())
			{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Steadfast);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Relentless);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Footwork);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 4);

		if (r <= 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
		}
		if (r >= 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
		}


		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "thick_tunic"],
			[8, "linen_tunic"]
		]));


		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, "straw_hat"],
				[1, "hood"]
			]))
		}
	}

});

