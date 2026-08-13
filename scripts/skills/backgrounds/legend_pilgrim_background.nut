this.legend_pilgrim_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendPilgrim);
		this.m.BackgroundDescription = "Dirty and tired, these disciples of the old gods look for clarity and power in their teachings.";
		this.m.GoodEnding = "%name% began %their% journey with you as a victim of circumstance, at odds with the rest of the world in %their% newfound predicament. Although they were not paid much %name% continued to spread your teachings to all who would listen. Seasons from then %they% would join the same holy order after it\'s monastery was burned down, setting out with like minded companions as a crusader.";
		this.m.BadEnding = "With your retirement from the company, %name% set out to spread the word of your teachings. Many did not take kindly to %their% words and often found %themselves% driven out of towns and into the wilderness. After one such instance %name% took shelter in an abandoned crypt, which quickly turned out to not be abandoned at all...";
		this.m.Titles = [
			"the Fanatic",
			"the Pious",
			"the Holy",
			"the Martyr",
			"the Devout",
			"the Wanderer",
			"the Believer",
			"the Faithful",
			"the Zealous"
		];
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack)
		];
		this.m.IsGuaranteed = [::Legends.Traits.new(::Legends.Trait.HateUndead)];
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.OffendedByViolence;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
	}

	function getTooltip() //nobody loves pilgrims
	{
		local ret = this.character_background.getTooltip();

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin().getID() == "scenario.legends_crusader")
		{
		ret.push({
			id = 19,
			type = "text",
			icon = "ui/icons/special.png",
			text = "No morale check triggered for non-pilgrim allies upon dying"
		});
		}

		return ret;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	function onBuildDescription() {
		// background descriptions have some differences and there's no point in uniting them
		if (this.isBackgroundType(::Const.BackgroundType.Female)) {
			return "{%name% has walked long and hard to almost all the holy sites. | As a shepherd\'s wife of a rural farm out in the hinterlands, %name% often dealt with trespassers. One day a budding necromancer and his three apprentices took the farm for herself. Her husband was slain and still wanders someplace between the world of the living and the dead. Ever since %name% has been looking for a way to avenge her husband\'s death and purge the land of the undead. | A fight with an innkeeper over the rates that they were charging for beds quickly escalated into a brawl. After the night watch broke up and took all of %name%\'s crowns for \'services\', they did what they could to find safe passage to her last designation. Thats where you come in. | A northerner with a hefty and well known family name marked %name% as a target the moment they set foot on the road alone with little more than a staff and good intentions. Bandits quickly descended upon her. Without passes and forms to prove her status as a pilgrim %name% had all but given up hope of ever getting out on the road again. | %name% talks at great lengths about her vocation as a missionary and woman of god. However a large stash of valuables they accumulate leads to to believe something more sinister is afoot.}";
		} else {
			return "{%name% has walked long and hard to almost all the holy sites. | As a farmhand in an orchard around the border towns of the south and north %name% lived a peaceful life until a throng of ancient dead swept through the village and burnt everything to the ground. Ever since a fire has burned in his heart to clean the land of the dead that still walk the earth. | Once a billman in service to a local lord, %name% quickly fell out of service when said lord was drowned in the river by an angry mob. Now with a target painted on his back, %name% tries to blend in to the crowd as a pilgrim. They say they always wanted to give 'this holy lark' a 'fair shake' anyway. | Born a bastard to a local lord, %name% lived most of his life in the countryside as a farmhand. One day a messenger arrived, escorted by a dozen or so footmen \'requesting\' that they come pay respects to a new lord of the land. Sensing a trap %name% made a break for it and spends his time far away from the nobility as possible. | %name% is lucky to be alive, if the tales are true then they are one of the few survivors of a small hamlet in the north swarming with undead. A local necromancer has since seized the hamlet for himself. Wanting to do more and reclaim his home, he now searches for the wisdom of the old gods to fight back.}";
		}
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendPilgrim);
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;

		if (this.Math.rand(1, 100) <= 66)
		{
			local body = actor.getSprite("body");
			local tattoo_body = actor.getSprite("tattoo_body");
			tattoo_body.setBrush("scar_01_" + body.getBrush().Name);
			tattoo_body.Color = body.Color;
			tattoo_body.Saturation = body.Saturation;
			tattoo_body.Visible = true;
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		local weapons = [
			"weapons/legend_staff",
			"weapons/legend_tipstaff"
		];

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.gambeson],
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.full_aketon_cap],
			[1, ::Legends.Helmet.Standard.open_leather_cap],
			[1, ::Legends.Helmet.Standard.full_leather_cap],
			[1, ::Legends.Helmet.Standard.straw_hat]
		]));
	}

	function onUpdate( _properties )
	{
	}

});

