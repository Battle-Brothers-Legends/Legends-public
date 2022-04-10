this.legend_companion_ranged_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_companion_ranged";
		this.m.Name = "Companion";
		this.m.Icon = "ui/traits/trait_icon_32.png";
		this.m.BackgroundDescription = "This one has lost all interest in glory and gold. With nothing else to prove but to themselves.";
		this.m.GoodEnding = "After {not much  more time | much more time later | a lifetime adrift | a short while | a few more months} after your retirement, %name% found {interest | their calling with | some hope with | work with} a {preacher | thief | vagabond | wildman | wise woman | crusader | odd trio of kids | haughty nobleman | ranger | people\'s militia | cultist band | northern raiding party | group of escaped slaves | hunting party of manhunters}, their time with you taught them {everything | most of what | all | a bit of what} they needed to survive in their new employment. They never spoke your name, but {their memory of you never faded | they go on to greater things in your memory}.";
		this.m.BadEnding = "Does it matter what happens to a single man or woman? As skilled as %name% was, they never made their mark with your early departure from %companyname%.";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.craven",
			"trait.dastard",
			"trait.disloyal",
			"trait.fainthearted",
			"trait.fat",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_beasts",
			"trait.greedy",
			"trait.weasel",
			"trait.fear_nobles",
			"trait.flabby",
			"trait.slack",
			"trait.double_tongued",
			"trait.clumsy"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.MeleeSkill
		];
		this.m.Ethnicity = this.Math.rand(0, 2);
		if (this.m.Ethnicity == 0)
		{
			this.m.Bodies = this.Const.Bodies.Muscular;			
			this.m.Faces = this.Const.Faces.AllWhiteMale;
			this.m.Hairs = this.Const.Hair.CommonMale;
			this.m.HairColors = this.Const.HairColors.All;
			this.m.Beards = this.Const.Beards.All;
			this.m.BeardChance = 60;
		}	
		else if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.Gladiator;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2)
		{
			this.m.Bodies = this.Const.Bodies.AfricanGladiator;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}

		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		

		this.m.PerkTreeDynamic = { //UBER TO DO - RANGED FOCUSED BRO
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.AxeTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
	} //UBER TO DO ABOVE

	//Default Male
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = 0;
			if (this.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r == 0)
		{
			return;
		}
		this.m.Ethnicity = this.Math.rand(0, 2);
		if (this.m.Ethnicity == 0)
		{
			this.m.Faces = this.Const.Faces.AllWhiteFemale;
			this.m.Hairs = this.Const.Hair.AllFemale;
			this.m.HairColors = this.Const.HairColors.All;
			this.m.Bodies = this.Const.Bodies.AllFemale;
		}	
		else if (this.m.Ethnicity == 1)
		{
			this.m.Faces = this.Const.Faces.SouthernFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.Young;
			this.m.Bodies = this.Const.Bodies.SouthernFemaleMuscular;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2)
		{
			this.m.Faces = this.Const.Faces.AfricanFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Bodies = this.Const.Bodies.AfricanFemaleMuscular;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}

		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		return "{Unnaturally skilled, | Born almost a master already, | Skilled enough to be considered supernatural,} {%name% has worked hard to refine their natural talent. | %name% has managed to stay above ground by honing their natural skill. | %name% claims their skill is as natural as yours.} {Eitherway, %they% deomstrates a honed mind and body to match. | They pull and notch their bowstring with an ease that would take years for you to learn yourself. | Hailing from %randomtown%, they have gone far and wide to test their skills. | Urged by %their% parents to stay away from knights and mercenaries, they took time to travel and see the world. | One thing has led to another, %they% can barely recall what led them here in the first place.} {With no interest in work for crowns, %name% has found it fitting to join you on your journey. | Likely to be used as fodder, bait or a shield made of flesh by any mercenary company, %name% decided to stick with you instead. | %name% has much more to learn still, and your journey through the lands is the best way to test their skills.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [ //THIS BACKGROUND GAINS EXTRA STATS IN RECRUITMENT EVENTS DEPENDING ON PLAYER CHOICES
				5,
				5
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				3,
				3
			],
			MeleeSkill = [
				-5,
				0
			],
			RangedSkill = [
				10,
				5
			],
			MeleeDefense = [
				-3,
				0
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				10,
				5
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 75)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function onAddEquipment()
	{
		//---
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 1;
		talents[this.Const.Attributes.RangedDefense] = 1;
		this.getContainer().getActor().fillTalentValues(2, true);
		//---
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(0, 16);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_sling"));
			items.addToBag(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/javelin"));
			items.addToBag(this.new("scripts/items/weapons/shortsword"));		
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/throwing_axe"));	
			items.equip(this.new("scripts/items/shields/heater_shield"));
			items.addToBag(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/throwing_spear"));
			items.equip(this.new("scripts/items/tools/daze_bomb_item"));
			items.addToBag(this.new("scripts/items/weapons/oriental/saif"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			items.addToBag(this.new("scripts/items/weapons/rondel_dagger"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			items.addToBag(this.new("scripts/items/weapons/rondel_dagger"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/legend_slingstaff"));
			items.addToBag(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 8)
		{
			items.equip(this.new("scripts/items/weapons/legend_slingshot"));
			items.addToBag(this.new("scripts/items/weapons/flail"));
			items.addToBag(this.new("scripts/items/tools/smoke_bomb_item"));
		}
		else if (r == 9)
		{
			items.equip(this.new("scripts/items/weapons/legend_sling"));
			items.equip(this.new("scripts/items/shields/legend_tower_shield"));
			items.addToBag(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 10)
		{
			items.equip(this.new("scripts/items/weapons/war_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			items.addToBag(this.new("scripts/items/weapons/legend_saw"));
		}
		else if (r == 11)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			items.addToBag(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 12)
		{
			items.equip(this.new("scripts/items/weapons/wonky_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			items.addToBag(this.new("scripts/items/weapons/legend_staff"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "mercenary_crossbow_outfit_00"],
			[1, "mercenary_longbow_outfit_00"],
			[1, "mercenary_spearman_outfit_00"],
			[1, "mercenary_spearman_outfit_01"],
			[1, "mercenary_leader_outfit_uncommon_00"],
			[1, "mercenary_leader_outfit_00"],
			[1, "mercenary_billman_outfit_00"]
		]))
	}

	function onUpdate( _properties )
	{
	}

});

