::mods_hookExactClass("events/events/dlc2/location/waterwheel_enter_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "D2", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_109.png[/img]{The %weapon% then falls and you reach to catch it, but a ghostly hand steals it away. You look up to see the elder unsheathing the blade, revealing its fire and ice as though he brokered a new day and gloomy night in the very spectrum of its steel. He chokes with laughter.%SPEECH_ON%\'Avenge my son!\' \'Be worthy!\' Idle doings for simpletons. You did well to chase the carrot, sellsword, and for that I will kill you quick.%SPEECH_OFF%Pauldrons and bracers and a chest plate rise out of the mill well, sheets of grain streaming off them to reveal their garish shapes, and the metals twist and float to the elder, fiercely striking his body as though they meant to armor the very anvil that helped craft them. The suit of steel comes together as its occupant croaks with laughter. Hands grab you by your shoulders and drag you out of the house. You are shielded by the %companyname%. The elder geist turns his head.%SPEECH_ON%A mob of morons, is it? Depart, the lot of you, and you shall be spared. I only ask that you leave me the captain as I have already promised his demise.%SPEECH_OFF%%randombrother% draws %their_randombrother% weapon and the rest of the company follows suit. The elder holds up the crepuscular sword in return. Though the steel is firmly real, the elder\'s body is rippling to and fro like a thinly veiled curtain on a moonlit night. He sighs and parts of blue ether drift from his lips. He turns the blade so its edge faces you.%SPEECH_ON%So be it.%SPEECH_OFF%}";
		});
	}
});
