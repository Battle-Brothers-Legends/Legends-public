::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o)
{
	o.m.Tattoo <- 0;
	o.create = function ()
	{
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin;
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Barbarian);
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the barbarian took all the coin %they% earned with the company and ventured north. With %their% money, %they% gathered a band of warriors and conquered so many tribes that, last you heard, %they% had been ordained \'king of the north\'.";
		this.m.BadEnding = "With things the way they were, %name% departed. Last you heard %they% was traveling north. Penniless with little to %their% name but an axe, and not looking anything like the natives or speaking their tongue, you figure the barbarian did not get far. Based upon what you\'ve seen happen to %their% ilk, %they're% either been killed already or captured as a slave.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive)
		];
		this.m.Titles = this.Const.Strings.BarbarianTitles;
		this.m.Ethnicity = 0;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Druid | this.Const.BackgroundType.ExpertHunter;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.WildMale}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Faces = ::Const.Faces.WildMale, Hairs = ::Const.Hair.WildMale, Beards = ::Const.Beards.WildExtended});
	}


	o.onBuildDescription <- function ()	{
			return "{%name% survived the battle between yourself and %their% own tribe of warriors. %They% offered %themselves% to your company or to your sword. Impressed by %their% bravery, you chose to take %them% in. A foreign brute, %they% hardly speaks your native tongue and %they% is not well liked by the rest of the company. But if anything can bond two people it is fighting beside one another, killing when it counts, and drinking the night away at the tavern.}";
	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Tattoo = tattoos[this.Math.rand(0, tattoos.len() - 1)];
			local tattoo_body = actor.getSprite("tattoo_body");
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_head = actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
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
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
		}
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Barbarian);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 3);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Barbarian.thick_furs_armor],
			[1, ::Legends.Armor.Barbarian.reinforced_animal_hide_armor],
			[1, ::Legends.Armor.Barbarian.hide_and_bone_armor],
			[1, ::Legends.Armor.Barbarian.scrap_metal_armor]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.bear_headpiece],
			[1, ::Legends.Helmet.Barbarian.leather_headband],
			[1, ::Legends.Helmet.Barbarian.leather_helmet]
		]))
	}

	o.onSerialize = function ( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	o.onDeserialize = function ( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});
