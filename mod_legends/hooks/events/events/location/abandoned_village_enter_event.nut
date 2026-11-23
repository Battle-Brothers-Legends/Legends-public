::mods_hookExactClass("events/events/location/abandoned_village_enter_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "Victory", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_178.png[/img]{You stand over one of the...things you just fought. %randombrother% curls a blade underneath the goop and holds it up. A great mop of flesh elongates in stitched segments, arms spindling out like they were the branches of a tree, fat chunks sliding down the appendages like sap. The rest are incongruencies left and right: here a foot hanging from a torso like a doorhandle, there a face spreading apart as if melting into a river of sinews and ligaments. When your sellsword lets it slide off %their_randombrother% blade, the fleshbag slops into the ground, the bones rattling like a collapsing rope ladder. %randombrother2% walks up with a quiver of arrows and a small book.%SPEECH_ON%Got this quiver of, uh, interesting arrows. Looks like some sort of reservoir in the bottom of it is for dipping the arrowheads. The old gods know what that material is. I also found this here book tethered to one of their heads. Seems important.%SPEECH_OFF%Opening the book, you find lists of villages with lines crossing them out one by one, and beside each is a simple number. Fifty. Sixty. Seventy. At the back of the book you find a map to another location, what appears to be some sort of estate.}";
		});
	};
});
