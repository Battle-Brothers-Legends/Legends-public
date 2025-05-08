::mods_hookExactClass("skills/backgrounds/slave_southern_background", function (o) {
	o.create = function ()
	{
		this.slave_background.create();
		this.m.GoodEnding = "You purchased %name% as an indebted for almost no gold and continued to pay him a \'slave\'s wage\' for his stay as a sellsword. He did make himself an effective fighter, no doubt believing it was better to be paid nothing and fight to stay alive than be paid nothing and give up and rot. After your departure, you heard that the %companyname% traveled south on a campaign and the indebted got a good chance to exact a fair bit of revenge on a number of enemies in his past. Thankfully, he does not consider you one such person despite having kept him enslaved.";
		this.m.BadEnding = "You purchased %name% as an indebted and after your retiring, he went on with the %companyname%. Word of the mercenary band\'s problems have trickled in, but nothing about the indebted\'s current situation. Knowing how this world works, he has either been put into the vanguard as fodder or perhaps even been sold off to recoup profits. Either way, the world isn\'t easy on a sellsword, and it isn\'t easy on an indebted, and the man is unfortunately both.";
		this.m.Ethnicity = this.Math.rand(1,2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernSkinny;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanSlave;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
		}
		this.m.BeardChance = 90;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Titles = [
			"the Enslaved",
			"the Prisoner",
			"the Unlucky",
			"the Indebted",
			"the Indebted",
			"the Indebted",
			"the Unfree",
			"the Criminal",
			"the Obedient",
			"the Shackled",
			"the Bound"
		]
	}

	o.onBuildDescription <- function ()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
			return "{Much of the southern city states float atop the expendable bodies of prisoners of war, criminals, and indebted, throngs of people who have slighted the Gilder or His followers and must \'earn\' salvation through hard work. %name% is one such unfortunate soul.} {Like a shocking many, %name% was not always a hunted woman. She worked as a traveling merchant until nomads ambushed her caravan. The nomads took her to a Vizier, pretending the woman a criminal, and sold her as a hunted woman. | Spotted for her beauty, %name% was kidnapped off the streets of %randomcitystate% and sold straight to a manipulative Vizier. She does not speak much of what all happened, but there is a sense manual labor was not her sole duty. | So great the religious transgressions of her predecessors, %name% was born into an indebted family, and it is uncertain how far back into her ancestry you must go before a truly free woman would be found. | Desperate to save her family from generational debt, %name% sold herself into indentured servitude to ensure her children have a life to live for themselves. | %name% swears she is from the north, but the deserts of the south have left her darkly tanned and, frankly, you\'ve not much reason to believe the words of a former prisoner of war no matter where she\'s from. | A once sea-farer, %name% spent years traveling from harbor to harbor to drive the goods of opulent merchants. Those who gave her to you stated she has a criminal past in piracy. | %name% was accused of ravishing an old man and was given the option of execution or lifelong servitude. | Caught stealing from a fruit stall, %name% was pressed into lifelong servitude. | Fornications with \'non-men\' led to %name%\'s submission to servitude per the rules of the city-state in which she broke the laws. It was either that or become a eunuch, and you can hardly blame her for choosing the hard labor in this case.} {The hardships of her life, rather quaintly, may serve as an excellent cast from which to mold a proper mercenary. | Her servitude no doubt made the woman formidable in appearance, though it may be hard to say where her mind is at being what is essence an indentured sellsword. | Slaves for warriors are a usual sight in the southern cities and %name% might serve as a useful, albeit enslaved, sellsword yet. | You hope %name% could make a sound sellsword, but you have the feeling her primary allegiance is to that which any woman wishes to taste: freedom.}";
		return "{Much of the southern city states float atop the expendable bodies of prisoners of war, criminals, and indebted, throngs of people who have slighted the Gilder or His followers and must \'earn\' salvation through hard work. %name% is one such unfortunate soul.} {Like a shocking many, %name% was not always a hunted man. He worked as a traveling merchant until nomads ambushed his caravan. The nomads took him to a Vizier, pretending the man a criminal, and sold him as a hunted man. | Spotted for his handsomeness, %name% was kidnapped off the streets of %randomcitystate% and sold straight to a manipulative Vizier. He does not speak much of what all happened, but there is a sense manual labor was not his sole duty. | So great the religious transgressions of his predecessors, %name% was born into an indebted family, and it is uncertain how far back into his ancestry you must go before a truly free man would be found. | Desperate to save his family from generational debt, %name% sold himself into indentured servitude to ensure his wife and children have a life to live for themselves. | %name% swears he is from the north, but the deserts of the south have left him darkly tanned and, frankly, you\'ve not much reason to believe the words of a former prisoner of war no matter where he\'s from. | A once sea-farer, %name% spent years as an oarmen traveling from harbor to harbor to drive the goods of opulent merchants. Those who gave him to you stated he has a criminal past in piracy. | %name% was accused of ravishing an old woman and was given the option of execution or lifelong servitude. | Caught stealing from a fruit stall, %name% was pressed into lifelong servitude. | Fornications with \'non-women\' led to %name%\'s submission to servitude per the rules of the city-state in which he broke the laws. It was either that or become a eunuch, and you can hardly blame him for choosing the hard labor in this case.} {The hardships of his life, rather quaintly, may serve as an excellent cast from which to mold a proper mercenary. | His servitude no doubt made the man formidable in appearance, though it may be hard to say where his mind is at being what is essence an indentured sellsword. | Slaves for warriors are a usual sight in the southern cities and %name% might serve as a useful, albeit enslaved, sellsword yet. | You hope %name% could make a sound sellsword, but you have the feeling his primary allegiance is to that which any man wishes to taste: freedom.}";
	}

	o.setGender <- function (_gender = -1)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 19);

		if (_gender != 1) return;

		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernFemale;
			this.m.Faces = this.Const.Faces.SouthernFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanFemaleSkinny;
			this.m.Faces = this.Const.Faces.AfricanFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.African;
		}

		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "You purchased %name% as an indebted for almost no gold and continued to pay her a \'slave\'s wage\' for her stay as a sellsword. She did make herself an effective fighter, no doubt believing it was better to be paid nothing and fight to stay alive than be paid nothing and give up and rot. After your departure, you heard that the %companyname% traveled south on a campaign and the indebted got a good chance to exact a fair bit of revenge on a number of enemies in her past. Thankfully, she does not consider you one such person despite having kept her enslaved.";
		this.m.BadEnding = "You purchased %name% as an indebted and after your retiring, she went on with the %companyname%. Word of the mercenary band\'s problems have trickled in, but nothing about the indebted\'s current situation. Knowing how this world works, she has either been put into the vanguard as fodder or perhaps even been sold off to recoup profits. Either way, the world isn\'t easy on a sellsword, and it isn\'t easy on an indebted, and the woman is unfortunately both.";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				4,
				8
			],
			Bravery = [
				-5,
				0
			],
			Stamina = [
				4,
				10
			],
			MeleeSkill = [
				0,
				2
			],
			RangedSkill = [
				6,
				10
			],
			MeleeDefense = [
				1,
				3
			],
			RangedDefense = [
				2,
				5
			],
			Initiative = [
				3,
				8
			]
		};
		return c;
	}

	o.onAdded <- function ()
	{
		this.character_background.onAdded();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendThrowSand);
	}

	//no need to do legendsequipment here because it inherits from slave_background

});

