::mods_hookExactClass("skills/backgrounds/raider_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.raider";
		this.m.Name = "Raider";
		this.m.Icon = "ui/backgrounds/background_49.png";
		this.m.BackgroundDescription = "Any raider that survived so far will have some expertise in fighting.";
		this.m.GoodEnding = "A former raider, %name% fit in well with the %companyname% and proved %themselves% an excellent fighter. Having saved a veritable mountain of crowns, %they% retired from the company and returned from whence %they% came. %they% was last seen sailing a riverboat toward a small village.";
		this.m.BadEnding = "As the %companyname% speedily declined, %name% the raider departed from the company and went on %their% own way again. %they% returned to raiding, taking %their% greedy violence along the shorelines of river villages. You\'re not sure if it\'s true, but word has it that %they% was impaled with a pitchfork by a stable boy. Word has it that the town hoisted %their% body parts along the outer walls as a warning to future would-be raiders.";
		this.m.HiringCost = 160;
		this.m.DailyCost = 28;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople)
		];
		this.m.Titles = [
			"the Raider",
			"the Marauder",
			"the Terrible",
			"the Bandit",
			"Fourfingers",
			"Ravensblack",
			"the Crow",
			"the Defiant",
			"the Pillager",
			"the Menace"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.AxeTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.CaravanTree,
				this.Const.Perks.MercenaryTree
			],
			Class = [],
			Magic = []
		}
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Beards = null;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function ()
	{
		return "{Living by the shore, %name%\'s life was peppered with the spice of sea raiders. As an adult, %they% joined them in the raiding. | When her family was slaughtered, newborn %name% was taken in by the very raiders who did it. | Born in a faraway place, %name% traveled to this land looking for towns to pillage. | A strong %person% from a remote part of the land, %name%\'s presence here has been hellacious for local residents. | A raider with a strong oar-arm and an even greater axe-arm, %name% is part of the folklore that keeps kids in bed at night. | Part warrior, part criminal, %name% has made a good life as a raider. | %name% decided many years ago to take by force from the weak and feeble whatever %they% desired, and has made %their% presence known by raiding caravans and villages ever since. | A poor and starved boy growing up, %name% took to joining robbers and cutthroats out of desperation. For the first time in %their% life %they% didn\'t feel hunger every night, and so %they% continued to take by force from others what %they% needed. %they% learned to fight and to kill without remorse, and before long, %they% was a monster of a %person%. | Wearing a lord\'s boots and a queen\'s torn dress as a shawl, %name%\'s attire reflects %their% years of raiding well. | The threat that stirs lords in their sleep and rushes housewives beneath beds, %name% is a menacing raider. | The strong take from the weak - that is the order of things that %name% lives by.} {%they% and %their% comrades raided caravans and preyed on outlying farms, only to find themselves being attacked for spoils of war one day. A small band of orcs had spotted %name%\'s camp and washed it away like a force of nature, scattering the few survivors into every which direction. %name% ran and didn\'t look behind. | After many years of ill-gotten gains, the %person% gave up the life after a raid on an orphanage ended with an out of control fire and the deaths of those inside. | A devoted believer in the old ways, %name% desires to die a glorious warrior\'s death to take %them% place beside the gods. But slaughtering villagers like cattle won\'t get the attention of the gods, and so %they% now looks for a greater challenge. | But while raping and pillaging, %name% was noticed to have a preference for the husbands over the wives. %their% taste ostracized %them% from the rest of the warband. | It started with a good raid on a merchant caravan. The few guards were quickly cut down and the fleeing merchant didn\'t run fast enough - a javelin to his back attested to it. The spoils were rich, but before long there was heated argument about how they were to be shared. By evening, most of the raiders had killed each other. %name% only barely escaped and had nothing to show for %their% day but a limping leg. | But %they% always had a soft spot for women, and the constant rape and murder by %their% comrades pushed the raider away from this lifestyle. | Caught by a lord\'s guards, the raider barely escaped, instead watching from a hilltop as %their% comrades were executed. | But one village ambushed %their% party on a raid, cutting down everyone but herself as %they% stole a stable horse and escaped certain doom. | While staking out in a forest, the raider\'s party was attacked by vicious beasts. %they% fed %their% own comrade to the foul things just to save %their% own neck. | But as war tears the world asunder, the raider realized there was less and less to actually pillage. | But as conflicts boil, every village %they% ran into was either dirt poor or already armed to face other fiends of the world.} {Now, %name% just wants a fresh start, even in the dour field of sellswords. | %name% can\'t be wholly trusted as a mercenary, but having been in league with brigands and raiders at the very least makes %them% fit for the work. | The %person% is not brotherly in the least, but %they% can wield a weapon like it\'s one of %their% missing fingers. | While %name%\'s past leaves a bad taste in anyone\'s mouth, there are even worse out there. | %name% is adept at killing and looting, just make sure those skills are directed toward your enemies. | While a good fighter, %name% is first and foremost loyal to loot. | %name% is here to kill things and take things. For you, this is a good thing. | %name% wears a necklace of ears about %their% neck, and another necklace adorned with those ears\' earrings. Fancy. | %name% is a strong fighter, but %they%\'s in good running to be the least-liked individual in your whole party. | The countryside is an alluring, green canvas upon which to build a life. Maybe the raider just wants to settle down. | Wearing clothes tracked with their previous owner\'s blood, %name% looks strikingly ready for duty. | You get the feeling that %name% is wearing clothes that someone was probably murdered in.}";
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

		if (this.Math.rand(1, 100) <= 40)
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
				0,
				0
			],
			Bravery = [
				-3,
				0
			],
			Stamina = [
				0,
				2
			],
			MeleeSkill = [
				10,
				12
			],
			RangedSkill = [
				0,
				5
			],
			MeleeDefense = [
				5,
				6
			],
			RangedDefense = [
				5,
				6
			],
			Initiative = [
				10,
				15
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/morning_star"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/military_pick"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "patched_mail_shirt"],
			[1, "padded_leather"],
			[1, "leather_lamellar"],
			[1, "worn_mail_shirt"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "dented_nasal_helmet"],
			[1, "nasal_helmet_with_rusty_mail"]
		]));

	}
});

