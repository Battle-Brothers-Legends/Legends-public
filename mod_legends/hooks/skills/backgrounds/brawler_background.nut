::mods_hookExactClass("skills/backgrounds/brawler_background", function(o)
{
	o.create = function()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Brawler);
		this.m.Name = "Brawler";
		this.m.Icon = "ui/backgrounds/background_27.png";
		this.m.BackgroundDescription = "Brawlers are unmatched in unarmed combat, and physical exercise tends to leave them in good shape.";
		this.m.GoodEnding = "A brawler like %name% is dangerous with just %their% fists, and proved %themselves% similarly savage with weapons. Before you left the %companyname%, you talked to the fighter about whether or not %they%\'d stay in the band. %They% said %they% had no desire to return to prizefighting, shook your hand, and thanked you for giving %them% the opportunity. Last you heard, the company chose %them% for a one-on-one, winner take all fight to settle compensation differences with a competing mercenary band. %They% won in the first round.";
		this.m.BadEnding = "%name% the brawler left the company when it became clear it would soon dissolve and probably end up killing everyone who stayed onboard. %They% returned to prizefighting, grinding out the following years in brutal, weekly bouts. As %they% got older, %their% chin disappeared, as did %their% speed and power. %They% was left jobbing, intentionally taking falls and losing badly when %they% didn\'t. Eventually, no one would give %them% a fight. A nobleman offered %them% a large sum to wrestle a bear and the desperate %name% took %them% up on it. When the \'fight\' was over, the brawler lay dead, mangled beyond recognition, being dragged around the mud by a ferocious beast as drunken highborn cheered and clapped.";
		this.m.HiringCost = 84;
		this.m.DailyCost = 13;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Tiny)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Level = this.Math.rand(1, 2);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Lowborn;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.DaggerTree,
				::Const.Perks.MaceTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.FistsTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.LargeTree,
				::Const.Perks.FitTree,
				::Const.Perks.FastTree,
				::Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleMuscular}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	o.onBuildDescription <- function()
	{
		return "{Burly and with churchbells for fists, %name% has spent much of the past year sharpening %their% boxing skills on the grindstone that is %their% fellow man. | With a face contorted to the shapes of others\' knuckles, it\'s not hard to realize that %name% is a career fighter. | %name% loves the drink as much as %they% does a good fight, a potent combination. | A hard upbringing by %their% father and brothers honed %name% into being a temperamental fighter. | Bullies in %name%\'s spriteful youth forged %them% into a %person% that prefers to seek out a fight rather than wait for it to come to %them%.  | %name% only ever had one real talent: using %their% fists to bloody the noses of men and not going down no matter what. | Growing up, %name% wrestled bulls on the family farm. Unfortunately for men, %they% found time to venture into the cities.} {For the past year %they% has been employed by a local lord, paraded around to fistfight the champions of royalty. | A lover of the bar brawl, the %person% has apparently been banned from too many taverns to count. | Gaining notoriety as a fighter in %randomtown% meant %they% had to fight every single proud, boasting, and drunk man who came %their% way. | Although %they% became an undefeated prizefighter, %they% was hardly earning enough to get by. | Fiery in spirit, %they're% always willing to take up fisticuffs. Local fighting rings say %they're% got a mean left hook.} {Hearing of greater fights to be had, %name% has put down %their% mitts to take up the more lucrative vocation of being a sellsword. | Only one person has bested %name%: %their% %partner%. After being chided for being an embarrassment with no ambition, %they% decided to take up the more \'prestigious\' field of mercenary work. | Years of martial combat practically destroyed %their% memory. Some think %they% mistook a mercenary camp as an item on %their% shopping list. | Very low on crowns and barely able to open %their% broken hands to hug %their% own son much less throw a punch, %name% seeks a new career. | After years of hardship, the promise of regular pay for mercenary work is a tempting offer for %them%, even though %they% has little idea of actual warfare. | This %person% could murder a rock and injure a stone - a good addition to any outfit.}";
	}

	o.onChangeAttributes = function()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Brawler);
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=%positive%]5%[/color] bonus damage to [color=#400080]Hand to Hand[/color] and [color=#400080]Choke[/color]"
		});
		return ret;
	}

	o.onAdded <- function()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.BrawlerTitles[this.Math.rand(0, this.Const.Strings.BrawlerTitles.len() - 1)]);
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps]
		]));
		items.equip(this.new("scripts/items/accessory/gloves/legend_hand_wraps_item"))
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChoke) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand))
		{
			_properties.DamageTotalMult *= 1.05;
		}
	}
});
