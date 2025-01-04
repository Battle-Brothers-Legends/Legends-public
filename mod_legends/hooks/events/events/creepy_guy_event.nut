::mods_hookExactClass("events/events/creepy_guy_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.Text = "[img]gfx/ui/events/event_43.png[/img]You muscle your way into the crowd, looking for fingers and toes or bloodied pockets. One man\'s got a good, lumpy sag in his pocket. You drive him into a corner and shake him down with a dagger to his throat.\n\n After him, you see a woman with a sickly grin on her face prancing along the cobbled stones. That\'s a scornful wench if you\'ve ever seen one. Pulling her aside, you quickly find a finger and a toe in the linens of her frock. She lies and says they\'re just cooking ingredients. You tell her if that\'s the case then you\'ll report her to the guards for cannibalism. She gives them up.\n\n Returning the grossly extremities to the old man, you are promptly paid the five hundred crowns. He hardly even thanks you for your \'work\' before rushing away. He never did explain what, exactly, such things were for. You don\'t care. Five hundred crowns is five hundred crowns.";
			}
			if (s.ID == "Thief") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
			if (s.ID == "") {

			}
		}
	}
})
