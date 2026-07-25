::mods_hookExactClass("skills/backgrounds/sellsword_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Sellsword);
		this.m.Name = "Sellsword";
		this.m.Icon = "ui/backgrounds/background_10.png";
		this.m.BackgroundDescription = "Sellswords are expensive, but a life of warfare has forged them into skilled fighters.";
		this.m.GoodEnding = "%name% the sellsword left the %companyname% and started %their% own mercenary company. As far as you know, it\'s a very successful venture and %they% often buddies up with the men of the %companyname% to work together.";
		this.m.BadEnding = "%name% left the %companyname% and started %their% own competing company. The two companies clashed on opposite sides of a battle between nobles. The sellsword died when a mercenary from the %companyname% stove %their% head in with a hedge knight\'s helmet.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 30;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure)
		];
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamicMins.Enemy = 2;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.CrossbowTree,
				::Const.Perks.AxeTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.FitTree,
				::Const.Perks.LargeTree
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

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular});
	}

	o.onBuildDescription <- function ()	{
		return "{%fullname%\'s worked as a sellsword since %their% father handed down %their% equipment. | %fullname% can\'t remember a time when %they% wasn\'t a sword for hire. | As a mercenary, %fullname% has never had to look long for work. | The literate talk about letting loose the dogs of war. %fullname% is one such hound. | In war, there is death and profit. %fullname% causes the former to earn the latter. | There has never been a better time for mercenaries like %name% to earn a crown or two. | After %their% %partner% ran off with %their% children, an angry %name% made a steady career as a nasty sellsword. | A decade ago %name% lost everything in a fire. %They're% been working as a sellsword ever since. | %name% always had the mind for violence and has pursued a long career as a sellsword. | Once dirt poor, %name% has earned a very tidy sum over the years as a sellsword. | %fullname% prefers to keep for %themselves% whence she came, but %their% reputation as a sword for hire speaks for itself.} {Well experienced, %they% has traveled in the company of many outfits in %their% time. | Military campaigns are but notches in %their% belt. | From work as a lord\'s bodyguard to being an enforcer for a skeevy merchant, %name% has seen it all. | %They% once made a living off slaying the wild beasts that encroach on human settlements. | With a grim grin, %they% boasts %they% has slain all manner of living creatures. | Through plenty of use, the mercenary has learned a thing or two about weapons you didn\'t even know existed. | The sellsword is counting how many %they% has slain to this day and %they% appears to not be stopping any time soon. | With a sword and shield in hand, the mercenary appears to do what %they% does best for a living.} {The %person% is no stranger to the fields of battle. | The %person% is no stranger to the cruelties of war. | %They% is used to the harsh realities of mercenary life. | %They% is said to be a reliable cog in any shield wall. | Some say %they% can hold a battle line as well as an oak tree. | Rumors abound that the %person% enjoys the sight of blood. | Without shame, %they% takes an uneasy pleasure in the misery of others on the battlefield. | Strangely, %they% seldom joins others around the campfire, instead keeping to %themselves%. | The %person% loves to tell a good tale about how %they% killed this thing or that. | Given a chance, the %person% is quick to showcase a wide variety of fighting styles.} {As long as you have the coin, %name% is yours to command. | A true mercenary, %name% will fight anyone for the right price. | Displaying some fine sword skills, %name% says %they% can run any man through. | With but a hint of a nod, %name% agrees to join you if you have the crowns. | Excited for an opportunity to earn coin, %name% knocks %their% mug on the table.}";
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

		if (this.Math.rand(1, 100) <= 30)
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
		return ::Legends.Backgrounds.getStats(::Legends.Background.Sellsword);
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 3) == 3)
		{
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
		}

	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 9);

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
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 8)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 9)
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.patched_mail_shirt],
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.worn_mail_shirt],
			[1, ::Legends.Armor.Standard.leather_lamellar],
			[1, ::Legends.Armor.Standard.mail_shirt]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.closed_mail_coif],
			[1, ::Legends.Helmet.Standard.reinforced_mail_coif],
			[1, ::Legends.Helmet.Standard.kettle_hat],
			[1, ::Legends.Helmet.Standard.padded_kettle_hat],
			[1, ::Legends.Helmet.Standard.hood]
		]));
	}

});
