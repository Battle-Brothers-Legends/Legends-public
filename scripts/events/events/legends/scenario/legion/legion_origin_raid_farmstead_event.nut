this.legion_origin_raid_farmstead_event <- this.inherit("scripts/events/event", {
	m = {
		Legionary1 = null,
		Legionary2 = null
	},
	function create() {
		this.m.ID = "event.legion_origin_raid_farmstead";
		this.m.Title = "At a farmstead...";
		this.m.Cooldown = 35.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			//— \n
			ID = "A",
			Text = "[img]gfx/ui/events/event_72.png[/img]%randombrother% comes to you with a report, not far from here is a farmstead, lightly guarded, if indeed at all. While you have no use for food, it makes a fair target to exploit. \n\nBased on the report, reinforcements could be expected, but unlikely.",
			Image = "",
			List = [],
			Options = [{
				Text = "We raid it.",
				getResult = @(_event) "B"
			}, {
				Text = "We move on.",
				getResult = @(_event) 0
			}],
			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_72.png[/img]Marching in a column towards the farm, you make yourself known. Hay bailers drop their pitchforks and run. Threshers abandon their flails in the fields. A distant woman holds a basket, watching with macabre interest. \nThe heavy clatter of armour evokes a distant memory, which quickly dissolves upon seeing the rest of the farm. \nThe farm is in a poorer state than initially thought — something has been through here not long ago, torching the barn and killing some cattle. A sheephound lies decaying on the road. With this known, the legion waits for your next order.",
			Image = "",
			List = [],
			Options = [{
				Text = "Take what you can carry. Ignore the survivors", //low loot no conflict
				getResult = @(_event) "C"
			}, {
				Text = "Take everything.", //medium loot possible conflict
				getResult = @(_event) "D"
			}, {
				Text = "Take everything. Kill everyone.", //best xp low loot certain conflict
				getResult = @(_event) "E"
			}],
			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_73.png[/img]Your legionaries disperse, with the usual suspects pairing up or forming small groups. Some go it alone — but all fan out in each degree of interest. \n\nYour fighter\'s visage alone is enough to flush the peasants from their buildings, causing them to use windows to escape being trapped within. Despite the initial chaos, the raid is organised and for the most part, clean. A small group tries to make a stand near a grain silo, but their resolve quickly breaks when %legionary1% inflicts a grazing wound on their ringleader. \nAfter just an hour, the farmstead has been mostly picked clean, save for the items too heavy to carry. Very little blood was spilt.",
			Image = "",
			List = [],
			Options = [{
				Text = "Quick and clean.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				::World.Assets.getStash().add(::new("scripts/items/supplies/legend_medicine_small_item"));
				::World.Assets.getStash().add(::new("scripts/items/supplies/legend_armor_parts_small_item"));
				::World.Assets.getStash().add(::new("scripts/items/supplies/legend_ammo_small_item"));

				this.List.push(::Legends.EventList.changeMoney(::Math.rand(4, 308)));
				this.List.extend(::Legends.EventList.addItems([
					::new("scripts/items/supplies/smoked_ham_item"),
					::new("scripts/items/supplies/bread_item")
				], ::World.Assets.getStash()));
				::World.Assets.updateFood();

				local xp = ::Math.rand(40, 345); //gain this xp
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					this.List.push(::Legends.EventList.changeBroExperience(bro, xp));
				}
			}
		});
		this.m.Screens.push({
			//— \n
			ID = "D",
			Text = "[img]gfx/ui/events/event_94.png[/img]Your legion moves from you with practiced pacing. Each one makes a beeline for a structure, cutting down the odd farmhand here and there as they go. \nBeing the professional soliders they are, your legionaries prioritise any peasant putting up a fight holding a flail or club first, before rotating to the less dangerous targets thereafter. \n\nAfter a short amount of further resistance, the rest of the workers flee into the fields. Your fighters take no care in taking what they can — including ripping apart furniture for materials. After some while longer, the farm is stripped bare and desolate save for the uncaring cattle in a nearby pen.",
			Image = "",
			List = [],
			Options = [{
				Text = "A successful raid.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				//supplies
				::World.Assets.getStash().add(::new("scripts/items/supplies/legend_medicine_small_item"));
				::World.Assets.getStash().add(::new("scripts/items/supplies/legend_armor_parts_small_item"));
				::World.Assets.getStash().add(::new("scripts/items/supplies/legend_ammo_small_item"));
				::World.Assets.getStash().add(::new("scripts/items/supplies/armor_parts_item"));
				::World.Assets.getStash().add(::new("scripts/items/supplies/medicine_item"));

				this.List.push(::Legends.EventList.changeMoney(::Math.rand(88, 501)));
				this.List.extend(::Legends.EventList.addItems([
					::new("scripts/items/supplies/smoked_ham_item"),
					::new("scripts/items/supplies/bread_item"),
					::new("scripts/items/trade/quality_wood_item"),
					::new("scripts/items/trade/cloth_rolls_item"),
				], ::World.Assets.getStash()));
				::World.Assets.updateFood();

				local xp = ::Math.rand(120, 520); //gain this xp
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					this.List.push(::Legends.EventList.changeBroExperience(bro, xp));
				}
			}
		});
		this.m.Screens.push({
			//— \n
			ID = "E",
			Text = "[img]gfx/ui/events/event_30.png[/img]Your legion disperses with an un-natural vigor. You haven\'t seen them this riled up in decades. %legionary1% spares no hesitation in setting the field on fire, while the rest of the legion, mostly immune to the flames, corral the workers into killzones where they are quickly felled. \n\nCorpses begin to form small piles — either deliberatly dragged into open areas for what comes next, or from what was a final stand of a brave man leading the desperate. The bodies of the previous raid catch fire, letting out an acrid black pall into the air, forcing some militia to drop their weapons in favour of covering their faces. \nHours pass, and the entire farmstead is now razed to the foundations. Charred remains sweep the crossroads, what remains of the barn and the fields. Little was looted that couldn't resist the flames. %legionary2% summons you over, and opens a hatch leading to a cellar within the barn. At the bottom of the steps lies a man smoked alive — his skin peeling, jellied and soft off the bone. Within the cellar lies a small forge, a now ruined suit of armour and an anvil. The tools on the anvil catch your attention, daubed with strange markings, which you take by insitinct. \n\n%legionary1% summons you back upstairs, only for you to see a throng of eager and recently paid merecenaries drawing a net around you...",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To arms!",
					function getResult(_event) {
						local properties = ::World.State.getLocalCombatProperties(::World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = ::Const.Music.NobleTracks;
						properties.IsAutoAssigningBases = false;
						properties.PlayerDeploymentType = ::Const.Tactical.DeploymentType.Center;
						properties.EnemyDeploymentType = ::Const.Tactical.DeploymentType.Circle; //we have you surrounded, at least from this side
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, ::Const.World.Spawn.Mercenaries, ::Math.rand(120, 195) * _event.getReputationToDifficultyLightMult(), ::Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start(_event) {
				::World.Assets.getStash().add(this.new("scripts/items/supplies/armor_parts_item"));
				::World.Assets.getStash().add(this.new("scripts/items/supplies/armor_parts_item"));

				this.List.push(::Legends.EventList.changeMoney(::Math.rand(302, 906)));
				this.List.extend(::Legends.EventList.addItems([
					::new("scripts/items/misc/legend_masterwork_tools")
				], ::World.Assets.getStash()));

				local xp = ::Math.rand(352, 967); //gain this xp
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					this.List.push(::Legends.EventList.changeBroExperience(bro, xp));
				}
			}
		});
	}

	function onUpdateScore() {
		if (!::World.getTime().IsDaytime) {
			return;
		}

		local currentTile = ::World.State.getPlayer().getTile();

		if(!::Legends.S.oneOf(currentTile.Type, ::Const.World.TerrainType.Plains, ::Const.World.TerrainType.Farmland) || !currentTile.HasRoad) {
			return;
		}

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 8) {
			return;
		}

		local candidates = brothers.filter(@(_, _bro) (_bro.getFlags().has("PlayerSkeleton")));

		if (candidates.len() < 2) {
			return;
		}

		this.m.Legionary1 = candidates[::Math.rand(0, candidates.len() - 1)];
		local candidates2 = candidates.filter(@(_, _bro) (_bro.getID() != this.m.Legionary1.getID()));
		this.m.Legionary2 = candidates2[::Math.rand(0, candidates2.len() - 1)];
		this.m.Score = 30;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"legionary1",
			this.m.Legionary1.getName()
		]);
		_vars.push([
			"legionary2",
			this.m.Legionary2.getName()
		]);
	}

	function onDetermineStartScreen() {
		return "A";
	}

	function onClear() {
		this.m.Legionary1 = null;
		this.m.Legionary2 = null;
	}
});
