::mods_hookExactClass("skills/backgrounds/militia_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Militia);
		this.m.Name = "Militia";
		this.m.Icon = "ui/backgrounds/background_35.png";
		this.m.BackgroundDescription = "Anyone that\'s been in the militia will have received at least some basic training in matters of combat.";
		this.m.GoodEnding = "A former militiaman such as %name% eventually left the %companyname%. %They% traveled the lands, visiting villages and helping them establish credible militias with which to defend themselves. Finding success in an increasingly dangerous world, %name% eventually came to be a known name, called upon as a sort of \'fixer\' to come and ensure these villages would remain safe. Last you heard, %they're% purchased a plot of land and was raising a family far from the strife of the world.";
		this.m.BadEnding = "%name% left the collapsing company and returned to %their% village. Back in the militia, it wasn\'t long until {greenskins | raiders} attacked and %they% was called to action. It\'s said that %they% stood tall, rallying the defense as %they% slew through countless enemies before succumbing to mortal wounds. When you visited the village, you found children playfighting beneath a statue made in the militiaman\'s image.";
		this.m.HiringCost = 85;
		this.m.DailyCost = 14;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic)
		];
		this.m.Level = this.Math.rand(1, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SpearTree,
				::Const.Perks.SlingTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.FitTree,
				::Const.Perks.AgileTree
			],
			Enemy = [
				::Const.Perks.OutlawTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.CommonMale, HairColors = ::Const.HairColors.Young});
	}

	o.onBuildDescription <- function ()	{
		return "{A militiaman like %name% is only raised in times of need. | Broke and without work, %name% joined %their% local militia. | Caught stealing an apple, %name% was pressed into the militia as a form of punishment. | Although a member of the peasantry, %name% was always willing to join the militia and protect %their% homestead. | War is a hungry beast - militia conscripts like %name% are what feed it.} {While %they% got proper training, there was rarely enough food to go around for the \'second-rate soldiers\'. | Even though %they% fought just as hard as the professionals, %they% found %themselves% unable to garner any sort of respect for %their% work. | Being the bottom rung of soldiering, %they% quickly realized that it meant %their% life was expendable. | %Their% weapons were rusted and the armor nonexistent. Unfortunately, enemies were not so kindly under-equipped.} {After a year of traipsing around with shoddy gear, %they% decided to look for something a bit more to %their% liking: sellswords. | When a lord sent %their% entire militia to almost certain doom, %name% realized %they% had better seek something better if %they% wanted to live. %They% took %their% modest skill set to the field of mercenaries. | Years in an outfit where %they% couldn\'t depend on the man next to %them% drove %name% to find something better. %They're% not the best soldier you\'ve ever seen, but %they% is earnest. | When %their% militia was disbanded, %they% returned home to find %their% town had been burned to the ground. One foot already in the door, it only made sense to join one of the numerous mercenary bands roaming the land. | %name%\'s modest military garb belies a %person% who has seen %their% fair share of training and combat.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				4,
				8
			],
			Bravery = [
				3,
				5
			],
			Stamina = [
				3,
				5
			],
			MeleeSkill = [
				5,
				9
			],
			RangedSkill = [
				5,
				6
			],
			MeleeDefense = [
				2,
				2
			],
			RangedDefense = [
				2,
				2
			],
			Initiative = [
				10,
				10
			]
		};
		return c;
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();
		if (this.Math.rand(0, 4) == 4)
		{
			actor.setTitle(this.Const.Strings.MilitiaTitles[this.Math.rand(0, this.Const.Strings.MilitiaTitles.len() - 1)]);
		}

	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		local weapons = [
			"weapons/hooked_blade",
			"weapons/bludgeon",
			"weapons/hand_axe",
			"weapons/militia_spear",
			"weapons/shortsword"
		];

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/warfork"
			]);
		}

		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 50)
		{
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.leather_lamellar],
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.gambeson],
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.full_aketon_cap],
			[1, ::Legends.Helmet.Standard.open_leather_cap],
			[1, ::Legends.Helmet.Standard.full_leather_cap],
			[1, ::Legends.Helmet.Standard.straw_hat]
		]));

	}
});
