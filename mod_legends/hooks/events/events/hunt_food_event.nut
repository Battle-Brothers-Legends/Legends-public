::mods_hookExactClass("events/events/hunt_food_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img]{As you help %otherguy% get their boot out of the mud, %hunter% comes out of the bushes with what must be nearly a dozen rabbits strung together, sets them down and starts to untie them. The little bunnies - eyes wide, horrified in the end - all look quite tasty. The hunter grabs one by its neck and twists its body in a circle before pushing all its guts out in one swift motion. The process is repeated until every rabbit has been slaughtered. As %hunter% wipes hands on %otherguy%\'s cloak, the hunter points to the mound of emptied bunnies on the ground.%SPEECH_ON%That there is the eating pile.%SPEECH_OFF% Then points to the lump of rabbit guts.%SPEECH_ON%That there is not the eating pile. Got it? Good.%SPEECH_OFF%  | %hunter% ran on ahead of the party a few hours ago and just now you catch back up. The hunter is standing with a foot on a dead deer, its chest punctured by a single arrow. As you approach, the hunter grins, steps off and says if some of the company can help string it up, it can be skinned and prepared. | Forest birds chitter and chatter above the company\'s march. The sun winks between the canopy branches, a soft glint that peppers the ground with dots of light. You spot a squirrel resting in one of the sun beams, enjoying the warmth as it gnaws on an acorn. It stops, sensing you watching it, and then it suddenly jerks and a fleck of its blood meets your cheek. You wipe it away, turning back to see that the squirrel has been impaled by an arrow, every shrieking death throe quieter than the last as the volume of its life slowly turns down. %hunter% suddenly breaks through the bushes with a bow in hand and a grinning face. The hunter retrieves the kill and throws it in with a litter of others, a long hunter\'s line around which are tied all manner of critters foe and friend alike.}";
			}
		}
	}
})
