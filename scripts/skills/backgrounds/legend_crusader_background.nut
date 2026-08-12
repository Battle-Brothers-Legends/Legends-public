this.legend_crusader_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendCrusader);
		this.m.Name = "Holy Crusader";
		this.m.Icon = "ui/backgrounds/background_54.png";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense
		];
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Good;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Combat | this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Untalented;
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.Student,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.BagsAndBelts,
				// ::Legends.Perk.LegendComposure,
				::Legends.Perk.Adrenaline,
				::Legends.Perk.LegendHolyFlame
			],
			[
				::Legends.Perk.Dodge,
				::Legends.Perk.RallyTheTroops,
				::Legends.Perk.LegendTrueBeliever,
			],
			[],
			[],
			[
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.LegendBattleheart,
				::Legends.Perk.LegendLionheart
			],
			[
				::Legends.Perk.InspiringPresence,
				::Legends.Perk.Fearsome,

			],
			[
				::Legends.Perk.LegendPerfectFocus
			],
			[],
			[],
			[],
			[]
		];

	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Faces = ::Const.Faces.PrettyFemale, HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Faces = ::Const.Faces.SmartMale, Hairs = ::Const.Hair.TidyMale, Beards = ::Const.Beards.Tidy});
	}

	function onBuildDescription()
	{
		return "%name% lives to fight the undead scourge. Little is known about %them% and %they% almost never talks save for the occasional grunt while swinging %their% sword. %Their% language seems to be codified into one simple structure: killing creatures of evil.";
	}

	function onSetAppearance()
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

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendCrusader);
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Holy Avenger");
	}

function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeDefense] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/legend_zweihander"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.mail_hauberk],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.scale_armor],
			[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			[1, ::Legends.Armor.Standard.worn_mail_shirt]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.bascinet_with_mail],
			[1, ::Legends.Helmet.Standard.closed_flat_top_helmet]
		]);
		if (item != null)
		{
			item.onPaint(this.Const.Items.Paint.None);
			items.equip(item);
		}

	}
});
