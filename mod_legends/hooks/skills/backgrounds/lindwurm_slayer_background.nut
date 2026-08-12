::mods_hookExactClass("skills/backgrounds/lindwurm_slayer_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LindwurmSlayer);
		this.m.Name = "Lindwurm Slayer";
		this.m.Icon = "ui/backgrounds/background_71.png";
		this.m.BackgroundDescription = "This mercenary is a one of a kind Lindwurm hunter, descendant of Dirk the Dragonslayer.";
		this.m.GoodEnding = "%name% left the %companyname% and started a lucrative career as a \'dragon specialist\' advisor to the nobility. As far as you can tell %they% does very little actual work, instead spending %their% days attending lavish banquets, entertaining hosts and their guests with war-stories whilst quaffing their wine.";
		this.m.BadEnding = "Disillusioned with the %companyname%, %name% left to pursue a solo dragon hunting career in order to finally live-up to the legacy of %their% famous father. %They% was last seen taking odd beast hunting contracts, but news of his exploits has no spread far and you fear the worst.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Weasel)
		];
		this.m.Level = this.Math.rand(2, 4);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% is a supposedly famous monster hunter with a particular talent for slaying lindwurms. They says %they% is the %offspring% of Dirk the Dragonslayer, the monster hunter who ostensibly slew the last living dragon.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LindwurmSlayer);
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();
	}

	o.onAddEquipment = function ()
	{
		local actor = this.getContainer().getActor();
		actor.setVeteranPerks(3);
		local items = actor.getItems();
		local r;

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/fighting_spear"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/noble_sword"));
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Named.lindwurm_armor]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.feathered_hat],
			[1, ::Legends.Helmet.Standard.headscarf],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.greatsword_hat]
		]));
	}

});
