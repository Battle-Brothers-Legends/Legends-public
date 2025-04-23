this.legend_scenario_vampire_lord <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioLineBattle::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		this.Tactical.Entities.makeEnemiesKnownToAI();
		this.m.Music = this.Const.Music.UndeadTracks;
		this.Tactical.getCamera().Level = 1;
		this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(15, 14 - 15 / 2), 1, null, null, 0, 100);
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.swamp");
		local minX = testMap.getMinX();
		local minY = testMap.getMinY();
		this.Tactical.resizeScene(minX, minY);
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
				local tile = this.Tactical.getTile(x, y);
				tile.removeObject();
			}
		}

		// for (local i = 0; i < 8; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+2, i+2, 19, 19);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	//hair.setBrush("hair_black_" + this.Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 8; i < 16; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i - 6, i - 6, 17, 17);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	//hair.setBrush("hair_black_" + this.Const.Hair.AllFemale[15 + i])
		// }



		// for (local i = 0; i < 8; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+2, i+2, 15, 15);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllMale[11+i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	local body = entity.getSprite("body");
		// 	body.setBrush("bust_naked_body_00");
		// 	//hair.setBrush("hair_black_" + this.Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 8; i < 10; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i-6 i-6, 13, 13);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllMale[12+i])
		// 	local hair = entity.getSprite("hair")
		// 	hair.Visible = false
		// 	local body = entity.getSprite("body");
		// 	body.setBrush("bust_naked_body_01");
		// 	//hair.setBrush("hair_black_" + this.Const.Hair.AllFemale[15 + i])
		//}
		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 19, 19);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[12])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_black_" + this.Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 17, 17);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[11])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_black_" + this.Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 17, 17);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[13])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_red_" + this.Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 15, 15);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[14])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_blonde_" + this.Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 13, 13);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[15])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_grey_" + this.Const.Hair.AllFemale[15 + i])
		// }

		// for (local i = 0; i < 5; i = ++i)
		// {
		// 	local entity = this.spawnEntity("scripts/entity/tactical/player", i+10, i+10, 11, 11);
		// 	this.World.getPlayerRoster().add(entity);
		// 	entity.setName(this.getRandomPlayerName());
		// 	entity.setScenarioValues();
		// 	local head = entity.getSprite("head")
		// 	head.setBrush(this.Const.Faces.AllFemale[11])
		// 	local hair = entity.getSprite("hair")
		// 	hair.setBrush("hair_black_" + this.Const.Hair.AllFemale[15 + i])
		// }
		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		items.equip(this.new("scripts/items/armor/padded_leather"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/weapons/billhook"));
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/thick_tunic"));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.sallet_green_helmet]]));
		items.equip(this.new("scripts/items/armor/lamellar_harness"));
		items.equip(this.new("scripts/items/weapons/greatsword"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.new("scripts/items/armor/named/blue_studded_mail_armor"));
		items.equip(this.new("scripts/items/weapons/hand_axe"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.wolf_helmet]]));
		items.equip(this.new("scripts/items/armor/named/black_leather_armor"));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.norse_helmet]]));
		items.equip(this.new("scripts/items/armor/padded_surcoat"));
		items.equip(this.new("scripts/items/weapons/winged_mace"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		entity = this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17);
		this.World.getPlayerRoster().add(entity);
		entity.setName(this.getRandomPlayerName());
		entity.setScenarioValues();
		items = entity.getItems();
		items.equip(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		items.equip(this.new("scripts/items/armor/coat_of_plates"));
		items.equip(this.new("scripts/items/weapons/greatsword"));

		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_vampire_lord", 19, 19, 12, 12);
		entity.setFaction(this.Const.Faction.Undead);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_vampire_lord", 19, 19, 11, 11);
		entity.setFaction(this.Const.Faction.Undead);
		entity.assignRandomEquipment();
		entity = this.spawnEntity("scripts/entity/tactical/enemies/legend_vampire_lord", 19, 19, 13, 13);
		entity.setFaction(this.Const.Faction.Undead);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 10, _maxX = 28, _minY = 3, _maxY = 28 )
	{
		local x = 0;
		local y = 0;
		local n = 0;

		while (1)
		{
			x = this.Math.rand(_minX, _maxX);
			y = this.Math.rand(_minY, _maxY) - x / 2;

			if (this.Tactical.getTile(x, y).IsOccupiedByActor)
			{
				continue;
			}

			if (!this.Tactical.getTile(x, y).IsEmpty)
			{
				this.Tactical.getTile(x, y).removeObject();
			}

			if (this.Tactical.getTile(x, y).IsEmpty)
			{
				break;
			}
		}

		return this.Tactical.spawnEntity(_script, x, y);
	}

	function initStash()
	{
		this.Stash.clear();
		this.Stash.resize(117);
		this.Stash.setLocked(false);
		this.Stash.add(this.new("scripts/items/weapons/dagger"));
		this.Stash.add(this.new("scripts/items/weapons/scramasax"));
		this.Stash.add(this.new("scripts/items/weapons/javelin"));
		this.Stash.add(this.new("scripts/items/weapons/javelin"));
		this.Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		this.Stash.add(this.new("scripts/items/weapons/throwing_axe"));
		this.Stash.add(this.new("scripts/items/weapons/hatchet"));
		this.Stash.add(this.new("scripts/items/weapons/hatchet"));
		this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
		this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
		this.Stash.add(this.new("scripts/items/weapons/warhammer"));
		this.Stash.add(this.new("scripts/items/weapons/warhammer"));
		this.Stash.add(this.new("scripts/items/weapons/shortsword"));
		this.Stash.add(this.new("scripts/items/weapons/shortsword"));
		this.Stash.add(this.new("scripts/items/weapons/falchion"));
		this.Stash.add(this.new("scripts/items/weapons/falchion"));
		this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
		this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
		this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greatsword"));
		this.Stash.add(this.new("scripts/items/weapons/greataxe"));
		this.Stash.add(this.new("scripts/items/weapons/greataxe"));
		this.Stash.add(this.new("scripts/items/weapons/greataxe"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/billhook"));
		this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
		this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
		this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
		this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/flail"));
		this.Stash.add(this.new("scripts/items/weapons/short_bow"));
		this.Stash.add(this.new("scripts/items/weapons/short_bow"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/weapons/crossbow"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
		this.Stash.add(this.new("scripts/items/shields/kite_shield"));
		this.Stash.add(this.new("scripts/items/shields/kite_shield"));
		this.Stash.add(this.new("scripts/items/shields/kite_shield"));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.aketon_cap]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_aketon_cap]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_nasal_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.closed_mail_coif]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.reinforced_mail_coif]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.padded_kettle_hat]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.kettle_hat_with_mail]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_helmet]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.flat_top_with_mail]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		this.Stash.add(this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]));
		this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
		this.Stash.add(this.new("scripts/items/armor/gambeson"));
		this.Stash.add(this.new("scripts/items/armor/gambeson"));
		this.Stash.add(this.new("scripts/items/armor/padded_leather"));
		this.Stash.add(this.new("scripts/items/armor/padded_leather"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
		this.Stash.add(this.new("scripts/items/armor/lamellar_harness"));
		this.Stash.add(this.new("scripts/items/armor/coat_of_plates"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.Stash.add(this.new("scripts/items/weapons/legend_estoc"));
		this.Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.Stash.add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.Stash.add(this.new("scripts/items/weapons/legend_hand_crossbow"));
		this.Stash.add(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
	}

});

