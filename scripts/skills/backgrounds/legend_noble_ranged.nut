this.legend_noble_ranged <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.LegendNobleRanged);
		this.m.Name = "Arbalester";
		this.m.Icon = "ui/backgrounds/background_nobleranged.png";
		this.m.DailyCostMult = 1.0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.MeleeSkill,
			this.Const.Attributes.MeleeDefense
		];
		this.m.GoodEnding = "A supporter of your cause from the start, %name%, has joined you in retirement, leaving the company not long after you did. Though %they% was a lowly peasant, %they% proved %themselves% in battle after battle and slowly became as trusted and valued a friend as one can find in a mercenary company.";
		this.m.BadEnding = "Supporting you from the start, %name% was as loyal as %they% was talented. %They% stayed with the company for a time before eventually leaving to forge out a path for %themselves%. The other day, you received a letter from the mercenary stating that %they% had started %their% own company and was in dire need of help. Unfortunately, the message was dated to nearly a full year ago. When you investigated the existence of %their% company, you learned that it had been completely annihilated in a battle between nobles.";
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.CrossbowTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.BowTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.FastTree,
				::Const.Perks.AgileTree,
				::Const.Perks.FitTree,
				::Const.Perks.ViciousTree
			],
			Enemy = [
				::Const.Perks.OutlawTree,
				::Const.Perks.CivilizationTree
			],
			Profession = [],
			Class = [],
			Magic = []
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender);
	}

	function onBuildDescription() {
		return "%name% is one of the more talented marksmen you\'ve encountered in your travels. {After %they% saved your life with an arrow shot straight into the heart of a would-be assassin, you hired the %person% on the spot. | Learning of the %person% was easy - you just had to find the winner of a local shooting competition. | %They% once won an archery contest that had over a hundred participants from all the lands. | It is said that %they% can split an arrow - mid-flight. | You found the %person% on a farm where, obviously, you thought %their% shooting talents were going to waste. | A poacher, a bowyer, an archer, the %person%\'s skills have gotten plenty of use. You suspect %they% readily accepted your offer for mercenary work just to say \'%they're% done it all\'. | You once saw %them% shoot the moon, but that may have been some sort of trick. | A clever bowman, %they% once loosed two arrows simultaneously to kill a charging set of brigands.} While %they% has a fondness for killing from afar, %name%\'s no slouch in close-quarters combat.";
	}

	function onPrepareVariables( _vars )
	{
		_vars.extend(this.World.Assets.getFounderNames());
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendNobleRanged);
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 3) == 3)
		{
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
		}

	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickHelmet([
			// [3, ::Legends.Helmet.Standard.hunters_hat],
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.open_leather_cap]
		]));

		items.equip(this.new("scripts/items/weapons/light_crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/knife"));

		items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.basic_mail_shirt]
		]));
	}

});
