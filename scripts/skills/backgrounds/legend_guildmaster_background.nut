this.legend_guildmaster_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_guildmaster";
		this.m.Name = "Guild Master";
		this.m.Icon = "ui/backgrounds/legend_guildmaster_background.png";
		this.m.BackgroundDescription = "An aging master slayer of a local guild, time has taken their youth but their skills still surpass those they train.";
		this.m.GoodEnding = "%name% retired from the company and bought the deed to an abandoned castle. There he commands a troop of fellow beast slayers who journey the land protecting it from monsters. Last you spoke to him he had a raven-haired lady friend who did not take kindly to your presence, nor the presence of anyone else for that matter. You\'re sure he\'s happy.";
		this.m.BadEnding = "After leaving the %companyname%, %name% retired from beast slaying altogether and last you heard he fathered an albino daughter. Unfortunately, rumors spread quickly about the girl having supernatural powers and her mother was executed by fire. The father and child were never caught nor seen again.";
		this.m.HiringCost = 185;
		this.m.DailyCost = 27;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive)
		];
		this.m.Titles = [
			"the Beasthunter",
			"Woodstalker",
			"the Beastslayer",
			"the Tracker",
			"the Trophyhunter",
			"the Hunter"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(3, 5);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger;
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Enchanting = 0.1;
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.00,//plains
				0.030, //swamp
				0.01, //hills
				0.030, //forest
				0.030, //forest
				0.030, //forest_leaves
				0.030, //autumn_forest
				0.03, //mountains
				0.0, // ?
				0.00, //farmland
				0.020, // snow
				0.020, // badlands
				0.020, //highlands
				0.01, //stepps
				0.0, //ocean
				0.01, //desert
				0.01 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SpearTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.LightArmorTree				
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.TrainedTree
			],
			Enemy = [
				this.Const.Perks.SchratTree,
				this.Const.Perks.LindwurmTree,
				this.Const.Perks.AlpTree,
				this.Const.Perks.HexenTree,
				this.Const.Perks.DirewolfTree,
				this.Const.Perks.SpiderTree,
				this.Const.Perks.GhoulTree,
				this.Const.Perks.UnholdTree
			],
			Class = [
				this.Const.Perks.BeastClassTree
			],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "%name% retired from the company and bought the deed to an abandoned castle. There she commands a troop of fellow beast slayers who journey the land protecting it from monsters. Last you spoke to her she had a raven-haired lady friend who did not take kindly to your presence, nor the presence of anyone else for that matter. You\'re sure she\'s happy.";
		this.m.BadEnding = "After leaving the %companyname%, %name% retired from beast slaying altogether and last you heard she was mother of an albino daughter. Unfortunately, rumors spread quickly about the girl having supernatural powers and her father was executed by fire. The mother and child were never caught nor seen again.";

	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Provides [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] enchanting speed when assigned to the enchanter\'s tent."
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{Old age has finally caught up with %name% | Once a proficient slayer, %name% has slowly withered to old age. | %name% has a long list of stories to tell, but is old enough to tell them with honesty. | %name%\'s reputation preceeds them, but they are much weaker in person that in the tales you were told as a child.} {Many battles and minor injuries have work down %name%\'s health to the point where they were forced into retirement. | %name% kept their village safe as a child, but as the expectations of her grew, he quickly found herself burnt out. | %name% was a pathfinder during the battle of many names, on the eve of a battle a messenger advised a noble not much younger than her to not send calvary into the swamp against the greenskins. The noble declined, and the massacre that ensued has haunted her ever since. | Her last contract involved hunting a beast that stole and slaughtered sheep near %randomtown%, only to find that the wolves were starving refugees who left her with a nasty scar. | %name% turned to teaching how to slay monsters, but found her students more eager to slay each other. | %name% was a famous slayer, killing all manner of beasts across the realm. However they found themselves in the middle of a riot and were run through by a boy with a pitchfork, leaving a gruesome scar on their back. | Others may not feel it, but there is something strange in the woods - something far worse than the wolves, giants and spiders %name% is used to. | She pledged herself to keep commonfolk safe and the wilds tame, but time has made her realise that they have more in common with what she kills than what she protects. | %name% does not feel she has much longer in this world, and wants to pass on as much as she can before it\'s too late. | People are becoming more desperate, irrational even. Those on the fringes of society are always the first to be targeted, which would explain why %name% is seeking the safety of like-minded slayers. | Despite all the trophies she has gathered, %name% never had time for a family. Now her family are those she can fight beside - you can\'t tell if she can see the tragedy in that yet. | All of her past students lay dead or missing - and it\'s something she rather you not dredge up in the future.}";
		}
		else
		{
			return "{Old age has finally caught up with %name% | Once a proficient slayer, %name% has slowly withered to old age. | %name% has a long list of stories to tell, but is old enough to tell them with honesty. | %name%\'s reputation preceeds them, but they are much weaker in person that in the tales you were told as a child.} {Many battles and minor injuries have work down %name%\'s health to the point where they were forced into retirement. | %name% kept their village safe as a child, but as the expectations of him grew, he quickly found himself burnt out. | %name% was a pathfinder during the battle of many names, on the eve of a battle a messenger advised a noble not much younger than him to not send calvary into the swamp against the greenskins. The noble declined, and the massacre that ensued has haunted him ever since. | His last contract involved hunting a beast that stole and slaughtered sheep near %randomtown%, only to find that the wolves were starving refugees who left him with a nasty scar. | %name% turned to teaching how to slay monsters, but found his students more eager to slay each other. | %name% was a famous slayer, killing all manner of beasts across the realm. However they found themselves in the middle of a riot and were run through by a boy with a pitchfork, leaving a gruesome scar on their back. | Others may not feel it, but there is something strange in the woods - something far worse than the wolves, giants and spiders %name% is used to. | He pledged himself to keep commonfolk safe and the wilds tame, but time has made him realise that they have more in common with what he kills than what he protects. | %name% does not feel he has much longer in this world, and wants to pass on as much as he can before it\'s too late. | People are becoming more desperate, irrational even. Those on the fringes of society are always the first to be targeted, which would explain why %name% is seeking the safety of like-minded slayers. | Despite all the trophies he has gathered, %name% never had time for a family. Now his family are those he can fight beside - you can\'t tell if he can see the tragedy in that yet. | All of his past students lay dead or missing - and it\'s something he rather you not dredge up in the future.}";
		}

	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				0
			],
			Bravery = [
				13,
				17
			],
			Stamina = [
				0,
				5
			],
			MeleeSkill = [
				10,
				14
			],
			RangedSkill = [
				9,
				13
			],
			MeleeDefense = [
				3,
				4
			],
			RangedDefense = [
				2,
				4
			],
			Initiative = [
				5,
				10
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 75)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/spetum"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/javelin"));
		}

		if (this.Math.rand(1, 100) <= 50 && items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "ragged_surcoat"],
			[1, "thick_tunic"],
			[1, "leather_tunic"],
			[1, "padded_leather"],
			[1, "werewolf_hide_armor"]
		]))

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"],
			[1, "feathered_hat"],
			[1, "dark_cowl"],
			[1, ""]
		]))
	}
});

