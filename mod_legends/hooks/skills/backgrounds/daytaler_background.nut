::mods_hookExactClass("skills/backgrounds/daytaler_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Daytaler);
		this.m.BackgroundDescription = "Daytalers are used to all kinds of physical work, but don\'t excel in any.";
		this.m.GoodEnding = "%name% the daytaler retired from fighting and, well, %they% keeps working with %their% hands. Now %they're% back to laying bricks and carrying hay instead of slaying beasts and crushing heads. %They% took all %their% mercenary money to purchase a bit of land and settle down. While not the richest %person%, word has it that there is hardly a happier %person% in the realm.";
		this.m.BadEnding = "%name% retired from fighting while %they% still had most of %their% fingers and toes intact. %They% went back to working for the nobility. Last you heard %they% was out {south | north | east | west} building a great tower for some nobleman. Sadly, you also heard that tower collapsed halfway through its construction with many workers going down with it.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins)
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.PerkTreeDynamicMins.ClassChance += 0.20;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});

		if (_gender != 1) return;
		this.m.Name = "Washerwoman";
		this.m.Icon = "ui/backgrounds/background_washerwoman.png";
		this.m.BackgroundDescription = "Washerwomen are used to all kinds of physical work, scrubbing isn\'t easy work.";
	}

	o.onBuildDescription <- function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{Working here and there | With no steady work | Working on and off | Doing this and that | Having learned no craft}, %name% is known as a washerwoman, someone to ask whenever the linens need their rinse. {Work had been sparse for a while now, so | There was little work to be a had these past weeks, so | %name% wanted to do something she had not done before, so | Despite having no experience in battle, staring too deep into the bottle made her believe that | %name% considered the fighting profession one that doesn\'t run out of work these days, so | %name% lost her loved one to sickness, as befalls so many these days, and broke down. After weeks blurred by drinking her sorrows away,} a travelling mercenary company seemed a good opportunity {to seek redemption | to earn some coin | to see a bit of the world | to clear her head | to get her to the next village while filling her pockets}.";
		}
		else
		{
			return "{Working here and there | With no steady work | Working on and off | Doing this and that | Having learned no craft}, %name% is known as a daytaler, someone to ask whenever an extra hand is needed. {Work had been sparse for a while now, so | There was little work to be a had these past weeks, so | %name% wanted to do something he had not done before, so | Despite having no experience in battle, staring too deep into the bottle made him believe that | %name% considered the fighting profession one that doesn\'t run out of work these days, so | %name% lost his loved one to sickness, as befalls so many these days, and broke down. After weeks blurred by drinking his sorrows away,} a travelling mercenary company seemed a good opportunity {to stay with for a while | to earn some coin | to see a bit of the world | to clear his head | to get him to the next village while filling his pockets}.";
		}

	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Daytaler);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_hammer"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_saw"));
		}


		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.linen_tunic, this.Math.rand(6, 7)],
			[1, ::Legends.Armor.Standard.gambeson]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.headscarf],
			[4, ::Legends.Helmet.None]
		]));
	}
});
