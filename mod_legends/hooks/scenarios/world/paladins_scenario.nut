::mods_hookExactClass("scenarios/world/paladins_scenario", function (o) {
	o.create = function () {
		this.m.ID = "scenario.paladins";
		this.m.Name = "Oathtakers";
		this.m.Description = "[p=c][img]gfx/ui/events/event_180.png[/img][/p][p]Oathtakers are knightly warriors beholden not to liege lords, but to the ideals and teachings of their founder, Young Anselm. The order now finds itself in dire straits, and they\'ve turned to you to reverse their fortunes. Can you teach these zealots to become successful mercenaries?\n\n[color=#bcad8c]Paladins:[/color] Start with two battle-hardened warriors and good equipment.\n[color=#bcad8c]Oathtakers:[/color] Sworn to Young Anselm\'s teachings, you must take oaths that confer various advantages and disadvantages until fulfilled.[/p]";
		this.m.Difficulty = 2;
		this.m.IsFixedLook = true;
		this.starting_scenario.create();
	}

	o.onSpawnAssets = function () {
		local roster = ::World.getPlayerRoster();

		for (local i = 0; i < 2; i = ++i) {
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = ::Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([::Legends.Background.PaladinOld]);
		bros[0].getBackground().m.RawDescription = "{Perhaps of an age more suitable for caretaking than oathtaking, %name% is a rather old, nigh on decrepit Oathtaker. While age has robbed him of his more natural talents, it has at least gifted him with learning and experience that no physical capabilities can match. He is a man of many spirits, having gone around this world in the shell of soldier, farmer, sellsword, and more. Now he is an Oathtaker, and all those skills and traits he built up over the years has made him quite a formidable one at that. | When First Oathtaker Anselm first met %name%, it is said that the prime paladin divulged details no one else could have possibly known, thus proving the aethereal power behind his beliefs. %name% is an ardent believer in the Oaths, and in seeing Young Anselm\'s vision through.}";
		bros[0].setPlaceInFormation(4);
		bros[0].setVeteranPerks(2);
		bros[0].m.PerkPoints = 2;
		bros[0].m.LevelUps = 2;
		bros[0].m.Level = 3;
		::Legends.Traits.grant(bros[0], ::Legends.Trait.Old);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Bravery] = 3;
		talents[::Const.Attributes.MeleeSkill] = 1;
		talents[::Const.Attributes.RangedDefense] = 2;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Offhand));

		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_mail_coif");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_plait");
		hood.setUpgrade(vanity);
		items.equip(hood);
		local armor = this.new("scripts/items/legend_armor/cloth/legend_armor_knightly_robe");
		local chain = this.new("scripts/items/legend_armor/chain/legend_armor_mail_shirt");
		local plate = this.new("scripts/items/legend_armor/plate/legend_armor_southern_padded");
		local attach = this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_spiked_collar_upgrade");
		armor.setUpgrade(chain);
		armor.setUpgrade(plate);
		armor.setUpgrade(attach);
		items.equip(armor);

		items.equip(this.new("scripts/items/accessory/oathtaker_skull_01_item"));
		local banner = this.new("scripts/items/tools/player_banner");
		banner.setVariant(::World.Assets.getBannerID());
		items.equip(banner);
		bros[1].setStartValuesEx([::Legends.Background.Paladin]);
		bros[1].getBackground().m.RawDescription = "{%name%, like many of the Oathtakers\' more spry members, strives to be like Young Anselm. A youthful, capable man who has yet to let the world\'s horrors and grind wear him down. In moments of honesty, he reminds you of yourself. In moments of reflection, you realize that he will likely one day resemble you as you are now. But until then, to the youth of the world, for the Oaths are certainly not wasted upon them! | When Anselm set out on his quest, it was %name% whom joined him first. Despite the Young Anselm\'s untimely death, %name% still sought to see the young man\'s vision through. He is an ardent believer in the Oaths and can be frequently found idolizing and commemorating Young Anselm\'s skull.}";
		bros[1].setPlaceInFormation(5);
		bros[1].setVeteranPerks(2);
		bros[1].m.PerkPoints = 0;
		bros[1].m.LevelUps = 0;
		bros[1].m.Level = 1;
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Initiative] = 3;
		talents[::Const.Attributes.MeleeSkill] = 2;
		talents[::Const.Attributes.MeleeDefense] = 1;
		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Offhand));

		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_padded_cap");
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_flat_top_helm");
		local top = this.new("scripts/items/legend_helmets/top/legend_helmet_faceplate_flat");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_chaperon");
		hood.setUpgrade(helm);
		hood.setUpgrade(top);
		hood.setUpgrade(vanity);
		items.equip(hood);

		local armor = this.new("scripts/items/legend_armor/cloth/legend_armor_gambeson");
		armor.setVariant(::Math.rand(1, 3));
		local chain = this.new("scripts/items/legend_armor/chain/legend_armor_hauberk");
		local plate = this.new("scripts/items/legend_armor/plate/legend_armor_leather_riveted");
		local cloak = this.new("scripts/items/legend_armor/cloak/legend_armor_relic_hood");
		local attach = this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_sacred_shield_upgrade");
		armor.setUpgrade(chain);
		armor.setUpgrade(plate);
		armor.setUpgrade(cloak);
		armor.setUpgrade(attach);
		items.equip(armor);

		items.equip(this.new("scripts/items/weapons/arming_sword"));
		local shield = this.new("scripts/items/shields/heater_shield");
		shield.onPaintInCompanyColors();
		items.equip(shield);
		::World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		::World.Assets.addMoralReputation(10.0);

		if (!::Const.DLC.Desert) {
			::World.Assets.getStash().resize(::World.Assets.getStash().getCapacity() + 27);
		}

		::World.Assets.m.Money = ::World.Assets.m.Money - 1000;
		::World.Assets.m.ArmorParts = ::World.Assets.m.ArmorParts / 2;
		::World.Assets.m.Medicine = ::World.Assets.m.Medicine / 2;
		::World.Assets.m.Ammo = ::World.Assets.m.Ammo / 2;
	}

	o.onSpawnPlayer = function () {
		local randomVillage;

		for (local i = 0; i < ::World.EntityManager.getSettlements().len(); i++) {
			randomVillage = ::World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern()) {
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = ::World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;

		do {
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 4), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 4), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!::World.isValidTileSquare(x, y)) {
			} else {
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore || tile.IsOccupied) {
				} else if (tile.getDistanceTo(randomVillageTile) <= 1) {
				} else {
					local path = ::World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty()) {
						randomVillageTile = tile;
						break;
					}
				}
			}
		} while (1);

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook(19);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function (_tag) {
			::Music.setTrackList(::Const.Music.IntroTracks, ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.paladins_scenario_intro");
		}, null);
	}

	o.onInit = function () {
		::World.Assets.m.BrothersMax = 18;
	}

	o.onHired = function (_bro) {
		if (::World.Ambitions.hasActiveAmbition()) {
			switch (::World.Ambitions.getActiveAmbition().getID()) {
				case "ambition.oath_of_humility":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfHumility);
					break;

				case "ambition.oath_of_valor":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfValor);
					break;

				case "ambition.oath_of_endurance":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfEndurance);
					break;

				case "ambition.oath_of_vengeance":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfVengeance);
					break;

				case "ambition.oath_of_righteousness":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfRighteousness);
					break;

				case "ambition.oath_of_dominion":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfDominion);
					break;

				case "ambition.oath_of_wrath":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfWrath);
					break;

				case "ambition.oath_of_honor":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfHonor);
					::Legends.Effects.grant(_bro, ::Legends.Effect.OathOfHonorWarning);
					break;

				case "ambition.oath_of_camaraderie":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfCamaderie);
					break;

				case "ambition.oath_of_sacrifice":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfSacrifice);
					break;

				case "ambition.oath_of_fortification":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfFortification);
					::Legends.Effects.grant(_bro, ::Legends.Effect.OathOfFortificationWarning);
					break;

				case "ambition.oath_of_distinction":
					::Legends.Traits.grant(_bro, ::Legends.Trait.OathOfDistinction);
					_bro.getFlags().set("OathtakersDistinctionLevelUps", 0);
					break;
			}
		}
	}

	o.onUpdateLevel = function (_bro) {
		if (!::World.Ambitions.hasActiveAmbition()) {
			return;
		}

		if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_distinction") {
			_bro.getFlags().increment("OathtakersDistinctionLevelUps");
		}
	}

	o.onActorKilled = function (_actor, _killer, _combatID) {
		if (!::World.Ambitions.hasActiveAmbition()) {
			return;
		}

		if (_killer == null || _killer.getFaction() != ::Const.Faction.Player && _killer.getFaction() != ::Const.Faction.PlayerAnimals) {
			if (_actor.isPlayerControlled() && ::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_fortification") {
				::World.Statistics.getFlags().increment("OathtakersBrosDead");
			}

			return;
		}

		if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_honor") {
			if (_actor.getTile().getZoneOfControlCountOtherThan(_actor.getAlliedFactions()) <= 1) {
				::World.Statistics.getFlags().increment("OathtakersSoloKills");
			}

			return;
		}

		local actorFaction = ::Const.EntityType.getDefaultFaction(_actor.getType());

		if (actorFaction == ::Const.FactionType.Zombies || actorFaction == ::Const.FactionType.Undead) {
			if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_righteousness") {
				::World.Statistics.getFlags().increment("OathtakersUndeadSlain");
			}
		} else if (actorFaction == ::Const.FactionType.Goblins || actorFaction == ::Const.FactionType.Orcs) {
			if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_vengeance") {
				::World.Statistics.getFlags().increment("OathtakersGreenskinsSlain");
			}
		} else if (actorFaction == ::Const.FactionType.Beasts || _actor.getType() == ::Const.EntityType.BarbarianUnhold || _actor.getType() == ::Const.EntityType.BarbarianUnholdFrost) {
			if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_dominion") {
				::World.Statistics.getFlags().increment("OathtakersBeastsSlain");
			}
		}

		if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_wrath") {
			::World.Statistics.getFlags().increment("OathtakersWrathSlain");
		}
	}

	o.onBattleWon = function (_combatLoot) {
		if (!::World.Ambitions.hasActiveAmbition()) {
			return;
		}

		if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_valor" && ::World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") > ::World.Statistics.getFlags().getAsInt("LastPlayersAtBattleStartCount")) {
			::World.Statistics.getFlags().increment("OathtakersDefeatedOutnumbering");
		}

		if (::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_endurance" && ::World.Statistics.getFlags().getAsInt("LastCombatResult") == 1) {
			::World.Statistics.getFlags().increment("OathtakersBattlesWon");
		}
	}

	o.onContractFinished = function (_contractType, _cancelled) {
		if (!::World.Ambitions.hasActiveAmbition()) {
			return;
		}

		if (_contractType == "contract.arena" || _contractType == "contract.arena_tournament") {
			return;
		}

		if (!_cancelled && ::World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_humility") {
			::World.Statistics.getFlags().increment("OathtakersContractsComplete");
		}
	}

});
