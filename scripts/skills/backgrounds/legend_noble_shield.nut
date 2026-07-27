this.legend_noble_shield <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create() {
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendNobleShield);
		this.m.Name = "Foot Soldier";
		this.m.Icon = "ui/backgrounds/background_nobleshield.png";
		this.m.HiringCost = 300;
		this.m.DailyCost = 35;
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
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.GoodEnding = "A supporter of your cause from the start, %name%, has joined you in retirement, leaving the company not long after you did. Though %they% was a lowly peasant, %they% proved %themselves% in battle after battle and slowly became as trusted and valued a friend as one can find in a mercenary company.";
		this.m.BadEnding = "Supporting you from the start, %name% was as loyal as %they% was talented. %They% stayed with the company for a time before eventually leaving to forge out a path for %themselves%. The other day, you received a letter from the mercenary stating that %they% had started %their% own company and was in dire need of help. Unfortunately, the message was dated to nearly a full year ago. When you investigated the existence of %their% company, you learned that it had been completely annihilated in a battle between nobles.";
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SpearTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.SwordTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.FastTree,
				::Const.Perks.TrainedTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [],
			Profession = [],
			Magic = []
		};
	}

	function setGender( _gender = -1 ) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender);
		
	}

	function onBuildDescription() {
		return "%name% is not known to be a big talker, but %they% has every right to be. {%They're% saved the lives of many of the company. | %They% once spared you from an orc\'s wicked chain. | An assassin would have killed the local noble in a pub were it not for this %person%. | A misfired crossbow nearly took out your eye - hadn\'t %name%\'s shield been there to stop it. | %They% once pushed two men off a cliff using only %their% shield and two strong legs. | %They% learned how to fight from %their% father, a vanguard at the Battle of Many Names. | Sacrificing %their% family\'s heirloom - an old shield of wood and studded iron - %they% saved the local noble\'s life. | A %person% of rather consistent heroism, %they% pulled a drunken captain from a pub fire. | Faced with a horde of goblins, %they% used %their% shield and strength to push a hole in their lines, opening the way for the rest of %their% company to kill them all.} With quick whirls and whips of %their% shield, the %person%\'s deflected all manner of mortal danger. Although rather quiet, you\'ve found %name%\'s place in a shield-wall to be rather indispensable.";
	}

	function onPrepareVariables( _vars )
	{
		_vars.extend(this.World.Assets.getFounderNames());
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendNobleShield);
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

		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[2, ::Legends.Armor.Standard.basic_mail_shirt]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[10, ::Legends.Helmet.Standard.aketon_cap],
			[10, ::Legends.Helmet.Standard.open_leather_cap],
			[10, ::Legends.Helmet.Standard.kettle_hat],
			[10, ::Legends.Helmet.Standard.padded_kettle_hat],
			[10, ::Legends.Helmet.Standard.kettle_hat_with_mail],
			[10, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.legend_enclave_vanilla_armet_02],
			[1, ::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01]
		]));
	}
});
