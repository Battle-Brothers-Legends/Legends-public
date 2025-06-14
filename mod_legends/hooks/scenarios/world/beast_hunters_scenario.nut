::mods_hookExactClass("scenarios/world/beast_hunters_scenario", function (o) {
	o.m.FavouredEnemyPerks <- [
		::Legends.Perk.LegendFavouredEnemyGhoul,
		::Legends.Perk.LegendFavouredEnemyHexen,
		::Legends.Perk.LegendFavouredEnemyAlps,
		::Legends.Perk.LegendFavouredEnemyUnhold,
		::Legends.Perk.LegendFavouredEnemyLindwurm,
		::Legends.Perk.LegendFavouredEnemyDirewolf,
		::Legends.Perk.LegendFavouredEnemySpider,
		::Legends.Perk.LegendFavouredEnemySchrat,
	];

	o.create <- function ()
	{
		this.m.ID = "scenario.beast_hunters";
		this.m.Name = "Beast Slayers";
		this.m.Description = "[p=c][img]gfx/ui/events/event_122.png[/img][/p][p]You and your kind make your living by hunting down the many beasts that beset villages on the fringes of civilization. It is dangerous work, but it pays well enough and there is always a bigger beast to slay and more crowns to earn.\n\n[color=#bcad8c]Beast Slayers:[/color] Start with three Beast Slayers and decent equipment, as well as some beast trophies. Beast Slayers gain a unique trait when fighting beasts. Chance to find others that support your cause.\n[color=#bcad8c]Expert Skulkers:[/color] See tracks from further away. Recruits gain a random Favoured Beast Enemy perk.\n[color=#bcad8c]Expert Skinners:[/color] Each beast you slay has a 50% chance to drop an additional trophy.\n[color=#bcad8c]Prejudice:[/color] Most people do not trust your kind, get 20% worse prices.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 40;
		this.m.IsFixedLook = true;
		this.m.StartingBusinessReputation = 100;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i++ )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.improveMood(1.0, "Has slain a dangerous witch");
			bro.worsenMood(2.5, "Lost most of the company in a betrayal");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();


		bros[0].setStartValuesEx([
			"legend_guildmaster_background"
		]);
		bros[0].getBackground().m.RawDescription = "%name% saved you in the brigand\'s ambush that destroyed your band of slayers. The Guildmaster does not hang this fact over you, for you have saved %name% many a times yourself. This slayer of beasts suffers no emotion that does not bid well in this world, and that alone makes for a sound mercenary.";
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].addLightInjury();
		::Legends.Traits.grant(bros[0], ::Legends.Trait.LegendBeastslayers);
		::Legends.Traits.grant(bros[0], ::Legends.Trait.HateBeasts);
 		bros[0].getSprite("miniboss").setBrush("bust_miniboss");
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Initiative] = 2;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/legend_redback_dagger"));
		items.equip(this.new("scripts/items/tools/throwing_net"));


		bros[1].setStartValuesEx([
			"beast_hunter_background"
		]);
		bros[1].getBackground().m.RawDescription = "A young whelp from the city, %name% got a start in beast slaying by rooting out the warrens of \'vicious rabbits\', as one puts it. You are not sure how true that is, but regardless %name% has demonstrated greats feats of arms on the battlefield more times than you can count.";
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[1].addLightInjury();
		::Legends.Traits.grant(bros[1], ::Legends.Trait.LegendBeastslayers);
		::Legends.Traits.grant(bros[1], ::Legends.Trait.HateBeasts);
 		bros[1].getSprite("socket").setBrush("bust_base_beasthunters"); //custom base
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/woodcutters_axe"));


		bros[2].setStartValuesEx([
			"beast_hunter_background"
		]);
		bros[2].getBackground().m.RawDescription = "Grizzled vets are a rarity in beast slaying, and %name% sure ain\'t one. Instead, the \'slayer\' started the foray into monster hunting by reading books instead of training the sword. Still a good enough warrior at heart, it is the study and preparation that gives %name% the edge in battle.";
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[2].addInjury(this.Const.Injury.Brawl);
		::Legends.Traits.grant(bros[2], ::Legends.Trait.LegendBeastslayers);
		::Legends.Traits.grant(bros[2], ::Legends.Trait.HateBeasts);
 		bros[2].getSprite("socket").setBrush("bust_base_beasthunters"); //custom base
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		talents[this.Const.Attributes.Fatigue] = 1;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
		items.equip(this.new("scripts/items/accessory/falcon_item"));

		foreach( bro in bros )
		{
			bro.m.PerkPoints = 1;
			bro.m.LevelUps = 1;
			bro.m.Level = 2;
		}

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Flags.set("HasLegendCampCrafting", true);
		this.World.Flags.set("HasLegendCampHunting", true);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/witch_hair_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/spider_silk_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"));
		this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
		this.World.Assets.getStash().add(this.new("scripts/items/accessory/night_vision_elixir_item"));
		this.World.Assets.m.Money = this.Math.round(this.World.Assets.m.Money * 0.75);
	}

	o.onGenerateBro <- function (bro)
	{
		local r;
		r = this.Math.rand(0,5);
		if (bro.getBackground().getID() == "background.beast_slayer")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.8);
			bro.getBaseProperties().DailyWageMult *= 0.8;
			bro.getSprite("socket").setBrush("bust_base_beasthunters");
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendBeastslayers);
			bro.improveMood(1.5, "Hates beasts as much as you do");
		}
		else if (bro.getBackground().getID() == "background.legend_guildmaster")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
			bro.getBaseProperties().DailyWageMult *= 1.0;
			bro.getSprite("miniboss").setBrush("bust_miniboss");
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendBeastslayers);
			bro.improveMood(1.5, "Excited to teach the new blood");
		}
		else if (bro.getBackground().getID() == "background.legend_vala" || bro.getBackground().getID() == "background.legend_druid")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
			bro.getBaseProperties().DailyWageMult *= 0.0;
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendBeastslayers);
			bro.improveMood(1.5, "Feels at one with nature");
		}
		else if (r == 0 || bro.getSkills().hasTrait(::Legends.Trait.HateBeasts))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9);
			bro.getBaseProperties().DailyWageMult *= 0.9;
			::Legends.Traits.grant(bro, ::Legends.Trait.HateBeasts);
			bro.improveMood(1.5, "Hates beasts as much as you do");
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25);
			bro.getBaseProperties().DailyWageMult *= 1.25;
			bro.worsenMood(2.0, "Has heard worrying things about your kind...");
		}

		bro.getBackground().m.PerkTreeDynamicMins.EnemyChance += 0.04;
		bro.getBackground().m.PerkTreeDynamicMins.ClassChance += 0.01;
		bro.getBackground().m.PerkTreeDynamicMins.MagicChance += 0.001;
		bro.getSkills().update();
	}

	o.onInit <- function ()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.BuyPriceMult = 1.2;
		this.World.Assets.m.SellPriceMult = 0.8;
		this.World.Assets.m.ExtraLootChance = 50;
		this.World.Assets.m.FootprintVision = 1.5;
	}

	o.onUpdateHiringRoster <- function ( _roster )
	{
		this.addBroToRoster(_roster, "beast_hunter_background", 7);
		this.addBroToRoster(_roster, "legend_guildmaster_background", 10);
	}

	o.onBuildPerkTree <- function ( _background )
	{
		local perk = ::MSU.Array.rand(this.m.FavouredEnemyPerks);
		this.addScenarioPerk(_background, perk);
	}
});

