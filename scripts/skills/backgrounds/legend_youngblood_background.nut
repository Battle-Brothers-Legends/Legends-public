this.legend_youngblood_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendYoungblood);
		this.m.BackgroundDescription = "Youngbloods are students who have yet to prove themselves as capable witchhunters.";
		this.m.GoodEnding = "The time %name% spent in %companyname% was not something %they% was prepared for - for years %they% had learnt about the hidden horrors of the world in great detail, but seeing them come off the page and jump at %them% firsthand was an entirely new experience. Regardless, %they% thrived in %their% new practical studies and made a name for %themselves%, eventually retiring to a nameless hamlet of only a dozen people where %they% would take the occasional small contract to keep %their% skills sharp.";
		this.m.BadEnding = "%name% was a quick learner, but the divergence from theory to practice posed great difficulty. Although %they% did not now it, %they% struggled keeping pace with %companyname% and left shortly after you did. On %their% first night %they% found shelter from the elements in what %they% thought was an old cave - only to find out too late that it was a safe haven for hemovores.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Drunkard)
		];
		this.m.Titles = [
			"the Learner",
			"Alp Slayer",
			"Hagbane",
			"the Fang Collector",
			"the Student",
			"the Young",
			"the Kid",
			"the Bright"
		];
		this.m.Level = this.Math.rand(1, 2);

		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, { Bodies = ::Const.Bodies.FemaleMuscular, HairColors = ::Const.HairColors.Young }) : this.setBodyCharacteristics(_gender, { Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.YoungMale, HairColors = ::Const.HairColors.Young});
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+10[/color] Resolve at morale checks against fear, panic or mind control effects and can craft wooden stakes for use against vampires"
			}
		);
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=%positive%]+5%[/color] Experience Gain"
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		return "{%name% has always been a strange child, | %name% has had an odd upbringing, | %name% is a curious sort,} {so young but equally unswayed by the advances of either sex. | quiet and calculating, %they% often reacts indifferently to the pulls of glory and gold. | often forgoing the basic needs of most mercenaries almost as a form of penance.} {A few years ago, %they% shadowed two older witchhunters who taught %them% how to hunt a variety of horrors. | Picked up from %townname% at a young age, %they% had a different childhood to most. While other children heard about the horrors that would come for them while they slept, %name% was told how to kill them. | When %randomtown% was sacked by the undead, %name% stood proud and using a sling managed to kill a dozen of the dead, sitting out of their reach on a rooftop for several nights. | Led into the woods by %their% parents to die, %name% stumbled into an altercation involving a beasthunter and a witch, which started %their% reputation as a hag slayer. | At a young age, %they% left home in the middle of the night to live in the woods, shortly after %they% was picked up by a hunting party of witchhunters who used %them% as bait for a witch. %name% never felt so alive.} {Unfortunately, %their% tutorship was cut short when an unknown force destroyed the order %they% had been training under. While not a fully fledged witchhunter, %they% can still become one of the best - given time. | Being suddenly awoken from a hard day of study and training by a raging fire, %name% fled the order\'s stronghold with a few other students - who were gradually picked off in the wilderness. | %name% was almost killed during the siege on the order\'s stronghold, narrowly escaping from the burning fire and crumbling towers.'}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendYoungblood);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/legend_wooden_stake"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Standard.ragged_surcoat],
			[2, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.gambeson]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.full_aketon_cap],
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.open_leather_cap],
			[2, ::Legends.Helmet.None]
		]))
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.05;
		_properties.MoraleCheckBravery[1] += 10;
	}

});
