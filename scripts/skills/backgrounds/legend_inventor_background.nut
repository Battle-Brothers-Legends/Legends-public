this.legend_inventor_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendInventor);
		this.m.Name = "Inventor";
		this.m.Icon = "ui/backgrounds/background_inventor.png";
		this.m.BackgroundDescription = "Inventors are trenchant problem solvers, fueled by a burning passion for knowledge.";
		this.m.GoodEnding = "%name% initially did not fit in well with %companyname%, but given time everyone saw %their% value in setting both weapons and joints back together. %They% took their small fortune and set up a workshop to call %their% own, accidentally creating a mortar that did not fire up in the air, but rather directly at the enemy.";
		this.m.BadEnding = "%name% was a misfit from the start, %their% lack of skill on the battlefield held %them% back compared to %their% stronger mercenary counterparts. %Their% journey ironically ended not on the battlefield but instead in %their% workshop, which now stands only a charred ruin.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Superstitious)
		];
		this.m.Titles = [
			"the Inventor",
			"the Curious",
			"the Peculiar",
			"the Inquisitive",
			"the Utilitarian",
			"the Serendipitous",
			"the Eclectic",
			"the Tinkerer"
		];
		this.m.BackgroundType = this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=%positive%]+20%[/color] Experience Gain"
			}
		);
		return ret;
	}

	function setGender (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.YoungMale, HairColors = ::Const.HairColors.Young});
	}

	function onBuildDescription() {
		return "{Having spent most of %their% life in and around %townname%, covered in books, conducting various experiments and creating all sort of contraptions, %name% eventually turned %their% eyes towards knights, soldiers, sellswords, brigands and others that live and die by the sword. Perhaps %their% knowledge could be applied to their circumstances? Could %they% possibly become a great fighter %themselves%? Tempted and intrigued by %their% own thoughts, %they% wasted no time setting out to look for a mercenary company that would consider taking %them% in. What could go wrong?}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendInventor);
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle(this.Const.Strings.InventorTitles[this.Math.rand(0, this.Const.Strings.InventorTitles.len() - 1)]);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.apron]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.mouth_piece],
			[1, ::Legends.Helmet.Standard.headscarf]
		]));

		r = this.Math.rand(0, 1);
		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
	}
	function onUpdate (_properties)
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.2;
	}
});
