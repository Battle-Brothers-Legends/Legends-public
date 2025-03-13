this.legend_berserker_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_berserker";
		this.m.Name = "Berserker";
		this.m.Icon = "ui/backgrounds/background_berserker.png";
		// this.m.BackgroundDescription = "Berserkers are used to the hard life of the wild where only the strong prevail. They are less used to the life of cities, where the astute and deceitful rule.";
		// this.m.GoodEnding = "While the %companyname% visited a town for rest and recuperation, a local princess took a shine to %name% the wildman. He was \'purchased\' for a large sum of gold and given to the noblewoman. You went and visited the man recently. For dinner, he sat at a kingly table, grinning goofily and mimicking the nobles around him as best he could. His new and inexplicable wife adored him, and him her. When you said your goodbyes, he offered you a heavy golden crown off the top of his head. It weighed heavy with traditions and ancient histories. You said it\'d be best if he kept it. The wildman shrugged and walked off, spinning the circlet around a finger.";
		// this.m.BadEnding = "%name% the wildman stayed with the fragmenting %companyname% for a time and then, just like that, he was gone. The company went out looking for him in a forest, eventually finding some sort of crude note: an enormous pile of crowns next to a dirt-drawing of the %companyname% and some of its members, all of them being hugged by a big, literal stick figure with a goofy smile on its face. There was also an offering of a dead, half-eaten rabbit.";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
		];
		this.m.Titles = [
			"the Savage",
			"the Outcast",
			"the Wildman",
			"the Feral",
			"the Wild",
			"the Barbarian"
		];
		this.m.Faces = this.Const.Faces.Berserker;
		this.m.Hairs = this.Const.Hair.Berserker;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Berserker;
		this.m.BeardChance = 100;
		this.m.Bodies = this.Const.Bodies.LegendTattos;
		this.m.Ethnicity = 0;
		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Untalented;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.025, //swamp
			0.025, //hills
			0.0, //forest
			0.0, //forest
			0.0, //forest_leaves
			0.0, //autumn_forest
			0.025, //mountains
			0.0, // ?
			0.0, //farmland
			0.025, // snow
			0.025, // badlands
			0.025, //highlands
			0.0, //stepps
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.FistsTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.SturdyTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.ViciousTree
				this.Const.Perks.LargeTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.OrcsTree,
				this.Const.Perks.DirewolfTree
			],
			Class = [],
			Magic = [
				this.Const.Perks.BerserkerMagicTree
			]
		};
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.Steadfast,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.LegendAlert
			],
			[
				::Legends.Perk.CoupDeGrace,
			],
			[
				::Legends.Perk.Rotation,
				::Legends.Perk.Anticipation,
				::Legends.Perk.LegendTrueBeliever,

			],
			[],
			[
				::Legends.Perk.LegendDoubleStrike,
				::Legends.Perk.LegendBattleheart,
				::Legends.Perk.LegendTwirl,
				::Legends.Perk.LegendLionheart
			],
			[
				::Legends.Perk.LegendLacerate,
				::Legends.Perk.LegendForwardPush
			],
			[
				::Legends.Perk.LegendBigGameHunter,
				::Legends.Perk.LegendTumble,
			]
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

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Damage when unarmed"
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{For some, the wild is a refuge. | It is said that woman is born with the wilderness in her, and that she does wrong by turning her back on it. | Civilization is a stain, one prolonged arming of every next-generation to better battle the ultimate enemy: Mother Nature herself. | In a time of war, it\'s not surprising that many once again seek refuge in the wild. | Some people flee from town to town. Others stop in between, disappearing into the tranquil forests.} {%name% once found a safe register amongst the trees, but that time is over. | Once a mysterious figure to hunters - the famed masskewatsthat - %name% now returns to civilization for reasons unknown. | %name%\'s got the hands of a blacksmith, but the hygiene of a pigsty. | Maybe it was spurned love, or maybe just war, but %name% has spent the last decade far from the rest of mankind. | Possibly a poacher who settled where she hunted, %name%\'s lived amongst the trees for untold years. | With cleverly stitched garb, %name%\'s atavistic appearance perhaps belies a past as a tailor or tanner.} {There is an obvious language barrier with the berserker, but for some reason she seems very willing to fight. Let\'s hope his newfound \'calling\' doesn\'t have a darker purpose behind it. | Colorful and permanent ritual rites circle about her body. When asked why she wishes to join a band of mercenaries, she hoots and, with a crooked finger, replicates one of her fleshen arts across the sky. | Wounds, old and fresh, dot her already mottled body. And they are not superficial - this woman had been fighting something fierce in the wild. | One has to wonder if the calamities which chased her into the forests have come to chase her back out. | Judging by her wild grunting, it\'s doubtful she\'s here to rejoin civilization. | Years as a recluse haven\'t made the woman forget what a few crowns can get you. The question is, why did she come back? | She has the strength to wrestle a boar - and her many scars makes you wonder if perhaps she did.}";
		}
		else
		{
			return "{For some, the wild is a refuge. | It is said that man is born with the wilderness in him, and that he does wrong by turning his back on it. | Civilization is a stain, one prolonged arming of every next-generation to better battle the ultimate enemy: Mother Nature herself. | In a time of war, it\'s not surprising that many once again seek refuge in the wild. | Some people flee from town to town. Others stop in between, disappearing into the tranquil forests.} {%name% once found a safe register amongst the trees, but that time is over. | Once a mysterious figure to hunters - the famed masskewatsthat - %name% now returns to civilization for reasons unknown. | %name%\'s got the hands of a blacksmith, but the hygiene of a pigsty. | Maybe it was spurned love, or maybe just war, but %name% has spent the last decade far from the rest of mankind. | Possibly a poacher who settled where he hunted, %name%\'s lived amongst the trees for untold years. | With cleverly stitched garb, %name%\'s atavistic appearance perhaps belies a past as a tailor or tanner.} {There is an obvious language barrier with the berserker, but for some reason he seems very willing to fight. Let\'s hope his newfound \'calling\' doesn\'t have a darker purpose behind it. | Colorful and permanent ritual rites circle about his body. When asked why he wishes to join a band of mercenaries, he hoots and, with a crooked finger, replicates one of his fleshen arts across the sky. | Wounds, old and fresh, dot his already mottled body. And they are not superficial - this man had been fighting something fierce in the wild. | One has to wonder if the calamities which chased him into the forests have come to chase him back out. | Judging by his wild grunting, it\'s doubtful he\'s here to rejoin civilization. | Years as a recluse haven\'t made the man forget what a few crowns can get you. The question is, why did he come back? | He has the strength to wrestle a boar - and his many scars makes you wonder if perhaps he did.}";
		}


	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				20,
				25
			],
			Bravery = [
				5,
				10
			],
			Stamina = [
				15,
				20
			],
			MeleeSkill = [
				20,
				25
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				10,
				10
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

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
		this.m.Tattoo = this.Math.rand(0, 1);
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush(this.m.Tattoo == 0 ? "warpaint_01_head" : "scar_02_head");
		tattoo_head.Visible = true;
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		}
	}

	function onAdded()
	{

		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("The Berserker");
		//this.m.Container.add(this.new("scripts/skills/perks/perk_berserk"));
		::Legends.Traits.grant(this, ::Legends.Trait.Deathwish);
		//this.m.Container.add(this.new("scripts/skills/traits/loyal_trait"));
	}


	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 3;
		talents[this.Const.Attributes.Hitpoints] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "werewolf_hide_armor"]
		]));

		local r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/accessory/legend_hand_wraps_item"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/throwing_axe"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}
	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});
