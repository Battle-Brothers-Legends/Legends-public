::mods_hookExactClass("skills/backgrounds/bastard_background", function (o) {
	o.create = function () {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Bastard);
		this.m.BackgroundDescription = "Bastards often have profited from some training in melee fighting and know the weaknesses of noble armies.";
		this.m.GoodEnding = "{%name%, the bastard %offspring% of a familially inconsiderate nobleman, departed the %companyname% to try to carve out %their% own family lineage. The last you heard, %they%\'d managed to acquire %themselves% a good plot of land and a modest stone castle rests on it. While successful, %they% still harbors resentment for %their% family. | A bastard %offspring% of a nobleman, %name% couldn\'t help but always have that lingering feeling %they% just didn\'t belong in this world. But the %companyname% gave %them% a brotherhood to call family. As far as you know, %they% still fights with the company to this day.}";
		this.m.BadEnding = "Bastards like %name% usually don\'t get far in this world. They\'re too hated in the highborn world in which they live, and hated by the lowborn because they don\'t understand the politics that would make a bastard more common to them than any nobleman. Not long after you left the company, you got wind of %name%\'s passing. Apparently, a young and cruel lord took over %their% noble house and saw the bastard as a threat to %their% throne. Despite the bastard wanting nothing to do with that life anymore, it managed to catch up with %them% anyway. %They% was assassinated in a tavern bed, %their% throat cut as %they% slept.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles)
		];

		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Level = ::Math.rand(1, 3);
		this.m.BackgroundType = ::Const.BackgroundType.Combat;
		this.m.PerkTreeDynamicMins.Defense = 3;
	}

	o.getTooltip = function () {
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.TidyMale, HairColors = ::Const.HairColors.Young, Beards = ::Const.Beards.Tidy});
	}

	o.onBuildDescription <- function () {
		return "{%name% was born during a fiery military campaign far away from %their% father\'s home. | %name%\'s mother hailed from a pub in %randomtown%. Which is strange, because %their% father is a married royal in %townname%. | With a wife cursed by a witch, %name%\'s father gave himself to another woman to \'continue\' the bloodline. | With the king away so long, %name%\'s queen of a mother could hardly resist the temptations of a local servant. | %name% was born nine months after raiders pillaged %their% parents\' castle.} {The life of a bastard was not an easy one: the %person% was constantly hounded by jealous half-%sibling%s. | Like some kind of royal leper, the bastard was kept far away from the public eye. | Thankfully, for much of %their% life %name% knew not that %they% was a bastard child. | A controversy at birth, %name% was only spared abandonment by the omens of a local oracle. | Being a royal bastard gave the %person% a good life, so long as %they% kept his head low, and %their% unwanted status even lower. | Hatred by both strangers and family steeled the bastard for the eventual difficulties outside %their% royal upbringing.} {Angered by %their% role in life, %name% did attempt a coup to take the throne. It did not go far. %They% is now banished from every court in the land. | When a half-%sibling% pelted %them% with stones, %name% felt little remorse running the sibling through with a sword. %They% blamed it on a servant, but quickly left %their% royal housing thereafter. | %name%\'s father tried to pass %them% off as legitimate, but when a royal marriage fell through the ensuing scandal of impropriety proved too much. The bastard now roams the land, free of the shackles of controversy. | Being the oldest %offspring% in line made %name% a target for %their% younger, legitimate brothers. It was an easy choice to leave that life of politics and backstabbing. | Found in bed with a sibling, the scandals in %name%\'s life grew far too heavy to stay in the royal courts. | Tired of the trivialities of royal processions, %name% only wishes to join a group of men that care not for bloodlines and legitimacy. | When an assassin poisoned %their% father\'s wine, %name% was quickly blamed for the murder. Escaping an angry mob was only the beginning of an exciting, new life. | While %they% came to love %them% dearly, %name%\'s father knew the royal court was not safe. %They% sent the %person% away to forge a life on %their% own terms.}";
	}

	o.onChangeAttributes = function () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.Bastard);
	}

	o.onAdded <- function () {
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendHateNobles);
		}
		this.character_background.onAdded();

		if (::Math.rand(0, 4) == 4) {
			this.getContainer().getActor().setTitle(::Const.Strings.BastardTitles[::Math.rand(0, ::Const.Strings.BastardTitles.len() - 1)]);
		}
	}

	o.onAddEquipment = function () {
		local items = this.getContainer().getActor().getItems();
		local r = ::Math.rand(0, 2);

		if (r == 0) {
			items.equip(this.new("scripts/items/weapons/falchion"));
		} else if (r == 1) {
			items.equip(this.new("scripts/items/weapons/shortsword"));
		} else if (r == 2) {
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}

		r = ::Math.rand(0, 1);

		if (r == 0) {
			items.equip(this.new("scripts/items/shields/heater_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.padded_surcoat]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
			[1, ::Legends.Helmet.Standard.hood]
		]));
	}
});
