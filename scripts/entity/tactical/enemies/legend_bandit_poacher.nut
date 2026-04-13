this.legend_bandit_poacher <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditPoacher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = this.Math.rand(150, 255);
		}

		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
		// ::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		// ::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		// if (::Legends.isLegendaryDifficulty())
		// 	{
		// 	::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
		// 	::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		// 	this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		// 	}

	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}


	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
	}
	// function assignRandomEquipment()
	// {
	// 	local weapons = [
	// 		[
	// 			"weapons/short_bow",
	// 			"ammo/quiver_of_arrows"
	// 		]
	// 	];

	// 	if (this.Const.DLC.Wildmen)
	// 	{
	// 		weapons.push([
	// 			"weapons/legend_dilapitated_sling"
	// 		]);
	// 	}

	// 	local n = this.Math.rand(0, weapons.len() - 1);

	// 	foreach( w in weapons[n] )
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/" + w));
	// 	}



	// 	if (this.Math.rand(1, 100) <= 50)
	// 	{
	// 		this.m.Items.addToBag(this.new("scripts/items/weapons/legend_shiv"));
	// 	}
	// 	else
	// 	{
	// 		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
	// 	}

	// 	local item = this.Const.World.Common.pickArmor([
	// 		[20, ::Legends.Armor.Standard.leather_wraps]
	// 	])
	// 	this.m.Items.equip(item);

	// 	if (this.Math.rand(1, 100) <= 50)
	// 	{
	// 		local item = this.Const.World.Common.pickHelmet([
	// 			[1, ::Legends.Helmet.Standard.headscarf],
	// 			[1, ::Legends.Helmet.Standard.mouth_piece]
	// 		])
	// 		if (item != null)
	// 		{
	// 			this.m.Items.equip(item);
	// 		}
	// 	}
	// }

});

