::mods_hookExactClass("skills/backgrounds/swordmaster_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.swordmaster";
		this.m.Name = "Swordmaster";
		this.m.Icon = "ui/backgrounds/background_30.png";
		this.m.BackgroundDescription = "A swordmaster excels in melee combat like no other, but may be vulnerable at range. Age may have taken a toll on his physical attributes and may continue to do so. Swordmasters fight smart and conserve their strength which allows them to have a reduced impact on initiative due to fatigue.";
		this.m.GoodEnding = "The finest swordsman you\'d ever seen, %name% the old swordmaster was a natural addition to the %companyname%. But a man can\'t fight forever. Despite the company\'s growing success, it was becoming readily obvious that the swordmaster just could not physically do it anymore. %They% retired to a nice plot of land and is enjoying some time to %themselves%. Or so you thought. You went out to go see the %person% and found %them% secretly training a nobleman\'s daughter. You promised to keep it a secret.";
		this.m.BadEnding = "A shame that %name% the swordmaster had to spend %their% twilight years in a declining mercenary company. %They% retired, stating %they% just could not physically do it anymore. You think %they% was just letting the %companyname% down easy, because a week later %they% slew ten would-be brigands on the side of a road without breaking a sweat. Last you heard, %they% was training ungrateful princes in the art of swordfighting.";
		this.m.HiringCost = 400;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.Hitpoints,
			//this.Const.Attributes.Fatigue
		];
		this.m.Titles = [
			"the Legend",
			"the Old Guard",
			"the Master"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(3, 5);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.FistsTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.CalmTree,
				::Const.Perks.LargeTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.AgileTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
			],
			Class = [],
			Profession = [
				::Const.Perks.FencingTeacherProfessionTree
			],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.m.Names = this.Const.Strings.LadyNames;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}


	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "At all times your Initiative is reduced only by [color=%negative%]50%[/color] of your accumulated Fatigue, instead of all of it. Stacks with [color=%perk%]Relentless[/color]"
		});
		return ret;
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.FatigueToInitiativeRate *= 0.5;
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% fights like a fish practices swimming. | %name% isn\'t just a person\'s handle, it\'s a myth. A name used in place of words like war, combat, and death. | To say, \'You move like %name%\' is, perhaps, the greatest honor someone can bestow upon a fellow warrior. | %name% is considered to be one of the most dangerous swords%person% to have ever walked the earth.} {Much of %their% life is founded in myth: stories like how %they% dismantled a realm by challenging a king and all %their% guardsmen to a duel - and besting them with one hand. | Supposedly, %they% fought twenty men in %their% own garden, slowly picking and pruning %their% tomatoes with the same blade %they% was using to kill. | Some say %they% was left to sea for three-hundred days and there %they% learned - balancing on a piece of flotsam - how to move, how to fight, and how to survive. | A story goes that %their% family was murdered and %they% knew not by whom. Wanting to be ready if %they% came across those responsible, %they% taught %themselves% to be good enough with a blade to kill anyone. | Raised by a one-armed father, %they% first learned how to fight with limitations. By the time %they% started using both hands %they% could already kill anybody with just one.} {Unfortunately, time and age have withered %name% into a shell of %their% former self. | During the orc invasions, %name% managed to kill a dozen greenskins singlehandedly. Sadly, an impossible feat does not come without a price: %their% sword-hand lost three fingers and %their% lead foot\'s achilles was severed. | Sadly, a horde of drunks fell upon %their% home, each hoping to become infamous by killing the famous swordsman. He slew them all, but not before taking irreversible injuries. | Legend has it that %they% quarreled with a foul beast of monstrous proportions. He waves the notion away with a fingerless hand and a scarred wink. | While teaching royalty how to fight, a coup that swept the entire realm had %them% running for %their% life. | Hired to teach noble heirs fighting skills, it wasn\'t long until %they% was embroiled in a web of intrigue and backstabbing, and had to leave as long as %they% still could.} {Now the old swordsman just looks to spend the rest of %their% fighting knowledge on the field. | While %they%\'s lost %their% edge, the man is still plenty dangerous and some say %they%\'s looking to find a student before %they% dies. | A master in the martial arts %they% may be, every movement %they% makes is echoed by the cracking of old bones. | Depressed and without purpose, %name% now finds meaning in simply blending in with the very men %they% used to teach. | The man makes it impossible to get through %their% defense, countering everything offered, but %they% no longer has the jump in %their% step to attack back. Admirable, but sad. | Given a sword, the old guard spins and twirls it in an impressive demonstration. When %they% plants it in the ground, %they% leans on the pommel to catch %their% breath. Not so impressive. | The man has been robbed of %their% athleticism, but %their% knowledge has turned swordfighting into mathematics.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-12,
				-12
			],
			Bravery = [
				10,
				12
			],
			Stamina = [
				-15,
				-10
			],
			MeleeSkill = [
				25,
				20
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				10,
				15
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-10,
				-10
			]
		};
		return c;
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.SwordmasterTitles[this.Math.rand(0, this.Const.Strings.SwordmasterTitles.len() - 1)]);
		}
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Unhold)
		{
			r = this.Math.rand(0, 2);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/fencing_sword"));
			}
		}
		else
		{
			r = this.Math.rand(0, 1);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
		}
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.padded_surcoat]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[67, ::Legends.Helmet.None],
			[33, ::Legends.Helmet.Standard.greatsword_hat]
		]));

	}
});
