this.witchhunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.witchhunter";
		this.m.Name = "Witchhunter";
		this.m.Icon = "ui/backgrounds/background_23.png";
		this.m.BackgroundDescription = "Witchhunters tend to have some martial experience, and their resolve often remains unbroken even in the face of unspeakable horror.";
		this.m.GoodEnding = "%name% the witchhunter eventually heard word of evil spreading in northern villages. %They% departed the %companyname% and has been burning those horrid witches at the stake ever since.";
		this.m.BadEnding = "Word of evil spreading in the north drew %name% the witchhunter from the company. %They% departed with stakes, vials of strange liquids, and a lot of kindling. A month later a peasant found %them% wandering the northern wastes with %their% eyes gouged out and %their% mouth sewn shut. %They% had a strange symbol ironed into %their% chest and when the peasant touched it both %people% exploded.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 13;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Drunkard)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(1, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.025, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.VampireTree,
				this.Const.Perks.HexenTree,
				this.Const.Perks.AlpTree
			],
			Class = [
				this.Const.Perks.FaithClassTree,
				this.Const.Perks.InquisitionClassTree
			],
			Magic = []
		}
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Resolve at morale checks against fear, panic or mind control effects. Also knows how to craft wooden stakes for use against vampires."
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		return "{%name% appeared one day in %townname%, some say upon request {of the local council | of a local priest}. | %name% has a reputation of showing up where things out of the ordinary happen and being out and about at the darkest part of the night. | Being a quiet and grim %person%, %name% has the tendency to make other people feel uncomfortable around %them%, even afraid. | The name of %name% is known in many a village, for %they% has travelled the land to wherever %their% talents are needed the most.} {A Witchhunter %they% calls %themselves%. With %their% assortment of exotic tools %they% has a great deal of experience in getting people to confess in agony their sinful liaisons with demons and devils under terrible torture. | %They% refers to %themselves% as a Witchhunter, but only superstitious fools would believe this and fall for %their% preposterous tales. | A Witchhunter %they% calls %randomname%, and %they% claims to have seen horrors from beyond that would drive a lesser mind insane. | After %their% arrival in %townname%, rumors spread that %they% was on the hunt for devil worshippers and creatures of the night, but no one knew what the real purpose of %their% visit was. | In %townname% %they% killed an elderly woman and was thrown into the dungeon. As it turned out, the woman was responsible for the abduction and death of 3 infants, and so %they% was set free again. | For nights on end %they% sat in %townname%\'s pub, silently studying every patron like a bird of prey circling above, %their% crossbow never far away. It didn\'t sit well with the residents but they didn\'t dare approach %them%.} {By now most of the local folks want %name% to be gone rather sooner than later and would happily see %them% join a travelling mercenary company. | It seems that whatever %their% mission was is now accomplished and so %name% offers %their% service as a mercenary. | It is somewhat obvious that %name% is not easily scared and %they% also knows how to handle a crossbow. Nobody was therefore surprised as %they% approached a mercenary company that was hiring. | Now, a mercenary company would be just the tool %they% needed to fulfill %their% personal quest against the evil from the world beyond. | Most people would be glad to get rid of %them%.}";
	}

	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
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
				0,
				0
			],
			Bravery = [
				15,
				20
			],
			Stamina = [
				5,
				8
			],
			MeleeSkill = [
				2,
				6
			],
			RangedSkill = [
				10,
				18
			],
			MeleeDefense = [
				2,
				5
			],
			RangedDefense = [
				3,
				6
			],
			Initiative = [
				10,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.WitchhunterTitles[this.Math.rand(0, this.Const.Strings.WitchhunterTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/legend_wooden_stake"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "ragged_surcoat"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "witchhunter_hat"]
		]))

	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.MoraleCheckBravery[1] += 20;
	}

});

