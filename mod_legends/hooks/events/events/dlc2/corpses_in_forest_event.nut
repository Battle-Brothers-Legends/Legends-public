::mods_hookExactClass("events/events/dlc2/corpses_in_forest_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_132.png[/img]{%killer% the murderer on the run smirks and snorts and nods and spits, then nods again and points at the pile of bodies.%SPEECH_ON%That\'s a cruelty so fierce I don\'t think its doer survived the doing.%SPEECH_OFF%You ask what that means, but the killer holds a finger up and walks about the forest, looking behind tree after tree until coming to a stop.%SPEECH_ON%Just as I thought.%SPEECH_OFF%You come round to see a man hanging there. His fingertips are black and there\'s ash on his face and a noose about his neck. A note in his hand carries apologies, though it does not describe the nature of his crime or if it were a crime at all. Below his feet is his armor and weapons. He may have been a nobleman. Regardless, you have the body cut down and everything looted.}";
				s.start <- function (_event) {
					this.Characters.push(_event.m.Killer.getImagePath());
					local item = this.new("scripts/items/weapons/morning_star");
					item.setCondition(this.Math.rand(5, 30) * 1.0);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});

					item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.basic_mail_shirt],
					]);
					item.setCondition(this.Math.rand(0.25 * item.getConditionMax(), 0.60 * item.getConditionMax()) * 1.0);

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
		}
	}
});
