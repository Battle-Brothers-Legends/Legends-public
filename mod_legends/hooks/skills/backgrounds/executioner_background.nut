::mods_hookExactClass("skills/backgrounds/executioner_background", function(o)
{
	o.create = function () {
		this.character_background.create();
		this.m.ID = "background.executioner";
		this.m.Name = "Executioner";
		this.m.Icon = "ui/backgrounds/background_72.png";
		this.m.BackgroundDescription = "Executioners are dour and used to violence, although they have little experience in true warfare.";
		this.m.GoodEnding = "%name% eventually retired from the company and once again found %themselves% plying the executioner\'s trade. %Their% considerable decapitation skills only honed further by sellswording, the %person% has apparently gained such notoriety in %their% field that the local nobility frequently get into feuds over who may keep %them% on retainer.";
		this.m.BadEnding = "%Their% skill with the headsman\'s blade sharpened further by combat, %name% left the company and resumed work as an executioner. The townsfolk found little spectacle in %their% efficiency, however, and %they% was soon replaced with a more crowd-pleasing amateur. Left destitute, it wasn\'t long before the %person% was found hanging from a tree outside of town.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 12;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
		];
		
		this.m.ExcludedTalents = [
			::Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"Headtaker",
			"Neckrender",
			"the Axe",
			"the Judicator",
			"the Headsman",
			"the Executioner",
			"the Hangman"
		];
		this.m.Bodies = this.Const.Bodies.Big;
		this.m.Faces = ::Const.Faces.AllWhiteMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.m.BeardChance = 50;
		this.m.Level = this.Math.rand(1, 3);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Lowborn | this.Const.BackgroundType.Performing;
		this.m.Modifiers.Meds = ::Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Injury = ::Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.CleaverTree,
				::Const.Perks.SwordTree,
				::Const.Perks.AxeTree,
				::Const.Perks.PolearmTree
			],
			Defense = [
				::Const.Perks.LightArmorTree,
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.LargeTree,
				::Const.Perks.FitTree,
				::Const.Perks.CalmTree
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

	o.getTooltip = function () {
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=%positive%]+10%[/color] Chance To Hit Head"
			}
		);
		return ret;
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Bodies = this.Const.Bodies.NorthernFemale;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription = function ()
	{
		return "{As with many men, %name%\'s direction in life was dictated by the family business: executing criminals for the burgomeister of %randomtown%. | As a %child%, %name% dreamed of becoming a knight clad in shining armor. As a %person%, %they% became an executioner clad in a dark hood. | %name%\'s whole family was slain in a bandit raid. Unable to join the manhunt himself, %they% became an apprentice to the local executioner in the hopes of one day meting out revenge in %their% own way. | Once a brigand %themselves%, %name% had a change of heart and turned %themselves% in. The local guard offered %them% a pardon if %they% agreed to execute any criminals they captured, and %they're% been in the trade ever since. | With the distant stare of one who has seen much death, and the worn blade of one who has dealt it, it\'s obvious that %name% is an executioner. | An executioner, %name% is about as cheerful as the gallows %they% operates.} {Though content with %their% profession, it made %them% unpopular. After carrying out the beheading of {a local youth sentenced for stealing from a noble | a beloved whore who slept with the wrong lord | a respected craftsman accused of embezzling}, %they% was ostracized by the townsfolk. | %They% always viewed %themselves% as a necessary, if grisly, part of law for the common folk. But when %they% learned {%their% employer was making backroom deals with brigands | the local lord was ordering the deaths of the innocent | a man %they% executed was innocent | of the horrible things the local lord did with the heads of the condemned}, %they% resigned %their% post in disgust. | One day %they% was tasked with killing a strange cultist from distant lands. After %they% broke a third blade halfway through the strangely cheerful man\'s neck, %they% decided it was time to find a new profession. | But one day %they% woke up and found %they% could no longer stomach the idea of slaying a man who couldn\'t fight back. | But eventually %they% grew unhappy with %their% role, finding little satisfaction in slaying men after they\'d already performed their evil works.} {With few other careers available to %them%, %name% decided mercenary work seemed the best fit for %their% talents. | While not a warrior, %name% knows how to handle a blade, and so sellswording was the obvious career change. | With a skillset predominantly based around necklines, %name% decided %they% could either become a mercenary or a tailor. The former seemed like it paid better, and now here %they% is. | In need of a new career but with few other skills, %name% decided that mercenary work was sort of like executing with more steps.} {The %person% stands silently before you, staring wide-eyed and expectant but not saying a word. Ok then. | Less confident in conversation than in killing, %they% mumbles out a nervous greeting to you and asks about pay. | Not much for words, %they% grunts expectantly at you. As long as %they% can kill, you suppose you don\'t mind the quiet. | %They% approaches and barks something at you that %their% heavy hood muffles beyond comprehension. After a few moments of silence %they% follows up with \'...please?\' and you realize %they're% asking to join the company. Oh.}";
	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	o.updateAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				10,
				7
			],
			Bravery = [
				12,
				10
			],
			Stamina = [
				9,
				14
			],
			MeleeSkill = [
				6,
				8
			],
			RangedSkill = [
				-5,
				0
			],
			MeleeDefense = [
				-5,
				0
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local weapons = [
			"weapons/hatchet",
			"weapons/hand_axe",
			"weapons/exesword",
			"weapons/woodcutters_axe"
		];

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/bardiche"
			]);
		}
		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.executioner_tunic]
		]));

		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.executioner_hood]
		]));
	}

	o.onUpdate = function ( _properties ) {
		this.character_background.onUpdate(_properties);
		_properties.HitChance[::Const.BodyPart.Head] += 10;
	}
});
