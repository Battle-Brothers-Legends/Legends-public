this.legend_peasant_poacher <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantPoacher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantPoacher.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantPoacher);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShortbowSkill);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShortbowDamage);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Bullseye);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SpecBow);
		this.getSprite("socket").setBrush("bust_base_militia");

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Overwhelm);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBallistics);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	function assignRandomEquipment()
	{
		local r;
		local weapons = [
			[
				"weapons/short_bow",
				"ammo/quiver_of_arrows"
			],
			[
				"weapons/short_bow",
				"ammo/quiver_of_arrows"
			]
		];
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "thick_tunic"],
			[8, "linen_tunic"]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				// [1, "hunters_hat"],
				[3, "hood"]
			]))
		}
	}

});

