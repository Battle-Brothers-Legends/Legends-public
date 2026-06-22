::mods_hookExactClass("skills/backgrounds/juggler_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Juggler);
		this.m.Name = "Juggler";
		this.m.Icon = "ui/backgrounds/background_14.png";
		this.m.BackgroundDescription = "Jugglers need to have good reflexes and hand-eye-coordination for their profession.";
		this.m.GoodEnding = "%name% the juggler took all %their% mercenary money and started a traveling troupe of performers. Last you heard, %they% started an entire theater and puts on a new play a month!";
		this.m.BadEnding = "%name% the juggler retired from fighting. %They% was performing for a gaudy nobleman in the {south | north | east | west} when an act went horribly wrong. Word has it %they% was thrown off a tower for %their% mistake, but you prefer to not believe that.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable)
		];
		this.m.Titles = [
			"the Juggler",
			"the Jester",
			"the Fool"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.BackgroundType = this.Const.BackgroundType.Performing;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.ThrowingTree,
				::Const.Perks.MaceTree,
				::Const.Perks.FlailTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.PolearmTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.AgileTree,
				::Const.Perks.FitTree,
				::Const.Perks.FastTree,
				::Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.JugglerClassTree,
				::Const.Perks.ConArtistTree
			],
			Profession = [],
			Magic = []
		}
		this.m.Bodies = this.Const.Bodies.Skinny;
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 15,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Higher Chance To Hit Head"
			}
		);
		return ret;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		if (_gender != 1) return;

		this.m.Bodies = this.Const.Bodies.NorthernFemale;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function () {
		return "{Taught by %their% step-brother, %name% took up juggling like a sailor to %their% oars. | Although sneered at by %their% peers, %name% always loved juggling. | Visited by a troupe of jesters, %name% was most enamored - and eventually taught - by one particularly interesting man: a juggler. | %Offspring% to a local lord, %name%\'s embarrassing obsession with juggling and entertaining had %them% exiled from the family line. | %name% didn\'t juggle just for the sake of it, but to earn the laughter and applause of an audience.} {Unfortunately, there\'s not many folks to entertain when war is ravaging the land. | But crowds and crowns are sparse in a land of misery and suffering. | But a juggling accident involving adzes and a royal infant had the entertainer running for %their% life. | So good at flipping swords and daggers, it wasn\'t long until %they% was accused of sorcery and driven from %their% passion. | Sadly, %name%\'s skill in juggling led to much jealousy amongst %their% fellow jesters. They conspired against %them% - and %their% poor wrists. | When an assassin killed the lord %they% was entertaining, the juggler was the first to be accused. %They% barely escaped with %their% life.} {Now, %name% seeks a new path, even if death itself has become %their% audience. | Now, %name% finds respite in the company of equally down-on-their-luck men. | With fast hands and quick reactions, %name% should have no problem hitting %their% targets. | Juggling knives with %their% eyes closed, %name% knows exactly where to throw each blade. | There is far more coin in killing than juggling, a sad reality %name% has come to accept.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-6,
				3
			],
			Bravery = [
				0,
				-3
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				2,
				4
			],
			RangedSkill = [
				8,
				3
			],
			MeleeDefense = [
				-3,
				1
			],
			RangedDefense = [
				3,
				5
			],
			Initiative = [
				10,
				12
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/throwing_axe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/throwing_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_ranged_wooden_flail"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.jesters_hat],
			[1, ::Legends.Helmet.None]
		]));
	}

	o.onUpdate = function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}

});
