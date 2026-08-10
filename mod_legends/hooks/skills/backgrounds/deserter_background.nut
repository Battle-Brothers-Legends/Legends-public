::mods_hookExactClass("skills/backgrounds/deserter_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Deserter);
		this.m.Name = "Deserter";
		this.m.Icon = "ui/backgrounds/background_07.png";
		this.m.BackgroundDescription = "Deserters have received some martial training, but usually aren\'t eager to put it to use.";
		this.m.GoodEnding = "%name% the deserter continued fighting for the %companyname%, ever striving to redeem %their% name. Word has it that during a brutal fight with orcs, %they% dove headfirst into a crowd of greenskins, surfing across the top of their shocked heads. %Their% heroism rallied the men to an incredible victory and %they% lives out %their% days getting toasted in every bar %they% enters.";
		this.m.BadEnding = "You heard %name% the deserter actually renewed %their% title and fled a battle the %companyname% had with some greenskins. Goblins caught %them% out in the woods and turned %their% head into a goblet for an orc warlord.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.SureFooting),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"the Deserter",
			"Turncloak",
			"the Betrayer",
			"the Runner",
			"the Dog",
			"the Worm"
		];
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Level = this.Math.rand(1, 2);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw;
		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SpearTree,
				::Const.Perks.MaceTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.CrossbowTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
			],
			Traits = [
				::Const.Perks.FitTree,
				::Const.Perks.LargeTree,
				::Const.Perks.TrainedTree,
				::Const.Perks.DeviousTree
			],
			Enemy = [
				::Const.Perks.OutlawTree,
				::Const.Perks.CivilizationTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.CommonMale});
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name% used to be a common soldier in a lord\'s army, but suffering loss after loss, | Once a watchwoman on the outskirts of %randomtown%, %name% watched all her friends die to the beasts that lurk there. After so many losses | When two lords quarreled over a petty matter of who owned a local pond, %name% was conscripted to help settle the matter. Being a nobody, it was clear her life was of little value. One slaughter later, | While employed in a lord\'s professional army, a horrible disease fell upon %name% and her comrades. Fearing its wrath, | While on a lengthy military campaign, %name% felt that there was too much marching and too little spoils to be had. So} she {stuck her weapons in the ground and walked off. | waited until night to desert her outfit. | and several others disbanded in protest. | volunteered for a patrol and, at the first opening, abandoned her soldiering career.} {It is no secret that deserters are widely despised - and %name% keeps her head hung low to stay out of others\' eyes. | Most deserters spend the rest of their days avoiding the noose, and %name% is no different. | Donning the garb of the common folk, %name% has, for a time, avoided the deserter\'s punishment. | By total luck, %name% has, thus far, gotten away with her crime.} {But now broke and penniless, she seeks a return to his former field. | Perhaps compelled by lawmen closing in, she now finds herself joining another fighting force. | Unfortunately, she is not a smart woman. Lacking the imagination to pursue a safer career, %name% once again returns to fighting. | Feeling guilty about deserting her comrades in the field, she now seeks redemption in fighting for another outfit. But who is to say she won\'t flee again? | With an empty coin purse from drinking her memories away, she now considers any opportunity to make a living.}";
		}
		else
		{
			return "{%name% used to be a common soldier in a lord\'s army, but suffering loss after loss, | Once a watchman on the outskirts of %randomtown%, %name% watched all his friends die to the beasts that lurk there. After so many losses | When two lords quarreled over a petty matter of who owned a local pond, %name% was conscripted to help settle the matter. Being a nobody, it was clear his life was of little value. One slaughter later, | While employed in a lord\'s professional army, a horrible disease fell upon %name% and his comrades. Fearing its wrath, | While on a lengthy military campaign, %name% felt that there was too much marching and too little spoils to be had. So} he {stuck his weapons in the ground and walked off. | waited until night to desert his outfit. | and several others disbanded in protest. | volunteered for a patrol and, at the first opening, abandoned his soldiering career.} {It is no secret that deserters are widely despised - and %name% keeps his head hung low to stay out of others\' eyes. | Most deserters spend the rest of their days avoiding the noose, and %name% is no different. | Donning the garb of the everyman, %name% has, for a time, avoided the deserter\'s punishment. | By total luck, %name% has, thus far, gotten away with his crime.} {But now broke and penniless, he seeks a return to his former field. | Perhaps compelled by lawmen closing in, he now finds himself joining another fighting force. | Unfortunately, he is not a smart man. Lacking the imagination to pursue a safer career, %name% once again returns to fighting. | Feeling guilty about deserting his brothers in the field, he now seeks redemption in fighting for another outfit. But who is to say he won\'t flee again? | With an empty coin purse from drinking his memories away, he now considers any opportunity to make a living.}";
		}
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Deserter);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 5);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/legend_sturdy_sling"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.gambeson]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.Standard.open_leather_cap],
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.full_aketon_cap],
			[2, ::Legends.Helmet.None]
		]));
	}

	o.onUpdate = function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.IsContentWithBeingInReserve = true;
	}

});
