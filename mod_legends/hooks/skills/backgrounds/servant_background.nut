::mods_hookExactClass("skills/backgrounds/servant_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.servant";
		this.m.Name = "Servant";
		this.m.Icon = "ui/backgrounds/background_16.png";
		this.m.BackgroundDescription = "Servants are not used to hard labour, but do have good knowledge of more mundane activities.";
		this.m.GoodEnding = "As it turns out, %name% the servant had been stowing away every last crown he had earned with the %companyname%. When he had enough, he retired and bought himself some land and slowly worked his way up the social ladder. He died in a comfortable bed, surrounded by friends, family, and loyal servants.";
		this.m.BadEnding = "%name% the servant grew tired of the sellsword life and left the company. He returned to serving nobility. When raiders attacked his liege\'s castle, the nobleman pushed the servant out the door with only a kitchen knife to defend himself with. He was found headless in a pile of broken chairs, a few dead raiders littered around him.";
		this.m.HiringCost = 45;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.SureFooting),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BarterClassTree,
				this.Const.Perks.ChefClassTree
			],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Name = "Housemaid";
		this.m.Icon = "ui/backgrounds/housemaid.png";
		this.m.BackgroundDescription = "Housemaids are not used to hard labour, but do have good knowledge of more mundane activities.";
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "As it turns out, %name% the housemaids had been stowing away every last crown she had earned with the %companyname%. When she had enough, she retired and bought herself some land and slowly worked her way up the social ladder. She died in a comfortable bed, surrounded by friends, family, and loyal servants.";
		this.m.BadEnding = "%name% the servant grew tired of the sellsword life and left the company. She returned to serving nobility. When raiders attacked her liege\'s castle, the nobleman pushed the housemaid out the door with only a kitchen knife to defend herself with. She was found headless in a pile of broken chairs, a few dead raiders littered around her.";
	}

	o.onBuildDescription = function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{Life is difficult. Moreso for some than others. | Some women can fall from grace. Other women have nowhere to fall to, having been born already on the ground. | If life is a throw of dice, maybe some are fools to be women rather than mice.} %name% {was a servant to a decadent lord. | served an abusive family where the kids played with fire. | was kidnapped by brigands and forced to serve their every. Last. Need. | worked feverishly for mad men who looked far too long at the stars.}  She rarely made a mistake about her place in the world. One day, though, her masters {beat her unconscious. When she awoke, she did so in the bed of a benevolent doctor who refused to return her to her \'employers\'. Instead, %name% was free to go and her masters were told she had died. | set her free, no questions asked. Not one to dally on ceremony, %name% left in earnest. | invited her to a party. Believing she was a guest, she showed up in her finest attire - a shirt with hemmed sleeves and a billowy dress that hid her skeletal frame well. Unfortunately, she was but a show for the party - they gave her a wooden shield and sword, threw her into an arena with a wild boar, and took bets as they watched the horrific spectacle. She barely escaped the \'festivities\'.} {%name% has since sworn to never \'serve\' someone again. | The woman, though now free of her duties, still bears a great deal of humiliation and pain from her long, hard life.}";
		}
		else
		{
			return "{Life is difficult. Moreso for some than others. | Some men can fall from grace. Other men have nowhere to fall to, having been born already on the ground. | If life is a throw of dice, maybe some are fools to be men rather than mice.} %name% {was a servant to a decadent lord. | served an abusive family where the kids played with fire. | was kidnapped by brigands and forced to serve their every. Last. Need. | worked feverishly for mad men who looked far too long at the stars.}  He rarely made a mistake about his place in the world. One day, though, his masters {beat him unconscious. When he awoke, he did so in the bed of a benevolent doctor who refused to return him to his \'employers\'. Instead, %name% was free to go and his masters were told he had died. | set him free, no questions asked. Not one to dally on ceremony, %name% left in earnest. | invited him to a party. Believing he was a guest, he showed up in his finest attire - a shirt with hemmed sleeves and a billowy set of pantaloons that hid his skeletal frame well. Unfortunately, he was but a show for the party - they gave him a wooden shield and sword, threw him into an arena with a wild boar, and took bets as they watched the horrific spectacle. He barely escaped the \'festivities\'.} {%name% has since sworn to never \'serve\' someone again. | The man, though now free of his duties, still bears a great deal of humiliation and pain from his long, hard life.}";
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-7,
				-2
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-7,
				-2
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				2,
				0
			],
			Initiative = [
				5,
				0
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "linen_tunic"]
		]))
	}
});

