::mods_hookExactClass("skills/backgrounds/anatomist_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.anatomist";
		this.m.Name = "Anatomist";
		this.m.Icon = "ui/backgrounds/background_70.png";
		this.m.BackgroundDescription = "Part scientist and part surgeon, Anatomists are unaccustomed to battle but well served by steady hands.";
		this.m.GoodEnding = "Out of all the men you came to know in the %companyname%, it was %name% the anatomist who is perhaps the most difficult to forget. An unending stream of letters only helps ensure you never will. You skim over his latest, one-sided correspondence: \"Captain! I\'ve managed to...\" skimming, skimming, \"...the greatest invention! The most...\" skimming, skimming. \"I\'m going to be famous! My brain will be studied for its weight is surely...\" Nothing new, it seems, though you are glad he\'s still in good health, albeit perhaps more so in body than mind.";
		this.m.BadEnding = "Having fled the %companyname%, %name% the anatomist continued his studies elsewhere. He was admonished by his peers for venturing out in such an uncouth manner and found himself suffering in intellectual mediocrity. Some years later, he made a small contribution to the study of beetles after which he promptly threw himself off a seaside cliff, donating his brain to the rocks and his body to the ocean.";
		this.m.HiringCost = 130;
		this.m.DailyCost = 12;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Superstitious)
		];
		this.m.Titles = [
			"the Vulture",
			"the Crow",
			"the Magistrate",
			"the Mortician",
			"the Undertaker",
			"the Grim",
			"the Anatomist",
			"the Curious",
			"the Tainted"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;
		this.m.BackgroundType = this.Const.BackgroundType.Educated;
		this.m.Level = this.Math.rand(1, 2);
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];

		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				0.02, //swamp
				0.03, //hills
				0.05, //forest
				0.05, //forest
				0.05, //forest_leaves
				0.05, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.StaffTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.InspirationalTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.HealerClassTree,
				this.Const.Perks.SickleClassTree

			],
			Magic = [
				this.Const.Perks.PhilosophyMagicTree
			]
		}
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "Out of all the women you came to know in the %companyname%, it was %name% the anatomist who is perhaps the most difficult to forget. An unending stream of letters only helps ensure you never will. You skim over her latest, one-sided correspondence: \"Captain! I\'ve managed to...\" skimming, skimming, \"...the greatest invention! The most...\" skimming, skimming. \"I\'m going to be famous! My brain will be studied for its weight is surely...\" Nothing new, it seems, though you are glad she\'s still in good health, albeit perhaps more so in body than mind.";
		this.m.BadEnding = "Having fled the %companyname%, %name% the anatomist continued her studies elsewhere. She was admonished by her peers for venturing out in such an uncouth manner and found herself suffering in intellectual mediocrity. Some years later, she made a small contribution to the study of beetles after which she promptly threw herself off a seaside cliff, donating her brain to the rocks and her body to the ocean.";

	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Experience Gain"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name% is a sharp woman with a complexion wrecked by constant and virulent testing. You hope that her methodologies may be better applied to her enemies rather than her own self. | Rumors about %name% suggest she tried to figure out how to fly. Not by machine, rather, but by growing wings. How exactly she intended to do that, or what became of her experiments, is unknown. Yet, here she is, rather shrewdly grounded and looking over her shoulders. | Like many anatomists, %name% went out on her own into the world. Of course, also like many, she was quickly chewed up by the hungriness of those to whom science means nothing. For now, she will fight alongside sellswords, if only to buy herself extra time to truly get to her studies. | %name% is cynical to the world, upset that some of her peers could see to their education in full, while she must earn coin just to support her studies. May her anger present itself on the battlefield. | One would expect a woman like %name% to appear after a battle, not actually participate in it. The fact such an intelligent, albeit bizarre figure would still need a sellsword\'s earnings has you wondering if your own prospects of getting anywhere in this world are even worse than you realized. | One cannot overstate %name%\'s intellect. She is a wicked smart woman, the sort who can make you question why the gods bothered to give you a mind of your own if it is to be so dwarfed. But, in sellsword matters, she would be just another fighter. Hopefully her martial skills are as sharp as her wits. | You can never know for certain if it were hard times which forced %name% into sellswording, or if she\'s merely pursuing scientific inquiries by another, far crueler path. That she spends evenings dissecting wagon-crushed dogs and wingless butterflies makes you ponder a lot of things about the curious lass. | Curiosity, not coin, brought %name% to sellswording. She has a keen interest in discovering the creatures of the world, and what they look like on the inside. So long as she makes said insides visible, you could care less what else she does with them.}";
		}
		else
		{
			return "{%name% is a sharp man with a complexion wrecked by constant and virulent testing. You hope that his methodologies may be better applied to his enemies rather than his own self. | Rumors about %name% suggest he tried to figure out how to fly. Not by machine, rather, but by growing wings. How exactly he intended to do that, or what became of his experiments, is unknown. Yet, here he is, rather shrewdly grounded and looking over his shoulders. | Like many anatomists, %name% went out on his own into the world. Of course, also like many, he was quickly chewed up by the hungriness of those to whom science means nothing. For now, he will fight alongside sellswords, if only to buy himself extra time to truly get to his studies. | %name% is cynical to the world, upset that some of his peers could see to their education in full, while he must earn coin just to support his studies. May his anger present itself on the battlefield. | One would expect a man like %name% to appear after a battle, not actually participate in it. The fact such an intelligent, albeit bizarre figure would still need a sellsword\'s earnings has you wondering if your own prospects of getting anywhere in this world are even worse than you realized. | One cannot overstate %name%\'s intellect. He is a wicked smart man, the sort who can make you question why the gods bothered to give you a mind of your own if it is to be so dwarfed. But, in sellsword matters, he would be just another fighter. Hopefully his martial skills are as sharp as his wits. | You can never know for certain if it were hard times which forced %name% into sellswording, or if he\'s merely pursuing scientific inquiries by another, far crueler path. That he spends evenings dissecting wagon-crushed dogs and wingless butterflies makes you ponder a lot of things about the curious fellow. | Curiosity, not coin, brought %name% to sellswording. He has a keen interest in discovering the creatures of the world, and what they look like on the inside. So long as he makes said insides visible, you could care less what else he does with them.}";
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-2,
				0
			],
			Bravery = [
				12,
				14
			],
			Stamina = [
				-5,
				0
			],
			MeleeSkill = [
				5,
				7
			],
			RangedSkill = [
				5,
				9
			],
			MeleeDefense = [
				0,
				1
			],
			RangedDefense = [
				0,
				1
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, "undertaker_apron"],
			[2, "wanderers_coat"],
			[1, "reinforced_leather_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, "undertaker_hat"],
			[2, "physician_mask"],
			[1, "masked_kettle_helmet"]
		]));
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.15;
	}

});
