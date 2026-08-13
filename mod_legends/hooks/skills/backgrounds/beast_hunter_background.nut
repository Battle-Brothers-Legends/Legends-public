::mods_hookExactClass("skills/backgrounds/beast_hunter_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.BeastSlayer);
		this.m.BackgroundDescription = "Beast Slayers are used to expertly hunt monstrous beasts at all ranges.";
		this.m.GoodEnding = "%name% retired from the company and bought the deed to an abandoned castle. There he commands a troop of fellow beast slayers who journey the land protecting it from monsters. Last you spoke to him he had a raven-haired lady friend who did not take kindly to your presence, nor the presence of anyone else for that matter. You\'re sure he\'s happy.";
		this.m.BadEnding = "After leaving the %companyname%, %name% retired from beast slaying altogether and last you heard he fathered an albino daughter. Unfortunately, rumors spread quickly about the girl having supernatural powers and her mother was executed by fire. The father and child were never caught nor seen again.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
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
		this.m.Level = this.Math.rand(2, 3);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.UntidyMale}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
		
		if (_gender != 1) return;
		this.m.GoodEnding = "%name% retired from the company and bought the deed to an abandoned castle. There she commands a troop of fellow beast slayers who journey the land protecting it from monsters. Last you spoke to her she had a raven-haired lady friend who did not take kindly to your presence, nor the presence of anyone else for that matter. You\'re sure she\'s happy.";
		this.m.BadEnding = "After leaving the %companyname%, %name% retired from beast slaying altogether and last you heard she was mother of an albino daughter. Unfortunately, rumors spread quickly about the girl having supernatural powers and her father was executed by fire. The mother and child were never caught nor seen again.";
	}

	o.onBuildDescription <- function ()
	{
		return "{{%name%\'s past is hardly an extravagant one. | %name% has been traveling these parts for some time, but not always in %their% current vocation. | Despite %their% grisly job, %name% did not come from an extraordinary life. | A long list of defeated beasts and the pelts to prove it misleads one as to %name%\'s background.} {The beast slayer was once a mere hunter, armed with both bow and wisdom. However, upon discovering a monstrous direwolf in one of %their% traps %they% acquired a taste for hunting more dangerous foes. | When %their% village kept getting attacked by webknechts, the %person% took to learning all %they% could about hunting beasts. And then doing just that to much success. | It\'s said %they% was a village\'s miller until alps haunted the town whole. Never much of a sleeper %themselves%, %they% spent nights learning about the monsters until %they% bettered them. | %They% served as prey finder for a local lord. But when a hunt went awry and into the jaws of an unhold, the %person% turned to studying beasts and how to slay them. | A mere lumberjack, the beast slayer came into true being when all %their% peers were slaughtered at the hands of a schrat, a living tree. %They% avenged %their% friends and vowed to learn all %they% could of monsters. | A former nun, the %person% turned to studying beasts and swords alike after nachzehrers ravaged %their% monastery.} {Times are changing, though, and not even this skilled monstrum hunter can go it alone. %They% seeks to join a company and kill as many beasts as %they% can. | The days are uncharacteristically short and the moon blooms bright every night. This slayer feels a change in the air, and if %they%\'s going to fight what\'s coming %they%\'ll need more than just %themselves% to do it. | While not fond of company, the beast slayer wants to kill as many creatures as %they% can, and %they%\'ll need the help of some fine comrades to do just that. | In a world becoming more dangerous and desperate, the beast slayer seeks coin and company both. | A professional journey%person% such as this could be of great use to a mercenary company and you\'ve little doubt %they%\'ll be diligent in %their% death dealing. | Unfortunately, the %person% took an apprentice under %their% wings only for the kid to be slaughtered by a direwolf. The broken beast slayer now seeks sturdier company.}}";
	}

	o.onChangeAttributes = function () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.BeastSlayer);
	}

	o.onSetAppearance = function ()
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

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			items.addToBag(this.new("scripts/items/weapons/knife"));
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
			[1, ::Legends.Armor.Standard.leather_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			// [1, ::Legends.Helmet.Standard.hunters_hat],
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.None]
		]))
	}
})
