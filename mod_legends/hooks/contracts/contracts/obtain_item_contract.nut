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
			"Dragon Shield"
		];

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Townsfolk claim that a missing relic belonging to them has turned up in a nearby location. The place is allegedly cursed.",
			"Rumors of some fancy lost relic being unearthed in nearby ruins has begun to circulate among the local inns.",
			"Tales of lost treasure have been drawing adventurers and thrill-seekers to these parts for years.",
			"A blessed local item which went missing years ago has reportedly been sighted in the wilds.",
			"A shepard claims to have found the burial site of a holy relic. Sounds like a load of hogwash, but you will be paid to investigate.",
			"Reports of a lost artifact supposedly discovered in an abandoned temple have piqued local interest.",
			"Whispers of a long-lost relic discovered in the nearby forest have the townsfolk buzzing with excitement.",
		];
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
