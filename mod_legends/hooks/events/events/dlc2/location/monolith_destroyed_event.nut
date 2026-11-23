::mods_hookExactClass("events/events/dlc2/location/monolith_destroyed_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_101.png[/img]{%SPEECH_START%It\'s disappointing.%SPEECH_OFF%%randombrother% says as %they_randombrother% looks at the slain corpses. %They_randombrother% snorts and spits.%SPEECH_ON%Don\'t think disappointing is the word for it, though. They\'re just lying there, bones and coats, like we\'d fought a closet. No flesh, no blood. It\'s unsatisfying. And knowing that, thinking it true, well that unnerves me.%SPEECH_OFF%You got nothing to say to such things other than there\'s a kernel of truth in the matter. If it weren\'t the issuances of its lust, why else the vigor for violence? Another sellsword calls you over, interrupting any solemn introspection.%SPEECH_ON%Sir, come have a look.%SPEECH_OFF%You head over and spot a skull sitting in the bed of pauldrons like an egg in the bosom of a well-endowed southerner. The rest of its body is battered and thrown to the winds as far as you can tell. What remains is a decadent slab of chest armor. It is covered in glyphs and treatments, fortunes and historical retellings, and is embroidered with red tassels and combs made of bristly hair. You touch the metal and the second you do the skull beside it powders and blows away. The mercenary seeing this shrugs rather sheepishly.%SPEECH_ON%If you got magical powers I won\'t tell no one.%SPEECH_OFF%You slug the sellsword in the shoulder and tell him to the load armor into the inventory for later allocation.}";
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.start <- function (_event) {
				this.World.Assets.getStash().makeEmptySlots(2);
				local item = this.new("scripts/items/legend_armor/legendary/legend_emperors_armor");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				item = this.new("scripts/items/legend_armor/named/legend_armor_cloak_emperors");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}
		});
	}
});
