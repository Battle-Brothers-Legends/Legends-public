::mods_hookExactClass("events/events/come_across_ritual_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Arrival") {
				s.Text = "[img]gfx/ui/events/event_140.png[/img]The footsteps meander through what seems to an an ancient path, long downtrodden and broken by the the frequent use of this trail. In the distance a chant becomes steadily louder and bolder. You tell the company to rest while you sneak forward, eventually finding a large bonfire.\n\n Around the fire cloaked figures circle this way and that, as if they knew of your intrusion and had set their sights on searching for you. %randombrother% crawls up beside you and shakes their head.%SPEECH_ON%Just what is going on down there? What should we do?%SPEECH_OFF%";
			}
			if (s.ID == "Observe1") {
				s.Text = "[img]gfx/ui/events/event_140.png[/img]You decide to wait it out and see what happens. Just as you say that, the cultists drag an old man before the fire. He bows his head before the flames, opens his arms, and then falls in.\n\n There are no screams.\n\n Another man is pulled forward. He whispers words to a cultist, they both nod, and so too this man puts himself to the flame. A third is pushed forth, but unlike the others he is shackled and wild-eyed. He screams at the captors.%SPEECH_ON%Fark your god, he means nothing! It\'s all a lie!%SPEECH_OFF%A face appears in the flames, its shape bulbous and churning in the smoke and fire. It is cruelty embodied, and could be no better painted by flames than by darkness itself. It turns and grins. One of the cultist shouts.%SPEECH_ON%Davkul awaits you!%SPEECH_OFF%But the prisoner kicks one of his imprisoners and tries to make a run for it.";
			}
			if (s.ID == "Observe2") {
				s.Options[0].getResult <- function ( _event )
				{
					local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					properties.CombatID = "Event";
					properties.Music = this.Const.Music.CivilianTracks;
					properties.IsAutoAssigningBases = false;
					properties.Entities = [];

					for( local i = 0; i < 20; i = ++i ) {
						local unit = clone this.Const.World.Spawn.Troops.Cultist;
						unit.Faction <- this.Const.Faction.Enemy;
						properties.Entities.push(unit);
					}

					properties.Loot = [
						this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Legendary.mask_of_davkul]])
					];
					this.World.State.startScriptedCombat(properties, false, false, true);
					return 0;
				}
			}
			if (s.ID == "Cultist") {
				s.start <- function (_event) {
					this.Characters.push(_event.m.Cultist.getImagePath());
					::World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
					::World.Assets.getStash().makeEmptySlots(1);
					local item = ::new("scripts/items/legend_helmets/helm/legend_helmet_skin_helm");
					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
			if (s.ID == "Attack1") {
				s.Options[0].getResult <- function ( _event )
				{
					local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					properties.CombatID = "Event";
					properties.Music = this.Const.Music.CivilianTracks;
					properties.IsAutoAssigningBases = false;
					properties.Entities = [];

					for( local i = 0; i < 20; i = ++i )
					{
						local unit = clone this.Const.World.Spawn.Troops.Cultist;
						unit.Faction <- this.Const.Faction.Enemy;
						properties.Entities.push(unit);
					}

					this.World.State.startScriptedCombat(properties, false, false, true);
					return 0;
				}
				s.start <-	function ( _event ) {
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}

			if (s.ID == "Attack2") {
				s.Options[0].getResult <- function ( _event )
				{
					local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					properties.CombatID = "Event";
					properties.Music = this.Const.Music.CivilianTracks;
					properties.IsAutoAssigningBases = false;
					properties.Entities = [];

					for( local i = 0; i < 20; i = ++i )
					{
						local unit = clone this.Const.World.Spawn.Troops.Cultist;
						unit.Faction <- this.Const.Faction.Enemy;
						properties.Entities.push(unit);
					}

					this.World.State.startScriptedCombat(properties, false, false, true);
					return 0;
				}
				s.start <-	function ( _event ) {
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}

		}
	}


	o.onUpdateScore = function () {
		if (this.World.getTime().Days <= 200)
			return;

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns ) {
			local d = playerTile.getDistanceTo(t.getTile());
			if (d >= 4 && d <= 10) {
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
			if (bro.getLevel() >= 11 && (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)))
				candidates.push(bro);

		if (candidates.len() < 2)
			return;

		if (candidates.len() != 0)
			this.m.Cultist = candidates[this.Math.rand(0, candidates.len() - 1)];

		this.m.Score = 3;
	}

})
