this.legend_peasant_minstrel <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantMinstrel;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantMinstrel.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_minstrel_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 50)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMinstrel);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistLuteSkill);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistLuteDamage);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendEntice);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendDaze);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendDrumsOfWar);

		this.getSprite("socket").setBrush("bust_base_militia");
			if(::Legends.isLegendaryDifficulty())
			{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.Taunt);
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendDrumsOfLife);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 100);
		if (r == 1)
		{
		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_lute"));
		}
		else
		{
		this.m.Items.equip(this.new("scripts/items/weapons/lute"));
		}

		local r;
		r = this.Math.rand(1, 4);


		if (r >= 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_drum"));
		}

		local r;
		r = this.Math.rand(1, 10);
		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[9, "linen_tunic"]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, "feathered_hat"],
				[1, "hood"]
			]))
		}
	}

});

