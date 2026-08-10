::mods_hookExactClass("skills/backgrounds/manhunter_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Manhunter);
		this.m.Name = "Manhunter";
		this.m.Icon = "ui/backgrounds/background_62.png";
		this.m.BackgroundDescription = "Manhunters are used to hunting down people in the rough environment of the south.";
		this.m.GoodEnding = "%name% the manhunter stuck with the %companyname% for a long while after you left it. You haven\'t gotten much word other than %name%\'s found far more income in the world of sellswords than that of hunting down the indebted.";
		this.m.BadEnding = "Upset with how time in the company of the %companyname% has gone, %name% the manhunter deserted and returned south. It\'s hard to say what became of the slaver, but the business of tracking and hunting human prey carries endless dangers. The only news you haveis ancillary to the vocation: that of numerous indebted uprisings with many manhunters being buried alive or fed to a variety of desert-borne creatures.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople)
		];
		this.m.Titles = [
			"the Manhunter",
			"the Mancatcher",
			"the Hunter",
			"the Ruthless",
			"the Bounty Hunter",
			"the Brutal",
			"the Cruel",
			"the Unforgiving",
			"the Merciless",
			"the Tracker",
			"the Catcher",
			"the Heartless",
			"the Swine",
			"the Slaver"
		];
		this.m.Level = this.Math.rand(2, 4);
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.MaceTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.SwordTree,
				::Const.Perks.BowTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.ClothArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.AgileTree,
				::Const.Perks.FastTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree,
				::Const.Perks.OutlawTree
			],
			Class = [
				::Const.Perks.BeastClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemale, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernThick, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 90);
	}

	o.onBuildDescription <- function ()	{
		return "{The large population of slaves, prisoners, criminals, and indebted servants in the south has produced an economy of sellers, buyers, and, given the flighty nature of the product, hunters. | Southern city states must have enormous reserves of labor to fuel their desert-borne economies. While many are born into working tirelessly for Viziers, some must be coerced into a life of servitude. | The deserts so sparse in natural resources, it is often an ample supply of captured criminals and indebted souls which bolsters the southern economy. And the business of hunting down these eventual servants is a prosperous one. | Southern Viziers are so fearful of rebellions that an entire market of Manhunters has emerged to nip them in the bud.} {%name% entered manhunting with a vengeful attitude: their entire family was massacred in a slave uprising. | %name% was once an ordinary caravan guard but turned to manhunting nomads who kept trying to ambush their convoys. Finding more profit in the human trade, %name%\'s stuck with it ever since. | %name% is a manhunter with a good nose for tracking criminals, deserters, prisoners of war, and more. You sometimes wonder if %name%\'s got a keen sense of smell for fearful sweat. | Once a big game hunter, %name% grew fond of chasing the greatest game of all: man. %name% is an expert tracker with a nose for sniffing out desperation.} {For %name%, the opportunity of working for a mercenary band simply brings in more consistent work than waiting around for some pressed criminal to get antsy about his chains. | %name% is a rugged, shady individual and it is quite possibly just as flighty as those being hunted. | Hunters like %name% carry traits and skills that would be useful in a mercenary band, but to some their past may be an ever present slight. Not all manhunters are seen in good light. | Capturing humans for the purpose of labor is frowned upon by many and catching those seeking their freedom equally so. Manhunters like %name% certainly have useful skills, but may rub some the wrong way. | To no surprise, many see slavers like %name% as opportunistic slugs. If %name% can make it with the company, it may take time to change the minds of some about the past.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Manhunter);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/battle_whip"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.nomad_robe],
			[1, ::Legends.Armor.Southern.thick_nomad_robe]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.None]
		]);
		items.equip(helm);
	}
});
