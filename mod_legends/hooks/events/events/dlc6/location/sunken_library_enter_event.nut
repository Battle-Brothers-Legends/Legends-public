::mods_hookExactClass("events/events/dlc6/location/sunken_library_enter_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_173.png[/img]{The shine and shimmer is so bright you almost think the Gilder Himself has ordained you a proper visit - unfortunately or fortunately, what you\'ve stumbled across is actually a great gilded dome protruding ever so slightly from the sands. Immediately, you test if you can pull some of the gold away, but it has no give. %randombrother% calls you over to a slab of stone which is gapped. Perhaps a belltower at one point? Light fades quick and you can see very little inside. Above the entryway a relief depicts men pulling carts of scrolls.\n\n There\'s a set of words repeatedly scrawled across the relief. None of the languages look remotely familiar to anything you\'ve ever heard or seen. It takes a bit of time until you can find a hurriedly etched translation left by someone approximal to your era: \'the Library, the Labyrinth of the Night, the Labyrinth of the Mind, Leave here as you would Leave a Dream, Tread here as you would Tread a Dream, Leave to Dwell upon the Horror of not Knowing, Enter to be One with Knowing, and in Knowing the Dream, Know the Nightmare\'.%SPEECH_ON%Fair bit ominous, captain, but if you wanna go down in there we got the rope and torches to see to it.%SPEECH_OFF%%randombrother% tells you this, and the look on %their_randombrother% face suggests %they're_randombrother% hoping you decline the proposition.}";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_89.png[/img]{The climb down is a perilous one, the dark so thick you can\'t even see your own boots. But eventually you hit a marbled floor and quickly light up some torches. You find yourself in a massive hall around which spiral rows and rows of bookcases. Every shelf is adorned with piles of scrolls, many dwelling within glass enclosures. The shelves are stacked upon each other and seem to ascend to the very ceiling from which you descended. Rolling ladders rest at each level, but even further up runs a floating mezzanine with metal chutes stationed here and there. It seems as though once upon a time one was meant to pass these scrolls up and down, though now everything is rusted, and the mezzanine has collapsed in parts.\n\n %randombrother% calls your attention. %They_randombrother% points to an enormous scroll flattened behind a sheet of glass. Drawings sprawl over the paper, and upon closer inspection it appears they are blueprints for seemingly everything: the human body, the bodies of many animals, castles, towers, windmills, ships, weapons and armor, boots and gloves, alignments of the stars, and a great number of drawings of things which you have never seen before, things which don\'t make sense.%SPEECH_ON%Captain, this place is not meant for us. The languages, the halls, we should go.%SPEECH_OFF%One of the sellswords expresses the mood in the air. You have absolutely trespassed to a place few have gone before. And if they have gone before, where are they? A place like this surely can\'t stay hidden, right?}";
			}
			if (s.ID == "Victory") {
				s.Text = "[img]gfx/ui/events/event_89.png[/img]{The Lorekeeper collapses onto the ground a pile of ash and the phylacteries slowly fade back to dark. You walk over with torch in hand. Its black skull resides atop the book that once dwelled in its chest with the mysterious magestaff close by.%SPEECH_ON%Captain, I don't think we should be touching anything here.%SPEECH_OFF%You ignore one of your men and pick the book up and the weapon up. Its leather covering is stitched together, and as you look closer you can see the flesh of ears and noses encompassing the cover. Immediately, the bones of the slain undead scratch across the marbled floor. One zips between your legs and flies into the pile of ash. A dull white fire alights inside the socket of the skull. That's more than enough for you: with a quick command, you get the men to climb back up the rope, yourself the last to leave. As you near the light of the earth above, you take one moment to stare back down and - the black skull is already in your face! It floats alone, eyes burning white, capturing your sight in a cone of fire you cannot understand, and as you stare into it you can hear the voices of your men fade away. The skull floats alone, and you almost feel the urge to let the rope go. The skull speaks to your mind:%SPEECH_ON%It is but one of its gifts, Interloper, and you are not the first to have it. There is many who have taken it, and in the many there is but one end, the one who awaits us all!%SPEECH_OFF%The skull's fire snuffs out and it drops away into the dark where you hear a brief clatter. The voices of your men rush back in, louder than ever and you look up to see %randombrother%'s hand. Grabbing hold, they pull you out. As you exit, the entrance sinks into the sand, and all you have of the place is a strange, fleshen book filled with writings you cannot ever hope to decipher.}";
				s.start <- function ( _event ) {
					_event.m.Title = "After the battle...";

					if (this.World.State.getLastLocation() != null)
					{
						this.World.State.getLastLocation().die();
					}

					this.World.Assets.getStash().makeEmptySlots(1);
					local item = this.new("scripts/items/special/black_book_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});

					this.World.Assets.getStash().makeEmptySlots(1);	
					local item = this.new("scripts/items/weapons/legendary/legend_mage_swordstaff");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});

					local scholars = [];
					foreach (bro in this.World.getPlayerRoster().getAll())
					{
						if (bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))
						{
							scholars.push(bro);
						}
					}

					this.World.Assets.getStash().makeEmptySlots(1);
					local item = this.new("scripts/items/misc/legend_ancient_scroll_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});

					this.World.Assets.getStash().makeEmptySlots(scholars.len());
					foreach (bro in scholars)
					{
						this.World.Assets.getStash().makeEmptySlots(1);
						this.World.Assets.getStash().add(item);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = bro.getName() + " finds " + item.getName()
						});
					}

					this.World.Flags.set("IsLorekeeperDefeated", true);
					this.updateAchievement("Lorekeeper", 1, 1);
				}
			}
		}
	}
})
