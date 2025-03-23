this.anatomists_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {}, 
	function create()
	{
		this.m.ID = "scenario.anatomists";
		this.m.Name = "Anatomists";
		this.m.Description = "[p=c][img]gfx/ui/events/event_181.png[/img][/p][p]Fueled by an unquenchable thirst for knowledge, the Anatomists have spent years dissecting the exotic and the alien. With social mores dogging their research, however, they\'ve turned to you to form a mercenary company and provide them a new source of fresh specimens.\n\n[color=#bcad8c]Anatomists:[/color] Start with three men and high funds.\n[color=#bcad8c]Researchers:[/color] Research the corpses of your fallen foes and gain knowledge to empower your men.\n[color=#bcad8c]Not Fighters:[/color] Your men will never be of Confident morale.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 70;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Paladins;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"anatomist_background"
		]);
		bros[0].getBackground().m.RawDescription = "{Captain? Is it alright if I call you captain? Ah, of course it is. What? No, we were not calling you by another name. Yers is a smooth costard, good sir, and we would not be of such derring-do to refer to you as a sellsword who is as ordinary as any of our coetaneous clodpolls, or state that we were in some sense importuning commerce by conducting business with a man of your particular skills. No sir, we would not. We are not children of perdition, sir.}";
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 1;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.RangedSkill] = 2;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_tunic");
		local plate = this.new("scripts/items/legend_armor/plate/undertakers_apron");
		armor.setUpgrade(plate);
		items.equip(armor);
		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_cloth_scarf");
		local top = this.new("scripts/items/legend_helmets/top/legend_helmet_undertakers_scarf");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_undertakers_hat");
		hood.setUpgrade(top);
		hood.setUpgrade(vanity);
		items.equip(hood);
	
		bros[1].setStartValuesEx([
			"anatomist_background"
		]);
		bros[1].getBackground().m.RawDescription = "{Despite others\' hesitancies, I\'ve no qualms calling you a javel, sir. You are, after all, a javel. A scapegrace. Some sellsword or another, yes? I think only a man who trucks cowardice would avoid calling you what you are. That someone disrespects your intelligence, thinking you yourself know not yourself. Even I see that in you accepting who you are, you are quite a good specimen. I mean, sellsword.}";
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Initiative] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		
		local armor = this.new("scripts/items/legend_armor/cloth/wanderers_coat");
		local cloak = this.new("scripts/items/legend_armor/cloak/legend_religious_scarf");
		armor.setUpgrade(cloak);
		items.equip(armor);
		
		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_beak_hood");
		local top = this.new("scripts/items/legend_helmets/top/legend_helmet_mask_beak");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_physicians_hood");
		hood.setUpgrade(top);
		hood.setUpgrade(vanity);
		items.equip(hood);
	
		
		
		items.equip(this.new("scripts/items/weapons/dagger"));
		bros[2].setStartValuesEx([
			"anatomist_background"
		]);
		bros[2].getBackground().m.RawDescription = "{Though our quotidian dialogues are no doubt drollery, beneath the banausic surface I must admit I feel a touch of serotinous savagery lurking within you, coming to the fore as if my words be fire. Even our most desultory talks has me on edge, the way you stare at me with such hateful eyes. Well, know this, bounty hunter, I am no casuist, I speak in earnest. You are too fine a specimen-I mean captain to be lofting some sapskull\'s brickbats at. Understand?}";
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[2].m.Talents = [];
		talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 3;
		talents[this.Const.Attributes.RangedDefense] = 3;
		items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));

		local armor = this.new("scripts/items/legend_armor/cloth/anatomist_robe");
		local cloak = this.new("scripts/items/legend_armor/cloak/anatomist_hood");
		armor.setUpgrade(cloak);
		items.equip(armor);
		
		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_full_mask");
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_kettle_hat");
		hood.setUpgrade(helm);
		items.equip(hood);	
		
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		
		
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_beasts_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_greenskins_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_undead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_legendary_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/apotheosis_potion_item"));
		this.World.Statistics.getFlags().set("isNecromancerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isWiedergangerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isFallenHeroPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGeistPotionAcquired", false);
		this.World.Statistics.getFlags().set("isRachegeistPotionAcquired", false);
		this.World.Statistics.getFlags().set("isSkeletonWarriorPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHonorGuardPotionAcquired", false);
		this.World.Statistics.getFlags().set("isAncientPriestPotionAcquired", false);
		this.World.Statistics.getFlags().set("isNecrosavantPotionAcquired", false);
		this.World.Statistics.getFlags().set("isLorekeeperPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcYoungPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcWarriorPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcBerserkerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcWarlordPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinGruntPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinOverseerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinShamanPotionAcquired", false);
		this.World.Statistics.getFlags().set("isDirewolfPotionAcquired", false);
		this.World.Statistics.getFlags().set("isLindwurmPotionAcquired", false);
		this.World.Statistics.getFlags().set("isUnholdPotionAcquired", false);
		this.World.Statistics.getFlags().set("isWebknechtPotionAcquired", false);
		this.World.Statistics.getFlags().set("isNachzehrerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isAlpPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHexePotionAcquired", false);
		this.World.Statistics.getFlags().set("isSchratPotionAcquired", false);
		this.World.Statistics.getFlags().set("isSerpentPotionAcquired", false);
		this.World.Statistics.getFlags().set("isKrakenPotionAcquired", false);
		this.World.Statistics.getFlags().set("isIjirokPotionAcquired", false);
		this.World.Statistics.getFlags().set("isIfritPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHyenaPotionAcquired", false);
		this.World.Assets.m.Money = this.World.Assets.m.Money + 700;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(20);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.anatomists_scenario_intro");
		}, null);
	}

	function onActorKilled( _actor, _killer, _combatID )
	{
		if (this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			return;
		}

		local isLegendary = _actor.getType() == this.Const.EntityType.ZombieBoss || _actor.getType() == this.Const.EntityType.SkeletonLich || _actor.getType() == this.Const.EntityType.Kraken || _actor.getType() == this.Const.EntityType.TricksterGod;

		if (!isLegendary && _killer != null && _killer.getFaction() != this.Const.Faction.Player && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			return;
		}

		switch(_actor.getType())
		{
		case this.Const.EntityType.Necromancer:
			this.World.Statistics.getFlags().set("shouldDropNecromancerPotion", true);
			break;

		case this.Const.EntityType.Zombie:
		case this.Const.EntityType.ZombieYeoman:
			this.World.Statistics.getFlags().set("shouldDropWiedergangerPotion", true);
			break;

		case this.Const.EntityType.ZombieKnight:
		case this.Const.EntityType.ZombieBetrayer:
			this.World.Statistics.getFlags().set("shouldDropFallenHeroPotion", true);
			break;

		case this.Const.EntityType.Ghost:
			this.World.Statistics.getFlags().set("shouldDropGeistPotion", true);
			break;

		case this.Const.EntityType.ZombieBoss:
			this.World.Statistics.getFlags().set("shouldDropRachegeistPotion", true);
			break;

		case this.Const.EntityType.SkeletonLight:
		case this.Const.EntityType.SkeletonMedium:
			this.World.Statistics.getFlags().set("shouldDropSkeletonWarriorPotion", true);
			break;

		case this.Const.EntityType.SkeletonHeavy:
			this.World.Statistics.getFlags().set("shouldDropHonorGuardPotion", true);
			break;

		case this.Const.EntityType.SkeletonPriest:
			this.World.Statistics.getFlags().set("shouldDropAncientPriestPotion", true);
			break;

		case this.Const.EntityType.Vampire:
			this.World.Statistics.getFlags().set("shouldDropNecrosavantPotion", true);
			break;

		case this.Const.EntityType.SkeletonLich:
			this.World.Statistics.getFlags().set("shouldDropLorekeeperPotion", true);
			break;

		case this.Const.EntityType.OrcYoung:
			this.World.Statistics.getFlags().set("shouldDropOrcYoungPotion", true);
			break;

		case this.Const.EntityType.OrcWarrior:
			this.World.Statistics.getFlags().set("shouldDropOrcWarriorPotion", true);
			break;

		case this.Const.EntityType.OrcBerserker:
			this.World.Statistics.getFlags().set("shouldDropOrcBerserkerPotion", true);
			break;

		case this.Const.EntityType.OrcWarlord:
			this.World.Statistics.getFlags().set("shouldDropOrcWarlordPotion", true);
			break;

		case this.Const.EntityType.GoblinAmbusher:
		case this.Const.EntityType.GoblinFighter:
		case this.Const.EntityType.GoblinWolfrider:
			this.World.Statistics.getFlags().set("shouldDropGoblinGruntPotion", true);
			break;

		case this.Const.EntityType.GoblinLeader:
			this.World.Statistics.getFlags().set("shouldDropGoblinOverseerPotion", true);
			break;

		case this.Const.EntityType.GoblinShaman:
			this.World.Statistics.getFlags().set("shouldDropGoblinShamanPotion", true);
			break;

		case this.Const.EntityType.Direwolf:
			this.World.Statistics.getFlags().set("shouldDropDirewolfPotion", true);
			break;

		case this.Const.EntityType.Lindwurm:
			this.World.Statistics.getFlags().set("shouldDropLindwurmPotion", true);
			break;

		case this.Const.EntityType.Unhold:
		case this.Const.EntityType.UnholdFrost:
		case this.Const.EntityType.UnholdBog:
		case this.Const.EntityType.BarbarianUnhold:
		case this.Const.EntityType.BarbarianUnholdFrost:
			this.World.Statistics.getFlags().set("shouldDropUnholdPotion", true);
			break;

		case this.Const.EntityType.Spider:
			this.World.Statistics.getFlags().set("shouldDropWebknechtPotion", true);
			break;

		case this.Const.EntityType.Ghoul:
			this.World.Statistics.getFlags().set("shouldDropNachzehrerPotion", true);
			break;

		case this.Const.EntityType.Alp:
			this.World.Statistics.getFlags().set("shouldDropAlpPotion", true);
			break;

		case this.Const.EntityType.Hexe:
			this.World.Statistics.getFlags().set("shouldDropHexePotion", true);
			break;

		case this.Const.EntityType.Schrat:
			this.World.Statistics.getFlags().set("shouldDropSchratPotion", true);
			break;

		case this.Const.EntityType.Kraken:
			this.World.Statistics.getFlags().set("shouldDropKrakenPotion", true);
			break;

		case this.Const.EntityType.TricksterGod:
			this.World.Statistics.getFlags().set("shouldDropIjirokPotion", true);
			break;

		case this.Const.EntityType.Serpent:
			this.World.Statistics.getFlags().set("shouldDropSerpentPotion", true);
			break;

		case this.Const.EntityType.SandGolem:
			this.World.Statistics.getFlags().set("shouldDropIfritPotion", true);
			break;

		case this.Const.EntityType.Hyena:
			this.World.Statistics.getFlags().set("shouldDropHyenaPotion", true);
			break;
		}
	}

	function onBattleWon( _combatLoot )
	{
		local buffs = [
			{
				acquiredFlagName = "isNecromancerPotionAcquired",
				discoveredFlagName = "isNecromancerPotionDiscovered",
				shouldDropFlagName = "shouldDropNecromancerPotion",
				itemName = "necromancer_potion_item"
			},
			{
				acquiredFlagName = "isWiedergangerPotionAcquired",
				discoveredFlagName = "isWiedergangerPotionDiscovered",
				shouldDropFlagName = "shouldDropWiedergangerPotion",
				itemName = "wiederganger_potion_item"
			},
			{
				acquiredFlagName = "isFallenHeroPotionAcquired",
				discoveredFlagName = "isFallenHeroPotionDiscovered",
				shouldDropFlagName = "shouldDropFallenHeroPotion",
				itemName = "fallen_hero_potion_item"
			},
			{
				acquiredFlagName = "isGeistPotionAcquired",
				discoveredFlagName = "isGeistPotionDiscovered",
				shouldDropFlagName = "shouldDropGeistPotion",
				itemName = "geist_potion_item"
			},
			{
				acquiredFlagName = "isRachegeistPotionAcquired",
				discoveredFlagName = "isRachegeistPotionDiscovered",
				shouldDropFlagName = "shouldDropRachegeistPotion",
				itemName = "rachegeist_potion_item"
			},
			{
				acquiredFlagName = "isSkeletonWarriorPotionAcquired",
				discoveredFlagName = "isSkeletonWarriorPotionDiscovered",
				shouldDropFlagName = "shouldDropSkeletonWarriorPotion",
				itemName = "skeleton_warrior_potion_item"
			},
			{
				acquiredFlagName = "isHonorGuardPotionAcquired",
				discoveredFlagName = "isHonorGuardPotionDiscovered",
				shouldDropFlagName = "shouldDropHonorGuardPotion",
				itemName = "honor_guard_potion_item"
			},
			{
				acquiredFlagName = "isAncientPriestPotionAcquired",
				discoveredFlagName = "isAncientPriestPotionDiscovered",
				shouldDropFlagName = "shouldDropAncientPriestPotion",
				itemName = "ancient_priest_potion_item"
			},
			{
				acquiredFlagName = "isNecrosavantPotionAcquired",
				discoveredFlagName = "isNecrosavantPotionDiscovered",
				shouldDropFlagName = "shouldDropNecrosavantPotion",
				itemName = "necrosavant_potion_item"
			},
			{
				acquiredFlagName = "isLorekeeperPotionAcquired",
				discoveredFlagName = "isLorekeeperPotionDiscovered",
				shouldDropFlagName = "shouldDropLorekeeperPotion",
				itemName = "lorekeeper_potion_item"
			},
			{
				acquiredFlagName = "isOrcYoungPotionAcquired",
				discoveredFlagName = "isOrcYoungPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcYoungPotion",
				itemName = "orc_young_potion_item"
			},
			{
				acquiredFlagName = "isOrcWarriorPotionAcquired",
				discoveredFlagName = "isOrcWarriorPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcWarriorPotion",
				itemName = "orc_warrior_potion_item"
			},
			{
				acquiredFlagName = "isOrcBerserkerPotionAcquired",
				discoveredFlagName = "isOrcBerserkerPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcBerserkerPotion",
				itemName = "orc_berserker_potion_item"
			},
			{
				acquiredFlagName = "isOrcWarlordPotionAcquired",
				discoveredFlagName = "isOrcWarlordPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcWarlordPotion",
				itemName = "orc_warlord_potion_item"
			},
			{
				acquiredFlagName = "isGoblinGruntPotionAcquired",
				discoveredFlagName = "isGoblinGruntPotionDiscovered",
				shouldDropFlagName = "shouldDropGoblinGruntPotion",
				itemName = "goblin_grunt_potion_item"
			},
			{
				acquiredFlagName = "isGoblinOverseerPotionAcquired",
				discoveredFlagName = "isGoblinOverseerPotionDiscovered",
				shouldDropFlagName = "shouldDropGoblinOverseerPotion",
				itemName = "goblin_overseer_potion_item"
			},
			{
				acquiredFlagName = "isGoblinShamanPotionAcquired",
				discoveredFlagName = "isGoblinShamanPotionDiscovered",
				shouldDropFlagName = "shouldDropGoblinShamanPotion",
				itemName = "goblin_shaman_potion_item"
			},
			{
				acquiredFlagName = "isDirewolfPotionAcquired",
				discoveredFlagName = "isDirewolfPotionDiscovered",
				shouldDropFlagName = "shouldDropDirewolfPotion",
				itemName = "direwolf_potion_item"
			},
			{
				acquiredFlagName = "isLindwurmPotionAcquired",
				discoveredFlagName = "isLindwurmPotionDiscovered",
				shouldDropFlagName = "shouldDropLindwurmPotion",
				itemName = "lindwurm_potion_item"
			},
			{
				acquiredFlagName = "isUnholdPotionAcquired",
				discoveredFlagName = "isUnholdPotionDiscovered",
				shouldDropFlagName = "shouldDropUnholdPotion",
				itemName = "unhold_potion_item"
			},
			{
				acquiredFlagName = "isWebknechtPotionAcquired",
				discoveredFlagName = "isWebknechtPotionDiscovered",
				shouldDropFlagName = "shouldDropWebknechtPotion",
				itemName = "webknecht_potion_item"
			},
			{
				acquiredFlagName = "isNachzehrerPotionAcquired",
				discoveredFlagName = "isNachzehrerPotionDiscovered",
				shouldDropFlagName = "shouldDropNachzehrerPotion",
				itemName = "nachzehrer_potion_item"
			},
			{
				acquiredFlagName = "isAlpPotionAcquired",
				discoveredFlagName = "isAlpPotionDiscovered",
				shouldDropFlagName = "shouldDropAlpPotion",
				itemName = "alp_potion_item"
			},
			{
				acquiredFlagName = "isHexePotionAcquired",
				discoveredFlagName = "isHexePotionDiscovered",
				shouldDropFlagName = "shouldDropHexePotion",
				itemName = "hexe_potion_item"
			},
			{
				acquiredFlagName = "isSchratPotionAcquired",
				discoveredFlagName = "isSchratPotionDiscovered",
				shouldDropFlagName = "shouldDropSchratPotion",
				itemName = "schrat_potion_item"
			},
			{
				acquiredFlagName = "isSerpentPotionAcquired",
				discoveredFlagName = "isSerpentPotionDiscovered",
				shouldDropFlagName = "shouldDropSerpentPotion",
				itemName = "serpent_potion_item"
			},
			{
				acquiredFlagName = "isKrakenPotionAcquired",
				discoveredFlagName = "isKrakenPotionDiscovered",
				shouldDropFlagName = "shouldDropKrakenPotion",
				itemName = "kraken_potion_item"
			},
			{
				acquiredFlagName = "isIjirokPotionAcquired",
				discoveredFlagName = "isIjirokPotionDiscovered",
				shouldDropFlagName = "shouldDropIjirokPotion",
				itemName = "ijirok_potion_item"
			},
			{
				acquiredFlagName = "isIfritPotionAcquired",
				discoveredFlagName = "isIfritPotionDiscovered",
				shouldDropFlagName = "shouldDropIfritPotion",
				itemName = "ifrit_potion_item"
			},
			{
				acquiredFlagName = "isHyenaPotionAcquired",
				discoveredFlagName = "isHyenaPotionDiscovered",
				shouldDropFlagName = "shouldDropHyenaPotion",
				itemName = "hyena_potion_item"
			}
		];

		foreach( buff in buffs )
		{
			if (!this.World.Statistics.getFlags().get(buff.acquiredFlagName) && this.World.Statistics.getFlags().get(buff.shouldDropFlagName))
			{
				this.World.Statistics.getFlags().set(buff.acquiredFlagName, true);
				this.World.Statistics.getFlags().set(buff.discoveredFlagName, true);
				_combatLoot.add(this.new("scripts/items/misc/anatomist/" + buff.itemName));
			}
		}
	}

	function onCombatFinished()
	{
		this.World.Statistics.getFlags().set("shouldDropNecromancerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropWiedergangerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropFallenHeroPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGeistPotion", false);
		this.World.Statistics.getFlags().set("shouldDropRachegeistPotion", false);
		this.World.Statistics.getFlags().set("shouldDropSkeletonWarriorPotion", false);
		this.World.Statistics.getFlags().set("shouldDropHonorGuardPotion", false);
		this.World.Statistics.getFlags().set("shouldDropAncientPriestPotion", false);
		this.World.Statistics.getFlags().set("shouldDropNecrosavantPotion", false);
		this.World.Statistics.getFlags().set("shouldDropLorekeeperPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcYoungPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcWarriorPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcBerserkerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcWarlordPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGoblinGruntPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGoblinOverseerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGoblinShamanPotion", false);
		this.World.Statistics.getFlags().set("shouldDropDirewolfPotion", false);
		this.World.Statistics.getFlags().set("shouldDropLindwurmPotion", false);
		this.World.Statistics.getFlags().set("shouldDropUnholdPotion", false);
		this.World.Statistics.getFlags().set("shouldDropWebknechtPotion", false);
		this.World.Statistics.getFlags().set("shouldDropNachzehrerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropAlpPotion", false);
		this.World.Statistics.getFlags().set("shouldDropHexePotion", false);
		this.World.Statistics.getFlags().set("shouldDropSchratPotion", false);
		this.World.Statistics.getFlags().set("shouldDropSerpentPotion", false);
		this.World.Statistics.getFlags().set("shouldDropKrakenPotion", false);
		this.World.Statistics.getFlags().set("shouldDropIjirokPotion", false);
		this.World.Statistics.getFlags().set("shouldDropIfritPotion", false);
		this.World.Statistics.getFlags().set("shouldDropHyenaPotion", false);
		return true;
	}

	function onGetBackgroundTooltip( _background, _tooltip )
	{
		_tooltip.push({
			id = 16,
			type = "text",
			icon = "ui/icons/morale.png",
			text = "Will never be of confident morale"
		});
	}

});

