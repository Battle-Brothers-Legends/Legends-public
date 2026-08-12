::mods_hookExactClass("skills/backgrounds/killer_on_the_run_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.KillerOnTheRun);
		this.m.Name = "Killer on the Run";
		this.m.Icon = "ui/backgrounds/background_02.png";
		this.m.BackgroundDescription = "A killer on the run may kill again, and %they% knows where to aim.";
		this.m.GoodEnding = "Always a risk taker, you accepted %name% into the %companyname%\'s ranks despite %them% being a killer on the run. It worked in your favor as %they% proved %themselves% an able and brave sellsword. As far as you know, %they% is still with the company, thoroughly enjoying every \'business\' opportunity it affords %them%.";
		this.m.BadEnding = "While many doubted the risk of hiring a killer on the run such as %name%, the %person% did prove %themselves% a very capable sellsword. Unfortunately, an old life never trails far behind and bounty hunters kidnapped %them% in the night. You can find %their% skeleton squatting in a gibbet fifty feet in the air.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic)
		];
		this.m.Titles = [
			"Darkhearted",
			"Backblade",
			"Throatslash",
			"on the Run",
			"the Wanted",
			"the Murderer"
		];
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=%positive%]+10%[/color] Chance To Hit Head"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()	{
		return "{%fullname% has a face that no one desires - one fit for a wanted poster. | With blood on %their% hands, %name% resembles a %person% recently described to you by bounty hunters. | %name% looks about ready to join any outfit - or disappear into its ranks. | Upon meeting people, %name% stammers out %their% name as if reluctant to part with it.} {Recognizing %name% is no hard feat: this %person% is a known-murderer, the blood of both %their% cuckolding %partner% and " + (this.isBackgroundType(this.Const.BackgroundType.Female) ? "his" : "her") + " lover on %their% hands. | %Their% eyes are dark and shifting. There is a crime behind them, but also a sense of humanity, as if %they% knows %they% has done wrong and is looking to make amends. | Mud stands up to %their% legs. %They're% been running for a long time. %Their% hands tremble, too, for %their% legs run from what %their% hands have done. | They say %they% killed %their% newborn daughter, having always wanted a son instead. | Some believe %they% struck down a man in self-defense. | Being blackmailed with scandalous information, it\'s hard to blame the %person% for what %they% has done.} {Even if %they% has done wrong, a party of killers could use a %person% such as %they%. But can the %person% be trusted? | %name%\'s eyes skirt from yours. When you ask how %they% is with a weapon, %they% mumbles about only having to hit \'the man\' once. | A %person% of %name%\'s physique could be useful, but how much can you depend upon a %person% whose former life was one of being on the run? | The %person% chamfers on %their% fingernails like a beaver would a tree. %They're% jumpy, but maybe that\'s a good thing in this world. | Mercenary bands are just the thing for a %person% like %them%.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.KillerOnTheRun);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood]
		]));
	}

	o.onUpdate = function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}
});
