::mods_hookExactClass("contracts/contracts/obtain_item_contract", function(o)
{
	o.m.Items <- [
		"Fingerbone of Sir Gerhardt",
		"Blood Vial of the Holy Mother",
		"Shroud of the Founder",
		"Elderstone",
		"Staff of Foresight",
		"Seal of the Sun",
		"Starmap Disc",
		"Forefathers\' Scroll",
		"Petrified Almanach",
		"Coat of Sir Istvan",
		"Staff of Golden Harvests",
		"Prophet\'s Pamphlets",
		"Forefathers\' Standard",
		"Seal of the False King",
		"Flute of the Debaucher",
		"Dice of Destiny",
		"Fetish of Fertility",
		"Everburning Lantern",
		"Blue Crystal Staff",
		"Raincaller Amulet",
		"Grimoire of Fate",
		"Frogir\'s Hammer",
		"Tome of the All-Father",
		"Sunstone Crown",
		"Silver Sheep Horn",
		"Elder Lute",
		"Harvest Horn",
		"Shin of Saint Gorm",
		"Horseshoe of Healing",
		"Lucky Wolf Paw",
		"Beads of Fortune",
		"Guardian Totem",
		"Ancestor\'s Stone",
		"Dragon Shield",
		"Bell of Saint Marla",
		"Emberstone",
		"Veil of the Mourning Maiden",
		"Blood Cup of the Founding",
		"Banner of Blackmere",
		"Lucky Pig Statue",
		"Cracked Chalice",
		"The Witchling Blade",
		"Chain of Silent Bells",
		"Cradle Stone",
		"Lantern That Burns Cold",
		"Iron Circlet of Might",
		"Wax-Sealed Jar of Storms",
		"Rune Pebble Marked In Blood",
		"Saltstone Pendant",
		"Bone Disc of Saint Corven",
		"Warding Ring of Nine Etchings",
		"Banner of the Mudwall Militia",
		"Ledger of the Town\’s First Tax Evasion",
		"Broken Sword That Ended the Pig War",
		"Mask of the Festival Goat",
		"Cloak of the Rainbringer",
		"Sun-Fired Chalice",
		"Basket Woven by the Blind Prophet",
		"Bell of Good Tidings",
		"Windchimes of Safe Passage",
		"Crown of Hollow Branches",
		"Black Tear of Vellorien",
		"Grinning Idol",
		"Amulet of Silent Waters",
		"Coin of Returning Death",
		"Mask That Whispers Back",
		"Thorn-Crowned Skull",
		"Scepter of Dust",
		"Sigil of the Old Gods",
		"Dice of Arren Gee",
		"Blade of Quiet Mercy",
		"Dagger of the Ninth Tongue",
		"Chain of the Heretic Knight"
	];

	local create = o.create;
	o.create = function() {
		create();
		this.m.DescriptionTemplates = [
			"Townsfolk claim that a missing relic belonging to them has turned up in a nearby location. The place is allegedly cursed.",
			"Rumors of some fancy lost relic being unearthed in nearby ruins has begun to circulate among the local inns.",
			"Tales of lost treasure have been drawing adventurers and thrill-seekers to these parts for years.",
			"A blessed local item which went missing years ago has reportedly been sighted in the wilds.",
			"The relic is likely fake of course, but you\'ll accept coin to retrieve it anyway.",
			"You get to be the latest in a long-line of missing adventurers sent to find some local bauble.",
			"You doubt this yokel relic even exists. Still, people have gone missing, so there is danger.",
			"\'No-one ever comes back\'. Oh, you have a great feeling about this one.",
			"Steal a relic, which may not exist, from a dangerous location which most folk don\'t return from. Perfect.", //
			"The inns are full of locals telling tall tales about mighty artifacts of power.",
			"A relic could make a mighty profit or prize, if it turns out to be real of course",
			"Whispers of a long-lost relic discovered in the nearby forest have the townsfolk buzzing with excitement.",
			"Like many others before you, you get a chance to die seeking some fabled local item.",
			"Relics? Load of old dung in your opinion. At least the job pays well.",
			"Based on nothing but rumour & hearsay, you\'ll be paid to investigate some local legend.",
			"A shepard claims to have found the burial site of a holy relic. Sounds like a load of hogwash, but you will be paid to investigate.",
			"Reports of a lost artifact supposedly discovered in an abandoned temple have piqued local interest.",
			"Whispers of a long-lost relic discovered in the nearby forest have the townsfolk buzzing with excitement.",
			"The inns are full of locals telling tall tales about the mighty %s.",
			"The %s would make a mighty profit or prize, if it turns out to be real of course",
			"Talk of the long-lost %s has been discovered nearby has the townsfolk buzzing with excitement.",
			"Like many others before you, you get a chance to die seeking the fabled %s.",
			"%s? Load of old dung in your opinion. At least the job pays well.",
			"Based on nothing but rumour & hearsay, you\'ll be paid to investigate the legendary %s.",
			"A shepard claims to have found the burial site of the %s. Sounds like a load of hogwash, but you will be paid to investigate.",
			"The location of the mighty %s has been a closely guarded secret for years.",
			"The %s is legendary in these parts. You\'ll be paid well to locate it."
		];
	}

	local start = o.start;
	o.start = function () {
		start();
		this.m.Flags.set("ItemName", ::MSU.Array.rand(this.m.Items));
	}

	// Ran when we actually add the contract
	o.formatDescription <- function ()
	{
		if (!this.m.Flags.has("ItemName"))
			this.m.Flags.set("ItemName", ::MSU.Array.rand(this.m.Items));

		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Flags.get("ItemName"), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}


	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				s.end <- function ()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					this.Contract.m.Destination.clearTroops();
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					this.Contract.m.Destination.setLootScaleBasedOnResources(100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

					if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
					{
						this.Contract.m.Destination.getLoot().clear();
					}

					this.Contract.m.Destination.setDiscovered(true);
					this.Contract.m.Destination.m.IsShowingDefenders = false;
					this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
					local r = this.Math.rand(1, 100);

					if (r <= 10)
					{
						this.Flags.set("IsRiskReward", true);
						local weapons = [
							"weapons/ancient/ancient_sword",
							"weapons/ancient/crypt_cleaver",
							"weapons/ancient/rhomphaia",
							"weapons/ancient/khopesh",
							"weapons/ancient/warscythe",
							"weapons/ancient/legend_gladius",
							"weapons/ancient/bladed_pike"
						];

						local item =  this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
						this.Contract.m.RiskItem = item;
					}

					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				}
			}
		}
	}
});
