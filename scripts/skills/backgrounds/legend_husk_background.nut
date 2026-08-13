this.legend_husk_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendHusk);
		this.m.BackgroundDescription = "Once imbued with the will of a dead god, the departing of said god left this one...unpredictable.";
		this.m.GoodEnding = "The cultist, %name%, left the company with a band of cloaked converts. You know not what became of the fanatic, but every so often they appear in your dreams. Often standing alone in a great void and there is always someone, or something, lingering in the black beyond. Every night, this image gets a little more clear, and each night you find yourself staying up later and later just to avoid dreaming at all.";
		this.m.BadEnding = "You heard that %name%, the cultist, left the company at some juncture and went out to spread the faith. There\'s no telling what became of the fanatic, but there was a recent inquisition against unholy faiths and hundreds of \'folk in dark cloaks with even darker intentions\' were burned at the stake across the realm.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"the Cultist",
			"the Mad",
			"the Believer",
			"the Occultist",
			"the Insane",
			"the Follower",
			"the Lost",
			"the Odd",
			"the Misguided",
			"the Fanatic",
			"the Zealot"
		];
		this.m.IsGuaranteed = [::Legends.Traits.new(::Legends.Trait.Mad)];
		this.m.Level = this.Math.rand(1, 2);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.BackgroundType = this.Const.BackgroundType.Cultist | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Faces = ::Const.Faces.OldFemale, HairColors = ::Const.HairColors.Old}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	function onBuildDescription() {
		return "{With a mind torn in half and nowhere else to go, %name% is a mess of gibbering voices and flailing fists at unseen attackers. | %They% clutch at imaginary insects and brush at unseen horrors crawling over %their% skin. | Their face an ever shifting soup of expressions. | Clothed in rags and decayed metal %they% stamp and struggle as if the earth was trying to swallow %them% whole. | Words are carved into %their% hands, face and any other virgin flesh available. | %name% spits and chitters at seemly mundane items as if every one of %them% were made from %their% own flesh. | The only constant in all this madness is a singular phrase, as you approach %them% you recite the words ingrained into your mind...} \"Davkul awaits\" you announce. %name% recomposes %themselves% instantly. \"Davkul awaits us all\" %they% reply, with perfect cadence.";
	}

	function isCultist() {
		return true;
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will never be sacrificed to Davkul"
			}
		);
		return ret
	}

	

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendHusk);
	}

	function onSetAppearance()
	{
		if (!this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			local actor = this.getContainer().getActor();
			local tattoo_body = actor.getSprite("tattoo_body");
			local tattoo_head = actor.getSprite("tattoo_head");

			if (this.Math.rand(1, 100) <= 50)
			{
				local body = actor.getSprite("body");
				tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
				tattoo_body.Visible = true;
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				tattoo_head.setBrush("tattoo_01_head");
				tattoo_head.Visible = true;
			}
		}
	}

	function updateAppearance()
	{
		if (!this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			local actor = this.getContainer().getActor();
			local tattoo_body = actor.getSprite("tattoo_body");

			if (tattoo_body.HasBrush)
			{
				local body = actor.getSprite("body");
				tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
			}
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/legend_bone_carver"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_reinforced_flail"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}
		else if (r == 4)
		{
		 items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk],
			[1, ::Legends.Armor.Standard.decayed_coat_of_plates]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.cultist_hood],
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.Standard.cultist_leather_hood]
		]));
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.getContainer().getActor().getFlags().add("cultist");
	}
});
