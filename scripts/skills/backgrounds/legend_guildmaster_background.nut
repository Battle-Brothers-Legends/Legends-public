this.legend_guildmaster_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.LegendGuildmaster);
		this.m.Name = "Guild Master";
		this.m.Icon = "ui/backgrounds/background_guildmaster.png";
		this.m.BackgroundDescription = "An aging master slayer of a local guild, time has taken their youth but their skills still surpass those they train.";
		this.m.GoodEnding = "%name% retired from the company and bought the deed to an abandoned castle. There %they% commands a troop of fellow beast slayers who journey the land protecting it from monsters. Last you spoke to %them% %they% had a raven-haired lady friend who did not take kindly to your presence, nor the presence of anyone else for that matter. You\'re sure %they're% happy.";
		this.m.BadEnding = "After leaving the %companyname%, %name% retired from beast slaying altogether and last you heard %they% fathered an albino daughter. Unfortunately, rumors spread quickly about the girl having supernatural powers and her mother was executed by fire. The father and child were never caught nor seen again.";
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
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
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
		this.m.Level = this.Math.rand(3, 5);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SpearTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.AxeTree,
				::Const.Perks.CrossbowTree
			],
			Defense = [
				::Const.Perks.MediumArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.CalmTree,
				::Const.Perks.TrainedTree
			],
			Enemy = [
				::Const.Perks.BeastTree,
				::Const.Perks.OccultTree,
			],
			Class = [
				::Const.Perks.BeastClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.UntidyMale, HairColors = ::Const.HairColors.Old}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.UntidyMale, HairColors = ::Const.HairColors.Old, Beards = ::Const.Beards.Untidy});
		if(_gender){
			this.m.BadEnding = "After leaving the %companyname%, %name% retired from beast slaying altogether and last you heard %they% was mother to an albino daughter. Unfortunately, rumors spread quickly about the girl having supernatural powers and her father was executed by fire. The mother and child were never caught nor seen again.";
		}
	}

	function onBuildDescription() {
		return "{Old age has finally caught up with %name% | Once a proficient slayer, %name% has slowly withered to old age. | %name% has a long list of stories to tell, but is old enough to tell them with honesty. | %name%\'s reputation precedes them, but %they% are much weaker in person that in the tales you were told as a child.} {Many battles and minor injuries have worn down %name%\'s health to the point where %they% were forced into retirement. | %name% kept %their% village safe as a child, but as the expectations of %them% grew, %they% quickly found %themselves% burnt out. | %name% was a pathfinder during the battle of many names, on the eve of a battle a messenger advised a noble not much younger than %them% to not send calvary into the swamp against the greenskins. The noble declined, and the massacre that ensued has haunted %them% ever since. | %Their% last contract involved hunting a beast that stole and slaughtered sheep near %randomtown%, only to find that the wolves were starving refugees who left %them% with a nasty scar. | %name% turned to teaching how to slay monsters, but found %their% students more eager to slay each other. | %name% was a famous slayer, killing all manner of beasts across the realm. However, %they% found %themselves% in the middle of a riot and was run through by a boy with a pitchfork, leaving a gruesome scar on %their% back. | Others may not feel it, but there is something strange in the woods - something far worse than the wolves, giants and spiders %name% is used to. | %They% pledged %themselves% to keep the commonfolk safe and the wilds tame, but time has made %them% realise that %they% have more in common with what %they% kills than what %they% protects. | %name% does not feel %they% has much longer in this world, and wants to pass on as much as %they% can before it\'s too late. | People are becoming more desperate, irrational even. Those on the fringes of society are always the first to be targeted, which would explain why %name% is seeking the safety of like-minded slayers. | Despite all the trophies %they% has gathered, %name% never had time for a family. Now %their% family are those %they% can fight beside - you can\'t tell if %they% can see the tragedy in that yet. | All of %their% past students lay dead or missing - and it\'s something %they% rather you not dredge up in the future.}";
	}

	/*function getTooltip() // needs to be added or can be revived as a profession?
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Provides [color=%positive%]+10%[/color] enchanting speed when assigned to the enchanter\'s tent."
			}
		);
		return ret;
	}*/

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendGuildmaster);
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
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.werewolf_hide_armor]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.Standard.feathered_hat],
			[1, ::Legends.Helmet.Standard.dark_cowl],
			[1, ::Legends.Helmet.None]
		]));
	}
});
