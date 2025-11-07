this.legend_crusader_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_crusader";
		this.m.Name = "Holy Crusader";
		this.m.Icon = "ui/backgrounds/crusader.png";
		this.m.HiringCost = 3500;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Good;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Combat | this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Untalented;
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.OneHandedTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.SturdyTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.InspirationalTree
			],
			Enemy = [
				this.Const.Perks.HexenTree,
				this.Const.Perks.GhoulTree
			],
			Class = [
				this.Const.Perks.FaithClassTree
			],
			Profession = [
				this.Const.Perks.RepairProfessionTree
			],
			Magic = []
		};
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.Student,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.BagsAndBelts,
				// ::Legends.Perk.LegendComposure,
				::Legends.Perk.Adrenaline,
				::Legends.Perk.LegendHolyFlame
			],
			[
				::Legends.Perk.Dodge,
				::Legends.Perk.RallyTheTroops,
				::Legends.Perk.LegendTrueBeliever,
			],
			[
				::Legends.Perk.LegendFavouredEnemySkeleton,
				::Legends.Perk.LegendFavouredEnemyZombie,
				::Legends.Perk.LegendFavouredEnemyVampire
			],
			[],
			[
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.LegendBattleheart,
				::Legends.Perk.LegendLionheart
			],
			[
				::Legends.Perk.InspiringPresence,
				::Legends.Perk.Fearsome,

			],
			[
				::Legends.Perk.LegendPerfectFocus
			],
			[],
			[],
			[],
			[]
		];

	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		return "%name% lives to fight the undead scourge. Little is known about %them% and %they% almost never talks save for the occasional grunt while swinging %their% sword. %Their% language seems to be codified into one simple structure: killing creatures of evil.";
	}

	function onSetAppearance()
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

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				10
			],
			Bravery = [
				10,
				10
			],
			Stamina = [
				10,
				10
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				15,
				15
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-20,
				-20
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Holy Avenger");
		::Legends.Traits.grant(this, ::Legends.Trait.Loyal);
		::Legends.Traits.grant(this, ::Legends.Trait.LegendUndeadKiller);

	}

function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeDefense] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/legend_longsword"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.mail_hauberk],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.scale_armor],
			[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			[1, ::Legends.Armor.Standard.worn_mail_shirt]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.bascinet_with_mail],
			[1, ::Legends.Helmet.Standard.closed_flat_top_helmet]
		]);
		if (item != null)
		{
			item.onPaint(this.Const.Items.Paint.None);
			items.equip(item);
		}

	}
});
