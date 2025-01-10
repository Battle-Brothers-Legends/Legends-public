::mods_hookExactClass("events/events/dlc2/dog_in_swamp_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options[1].Text = "Comrades, we\'ve got to help that dog!";
			}
			if (s.ID == "GoodEnding") {
				s.Text = "[img]gfx/ui/events/event_09.png[/img]%helpbro% wades into the swampwater with arms out and swaying as though screwing the lid off a barrel. Lifting a weapon on high as the dog\'s owner nervously watches. A grin crosses the sellsword\'s face.%SPEECH_ON%Gotcha!%SPEECH_OFF%Skewers the swamp water and wrangling up a snake longer than any you\'ve ever seen, the length of it flopping about as the mercenary parades its corpse like a colored rope of a reward. The owner goes for his dog, but it slips out his grasp as though his arms were but another snake and it sprints right to your side. You ask if it\'s his dog at all. He nods, then slowly shakes his head.%SPEECH_ON%I suppose it\'s yer dog now. He\'s a fighter, that one, but he ain\'t nothing at all if not a goddam shite swimmer. I\'d see it a fair trade if I can keep that there snake.%SPEECH_OFF%You nod and make the trade, telling %helpbro% to hand over the newfound trophy.";
				s.start <- function ( _event )  {
					this.Characters.push(_event.m.Helper.getImagePath());
					local item = this.new("scripts/items/accessory/legend_wardog_item");
					item.m.Name = "Swimmer";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
			if (s.ID == "BadEnding") {
				s.Text = "[img]gfx/ui/events/event_09.png[/img]%helpbro% heads to the shoreline and draws a weapon. Wading into the mire like some ale strewn saint departing a crowd before they recognize a face. Such is the struggle that the mercenary topples over on top of the dog and disappears into the froth and bubbles of the battle. You rush to pull the sellsword ashore, who is now covered in moss with boots wrapped in lily pads and hacking nasty swamp water and picking out the brine which fermented it. There\'s no sight of the dog, just a slight ripple of water which trails away from the scene. Unnerved, its owner nods.%SPEECH_ON%Appreciate the effort, but it is what it is. The swamp sees to such things because it\'s a swamp and fark this goddam farkin\' place I\'d see this whole shitstain of geographical oddity drained and burned and salted to nothing but a wasteland whole if I could!%SPEECH_OFF%You raise an eyebrow and ask if he lives in the swamp. He takes a long breath and nods.%SPEECH_ON%Yessir. Rent free.%SPEECH_OFF%";
				s.Options[0].Text = "Well, that was a worthwile endeavour.";
			}
			if (s.ID == "Houndmaster") {
				s.Text = "[img]gfx/ui/events/event_09.png[/img]%houndmaster% the houndmaster rushes forward to help, but the dog the swamp surface goes still. The mercenary slips into the water and feels about, hands clench and staring back at the stranger.%SPEECH_ON%I\'m a dog handler at heart. That means I train \'em to not get into this much trouble. But I ain\'t ever would need to train a dog to beware this here bog, which means this sonuvabitch here threw him in there, ain\'t that right?%SPEECH_OFF%The stranger\'s first words are excuses and so the houndmaster batters him. The stranger scissors his legs backwards so awkwardly his pants fall about his ankles and there in his drawers spill an assortment of treasures. The damned fool is a treasure hunter! %houndmaster% draws a weapon and looks ready to murder this man. Screaming, the stranger kicks his pants off and runs off into the swampwoods hooting and pallidly half naked like some potato sack governed by a ghost. Laughing, you crouch to sift through the departed\'s goods, not all of which is shiny.";
			}
			if (s.ID == "BeastSlayer") {
				s.Text = "[img]gfx/ui/events/event_09.png[/img]The slayer of creatures, %beastslayer%, nods and wades into the swamp. The mercenary calmly comes to the thrashing water and stands over it, staring into the mire with eyes tracking left to right as though watching carp in clear waters. Finally, the beast hunter draws a dinner knife and slashes it into the water. Once more. And again. The dog surfaces and it snorts for air. The slayer stabs again and this time the dog runs free and goes between your legs where it huddles wet and whimpering. %beastslayer% holds something in hand and then lets it go, whatever it is diving across the swamp, the water rippling in its wake.%SPEECH_ON%Nothing but a snake, captain.%SPEECH_OFF%The beast slayer kicks a foot up out of the water and riding on a toe is a shiny goblet. The slayer regards the swamp stranger with complete contempt.%SPEECH_ON%Your cowardice has made you a monster, treasure hunter, a right savage that\'d use a dog in place of his own two hands. You\'ve no business in these swamps. When I turn around, you\'d best be gone, got it?%SPEECH_OFF%The beast slayer hands you the goblet and the stranger retreats without delay.";
				s.start <- function ( _event )  {
					this.Characters.push(_event.m.Beastslayer.getImagePath());
					local item = this.new("scripts/items/accessory/legend_wardog_item");
					item.m.Name = "Swimmer";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					item = this.new("scripts/items/loot/golden_chalice_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
			if (s.ID == "Net") {
				s.start <- function ( _event ) {
					local item = this.new("scripts/items/accessory/legend_wardog_item");
					item.m.Name = "Swimmer";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					local stash = this.World.Assets.getStash().getItems();

					foreach( i, item in stash ) {
						if (item != null && item.getID() == "tool.throwing_net") {
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "You lose " + item.getName()
							});
							stash[i] = null;
							break;
						}
					}
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Unhold)
			return;

		if (this.World.State.getPlayer().getTile().Type != this.Const.World.TerrainType.Swamp)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_houndmaster = [];
		local candidates_beastslayer = [];
		local candidates_other = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.legend_muladi" )
				candidates_houndmaster.push(bro);
			else if (bro.getBackground().getID() == "background.beast_slayer")
				candidates_beastslayer.push(bro);
			else if (!bro.getSkills().hasTrait(::Legends.Trait.Player))
				candidates_other.push(bro);
		}

		if (candidates_other.len() == 0)
			return;

		this.m.Helper = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_houndmaster.len() != 0)
			this.m.Houndmaster = candidates_houndmaster[this.Math.rand(0, candidates_houndmaster.len() - 1)];

		if (candidates_beastslayer.len() != 0)
			this.m.Beastslayer = candidates_beastslayer[this.Math.rand(0, candidates_beastslayer.len() - 1)];

		this.m.Score = 10;
	}
});
