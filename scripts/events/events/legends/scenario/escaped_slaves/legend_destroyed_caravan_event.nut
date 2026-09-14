this.legend_destroyed_caravan_event <- this.inherit("scripts/events/event", {
	m = {
		Items = []
	},
	function create() {
		this.m.ID = "event.legend_destroyed_caravan";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "South",
			Text = "[img]gfx/ui/events/event_159.png[/img]A caravan stands unmoving on the horizon ahead. As you approach, the reason for its stillness becomes clear - the wagon is a wreck. The pack beast has been gored and the corpses of several caravan hands lie strewn about. Heads, arms, and legs are missing in uneven measure, some seemingly taken by sword swings, others ripped off by the mouth or claws of some creature. The nearby body of a hyena points to the canines as possible culprits, but looking at the wounds you can\'t help but feel something more deadly caused this.\n\nWhatever the case, you can hardly afford to waste this opportunity. You order the company to gather everything of use from the wagon and pack it up.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "We can use this.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.extend(::Legends.EventList.addItems([
					::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Southern.cloth_sash]
					]),
					::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Southern.cloth_sash]
					]),
					::Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Southern.gunner_hat]
					]),
					::new("scripts/items/weapons/oriental/nomad_mace"),
					::Const.World.Common.pickItem([
						[1, "misc/hyena_fur_item"],
						[1, "misc/acidic_saliva_item"]
					], "scripts/items/")
				], ::World.Assets.getStash()));
			}

		});
		this.m.Screens.push({
			ID = "Midland",
			Text = "[img]gfx/ui/events/event_56.png[/img]There are many dangers that await travelers on the road, but the caravan before you may well have encountered all of them at once. The pack beasts have been slaughtered, the wagons splintered into uselessness, and the guards\' corpses litter the mud. Behind one of the carts lies a dead direwolf, suggesting a pack of the beasts attacked, but that doesn\'t explain the level of destruction before you.\n\nYou tell the company to gather what they can and move on. Whatever happened here, you don\'t want to wait for it to come back and find you, too.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Let\'s hope we never meet what did this.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.extend(::Legends.EventList.addItems([
					::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.linen_tunic]
					]),
					::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.wizard_robe]
					]),
					::Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.wizard_hat]
					]),
					::new("scripts/items/weapons/bludgeon"),
					::Const.World.Common.pickItem([
						[1, "misc/werewolf_pelt_item"],
						[1, "misc/adrenaline_gland_item"]
					], "scripts/items/")
				], ::World.Assets.getStash()));
			}

		});
		this.m.Screens.push({
			ID = "North",
			Text = "[img]gfx/ui/events/event_113.png[/img]An unhold squats dead upon the path, a crude weapon\'s handle jutting out of its skull and half of a cart clenched in its fist. The other half of the cart lies shattered on the path, along with several bodies. You sift through the corpses and find that a couple belong to the northern barbarians. That explains who killed the unhold, but little else.\n\nNo sense trying to piece together a mystery only the dead can solve. You order the company to loot what they can and keep moving.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "The north is a dangerous place.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.extend(::Legends.EventList.addItems([
					::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.noble_tunic]
					]),
					::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Barbarian.hide_and_bone_armor]
					]),
					::Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.wizard_hat]
					]),
					::new("scripts/items/weapons/barbarians/axehammer"),
					::new("scripts/items/misc/frost_unhold_fur_item")
				], ::World.Assets.getStash()));
			}
		});
	}

	function onUpdateScore() {
		if (this.World.Assets.getOrigin().getID() != "scenario.legend_escaped_slaves") {
			return;
		}

		if (this.World.getTime().Days > 20) {
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();
		if (!currentTile.HasRoad) {
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach (t in towns) {
			local d = currentTile.getDistanceTo(t.getTile());

			if (d <= 2) {
				nearTown = true;
				break;
			}
		}

		if (nearTown) {
			return;
		}

		this.m.Score = 25;
	}

	function onDetermineStartScreen() {
		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.33)
			return "South";
		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.66)
			return "Midland";
		return "North";
	}

});

