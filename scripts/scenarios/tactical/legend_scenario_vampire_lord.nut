this.legend_scenario_vampire_lord <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioLineBattle::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		::Tactical.Entities.makeEnemiesKnownToAI();
		this.m.Music = ::Const.Music.UndeadTracks;
		::Tactical.getCamera().Level = 1;
		::Tactical.CameraDirector.addMoveToTileEvent(0, ::Tactical.getTile(15, 14 - 15 / 2), 1, null, null, 0, 100);
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.swamp");
		local minX = testMap.getMinX();
		local minY = testMap.getMinY();
		::Tactical.resizeScene(minX, minY);
		testMap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, null);
	}

	function initEntities()
	{
		local entity;
		local items;

		for( local x = 10; x < 20; x = ++x )
		{
			for( local y = 10; y < 20; y = ++y )
			{
				local tile = ::Tactical.getTile(x, y);
				tile.removeObject();
			}
		}

		// for (local i = 0; i < 8; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+2, i+2, 19, 19);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	//hair.setBrush("hair_black_" + ::Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 8; i < 16; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i - 6, i - 6, 17, 17);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	//hair.setBrush("hair_black_" + ::Const.Hair.AllFemale[15 + i])
		// }



		// for (local i = 0; i < 8; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+2, i+2, 15, 15);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllMale[11+i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	local body = entity.getSprite("body");
		// 	body.setBrush("bust_naked_body_00");
		// 	//hair.setBrush("hair_black_" + ::Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 8; i < 10; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i-6 i-6, 13, 13);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllMale[12+i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	local body = entity.getSprite("body");
		// 	body.setBrush("bust_naked_body_01");
		// 	//hair.setBrush("hair_black_" + ::Const.Hair.AllFemale[15 + i])
		//}
		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 19, 19);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[12])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_black_" + ::Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 17, 17);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[11])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_black_" + ::Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 17, 17);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[13])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_red_" + ::Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 15, 15);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[14])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_blonde_" + ::Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 13, 13);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[15])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_grey_" + ::Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 11, 11);
		// 	::World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(::Const.Faces.AllFemale[11])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_black_" + ::Const.Hair.AllFemale[15 + i])
		// }
		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/thick_tunic"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.sallet_green_helmet]]));
		items.equip(this.new("scripts/items/armor/lamellar_harness"));
		items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/named/blue_studded_mail_armor"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.wolf_helmet]]));
		items.equip(this.new("scripts/items/armor/named/black_leather_armor"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.norse_helmet]]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		items.equip(this.new("scripts/items/weapons/winged_mace"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17);
		::World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/coat_of_plates"));
		items.equip(this.new("scripts/items/weapons/legend_zweihander"));

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_vampire_lord", 19, 19, 12, 12);
		entity.setFaction(::Const.Faction.Undead);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_vampire_lord", 19, 19, 11, 11);
		entity.setFaction(::Const.Faction.Undead);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_vampire_lord", 19, 19, 13, 13);
		entity.setFaction(::Const.Faction.Undead);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 10, _maxX = 28, _minY = 3, _maxY = 28 )
	{
		local x = 0;
		local y = 0;
		local n = 0;

		while (1)
		{
			x = ::Math.rand(_minX, _maxX);
			y = ::Math.rand(_minY, _maxY) - x / 2;

			if (::Tactical.getTile(x, y).IsOccupiedByActor)
			{
				continue;
			}

			if (!::Tactical.getTile(x, y).IsEmpty)
			{
				::Tactical.getTile(x, y).removeObject();
			}

			if (::Tactical.getTile(x, y).IsEmpty)
			{
				break;
			}
		}

		return ::Tactical.spawnEntity(_script, x, y);
	}

	function initStash()
	{
		::Stash.clear();
		::Stash.resize(117);
		::Stash.setLocked(false);
		::Stash.add(this.new("scripts/items/weapons/dagger"));
		::Stash.add(this.new("scripts/items/weapons/scramasax"));
		::Stash.add(this.new("scripts/items/weapons/javelin"));
		::Stash.add(this.new("scripts/items/weapons/javelin"));
		::Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		::Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hatchet"));
		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
		::Stash.add(this.new("scripts/items/weapons/hand_axe"));
		::Stash.add(this.new("scripts/items/weapons/warhammer"));
		::Stash.add(this.new("scripts/items/weapons/warhammer"));
		::Stash.add(this.new("scripts/items/weapons/shortsword"));
		::Stash.add(this.new("scripts/items/weapons/shortsword"));
		::Stash.add(this.new("scripts/items/weapons/falchion"));
		::Stash.add(this.new("scripts/items/weapons/falchion"));
		::Stash.add(this.new("scripts/items/weapons/arming_sword"));
		::Stash.add(this.new("scripts/items/weapons/arming_sword"));
		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/legend_zweihander"));
		::Stash.add(this.new("scripts/items/weapons/greataxe"));
		::Stash.add(this.new("scripts/items/weapons/greataxe"));
		::Stash.add(this.new("scripts/items/weapons/greataxe"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/billhook"));
		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
		::Stash.add(this.new("scripts/items/weapons/militia_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/boar_spear"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/bludgeon"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/winged_mace"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/flail"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/weapons/short_bow"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/weapons/crossbow"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/wooden_shield"));
		::Stash.add(this.new("scripts/items/shields/kite_shield"));
		::Stash.add(this.new("scripts/items/shields/kite_shield"));
		::Stash.add(this.new("scripts/items/shields/kite_shield"));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_nasal_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.closed_mail_coif]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.reinforced_mail_coif]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_kettle_hat]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat_with_mail]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_helmet]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_with_mail]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		::Stash.add(::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		::Stash.add(this.new("scripts/items/legend_armor/cloth/legend_armor_quilted_aketon"));
		::Stash.add(this.new("scripts/items/armor/gambeson"));
		::Stash.add(this.new("scripts/items/armor/gambeson"));
		::Stash.add(this.new("scripts/items/armor/padded_leather"));
		::Stash.add(this.new("scripts/items/armor/padded_leather"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/armor/mail_shirt"));
		::Stash.add(this.new("scripts/items/armor/lamellar_harness"));
		::Stash.add(this.new("scripts/items/armor/coat_of_plates"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		::Stash.add(this.new("scripts/items/weapons/estoc"));
		::Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		::Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		::Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		::Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		::Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		::Stash.add(this.new("scripts/items/weapons/legend_hand_crossbow"));
		::Stash.add(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
	}

});

