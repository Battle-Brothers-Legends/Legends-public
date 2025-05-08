this.legend_poacher_guest <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function isReallyKilled( _fatalityType )
	{
		return true;
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantPoacher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantPoacher.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = this.Const.Faces.WildFemale;
		}
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantPoacher);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
		this.m.Title = "the Poacher";
		this.setAppearance();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistPoacher);
		::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecBow);
		this.getSprite("socket").setBrush("bust_base_militia");

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function assignRandomEquipment()
	{
		this.getItems().equip(this.new("scripts/items/weapons/short_bow"));
		this.getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.getItems().addToBag(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.getItems().addToBag(this.new("scripts/items/weapons/hatchet"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.sackcloth]
		]));

		if (this.Math.rand(1, 100) <= 50)
		{
			this.getItems().equip(::Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.hood],
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.open_leather_cap],
				[1, ::Legends.Helmet.Standard.full_leather_cap]
			]))
		}
	}

});

