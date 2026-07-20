::mods_hookExactClass("events/events/food_goes_bad_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.start = function (_event) {
				local food = ::World.Assets.getFoodItems();
				food = food[::Math.rand(0, food.len() - 1)];
				::World.Assets.getStash().remove(food);

				if (food.getID() == "supplies.bread") {
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{While pulling inventory duty, %randombrother% alerts you to a bit of dire news: a good sum of food has gone bad. Simple and to the point, you nod and thank %them_randombrother% for telling you quickly. | %randombrother% comes to you rubbing %their_randombrother% jaw. %They_randombrother% says %they_randombrother% almost broke %their_randombrother% teeth on a bit of bread. Apparently %they_randombrother% found the piece at the bottom of a food crate and it appears to have been sitting there for some time. You take a sword to the loaf, chopping it in two as a few brothers cheer with sarcastic bravado. Taking up the halved bread, you show the men the insides: a dark core of black. That\'s what your stomach will look like if you eat this, you say before throwing the bread into the bushes where you can hear it tumbling like a heavy stone.}";
				} else if (food.getID() == "supplies.dried_fish") {
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{While pulling inventory duty, %randombrother% alerts you to a bit of dire news: a good sum of food has gone bad. Simple and to the point, you nod and thank %them_randombrother% for telling you quickly. | %randombrother% yelps and leaps up off the log %they_randombrother% was sitting on. You walk over to see %they're_randombrother% thrown a fish by the wayside and %they_randombrother% can\'t stop pointing at it. While %they_randombrother% warns you to not go near it, you decide to go near it. Apparently a water-spider had birthed a clutch of eggs inside the fish\'s abdomen. You now stare at the little spiderlings bubbling forth in a cloud of scuttling legs and bodies.\n\nThrowing the entire lot into a fire, you ask the %sibling_randombrother% to check the rest of the fish. Unfortunately, they are all in a similar state and nobody is willing to replace fish-food for spider-food.}";
				} else if (food.getID() == "supplies.dried_fruits") {
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{While pulling inventory duty, %randombrother% alerts you to a bit of dire news: a good sum of food has gone bad. Simple and to the point, you nod and thank %them_randombrother% for telling you quickly. | You sift through a few crates of foodstuffs to find an entire carton of apples covered in what looks like grey fur. %randombrother% has a word for it, but you\'ve never heard it before. Regardless, none of it can be salvaged and you toss the rotten fruit away.}";
				} else if (food.getID() == "supplies.smoked_ham"
					|| food.getID() == "supplies.cured_venison")
				{
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{While pulling inventory duty, %randombrother% alerts you to a bit of dire news: a good sum of food has gone bad. Simple and to the point, you nod and thank %them_randombrother% for telling you quickly. | Maggots wriggle about a few chunks of meat. Your men stare at the food, some looking as though they\'re willing to risk a bit of illness to have a bite. You tell everyone off and get rid of the meat personally before someone does something stupid.}";
				} else {
					this.Text = "{[img]gfx/ui/events/event_52.png[/img]While pulling inventory duty, %randombrother% alerts you to a bit of dire news: a good sum of food has gone bad. Simple and to the point, you nod and thank %them_randombrother% for telling you quickly. | [img]gfx/ui/events/event_36.png[/img]Childish giggling wakes you from a nap. You rise up to see that some of the food is gone and the only evidence as to where it departed is a field of still moving tall grass. Thinking fast, you take up a sword and follow its trail. Unfortunately, it isn\'t long before you are lost in the midst of enormous stalks of green that pedal against your face with every rush of wind. The giggling doesn\'t stop, however, and you hear the pitter-patter of footsteps cross behind you and then in front. A voice speaks, sounding like a child deep in a well.%SPEECH_ON%Chase us! Over here! Chase us! Chase us... CHASE US. CHASE US NOW!%SPEECH_OFF%You suddenly feel no urge to retrieve the grain. You slowly put your sword back in its sheath and back out of the field. As you stare into the tall grass, it begins to part, slowly, like a piece of leather being torn at the seams. You hear horrible cries as each stem cracks in half.\n\n%randombrother% startles you when %they_randombrother% asks what it is you\'re doing. You turn to look at %them_randombrother%, then turn back to the field which sways gently to a breeze. Instead of answering, you just tell %them_randombrother% to get ready as you\'ll be marching again very soon. Thankfully, the mercenary does not inquire about the missing food.}";
				}

				this.List = [
					{
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "You lose " + food.getName()
					}
				];
			}
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (::World.Assets.m.ProfessionEffect.LegendFoodPreservation > 0) {
			return;
		}
		onUpdateScore();
	}

});
