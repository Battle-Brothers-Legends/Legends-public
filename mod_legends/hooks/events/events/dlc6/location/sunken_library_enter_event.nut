::mods_hookExactClass("events/events/dlc6/location/sunken_library_enter_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
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
