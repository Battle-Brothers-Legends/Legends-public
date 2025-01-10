this.legend_surgeon_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_surgeon";
		this.m.Name = "Surgeon";
		this.m.Icon = "ui/backgrounds/background_surgeon.png";
		this.m.BackgroundDescription = "A learned surgeon from the south, their knowledge of medicine outstrips those of the oldest monks and witches.";
		this.m.GoodEnding = "After finding near limitless work with %companyname%, %name% managed to hone their craft with every battle that passed. Their experience on the battlefield and cutting open more \'animated\' subjects left them with new ideas, which culminated in a book that was printed and reprinted for many years after %their% passing.";
		this.m.BadEnding = "%name% was a quick learner, but not qucker than the arrows, bolts, shrapnel and other assortment of dangers on the battlefield. After you left, %they% steadily accumulated injury after injury. Interrupted by expermintation on themselves to restore their mind and body. After one injury too many, they drank every mixture they could prepare to numb the pain. It worked, but not as %they% intended...";
		this.m.HiringCost = 0; //Found via holy war
		this.m.DailyCost = 45;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		];
		this.m.Titles = [
			"the Learner",
			"Quickmind",
			"the Surgeon",
			"the Study",
			"Goodhand",
			"the Hacksaw",
			"the Bright"
		];
		this.m.Ethnicity = this.Math.rand(1, 2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernMale;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
		}

		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);

		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Educated;
		
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[3];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[3];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[2];
		
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.InspirationalTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.HealerClassTree
			],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		if (this.m.Ethnicity == 1)
		{
			this.m.Faces = this.Const.Faces.SouthernFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.Young;
			this.m.Bodies = this.Const.Bodies.SouthernFemale;
		}
		else
		{
			this.m.Faces = this.Const.Faces.AfricanFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Bodies = this.Const.Bodies.AfricanFemale;
		}
		
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Experience Gain"
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female)) 
		{ //Female
			return "{Some women are born to be feared. %name% is not one of them. | Relatively normal in stature, %name% garners little attention from passers by. | Years of study and \'practical\' research has left %them% with a good understanding on how to make or unmake a man.} {The surgeon spent many a day tending to the Vizier\'s men, until the camp as overrun by northern armies. | Never intending to be a crownling, %name% finds themselves with little choice after wandering in the desert looking for help. | While %they% have never been in a serious fight in %their% life, %name% knows their way around cutting tools and isn\'t afraid of a little gore. | When ordered to kill the wounded who could not walk, %name% refused and found themselves thrown out of the camp. | After being captured by and tending to wounded nomads, %name% found some hospitality and provisions before they left %them% on the road.} {The war has made the worst come out from both sides, with her stuck in the middle.}";
		}
		else
		{ //Male
			return "{Some men are born to be feared. %name% is not one of them. | Relatively normal in stature, %name% garners little attention from passers by. | Years of study and \'practical\' research has left %them% with a good understanding on how to make or unmake a man.} {The surgeon spent many a day tending to the Vizier\'s men, until the camp as overrun by northern armies. | Never intending to be a crownling, %name% finds themselves with little choice after wandering in the desert looking for help. | While %they% have never been in a serious fight in %their% life, %name% knows their way around cutting tools and isn\'t afraid of a little gore. | When ordered to kill the wounded who could not walk, %name% refused and found themselves thrown out of the camp. | After being captured by and tending to wounded nomads, %name% found some hospitality and provisions before they left %them% on the road.} {The war has made the worst come out from both sides, with him stuck in the middle.}";
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				0
			],
			Bravery = [
				10,
				10
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				-5,
				0
			],
			MeleeDefense = [
				-3,
				-3
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_saw"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}	

		items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/vizier_gear"],
			[2, "oriental/cloth_sash"],
			[3, "butcher_apron"]
		]))

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ""],
			[1, "oriental/vizier_headgear"],
			[1, "oriental/engineer_hat"]
		]));
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.1;
	}

});

