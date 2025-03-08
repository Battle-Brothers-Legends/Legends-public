::mods_hookExactClass("events/events/no_food_variety_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_52.png[/img]{You find the mercenaries circled around a campfire, except they\'ve no real food to put over the flames. One throws %their_randombrother% bowl of soup down. It is such a sludge that it barely moves to spill which is, honestly, quite disgusting. %randombrother% looks at you.%SPEECH_ON%Sir, please, let us get some meat! Or something beyond this shite!%SPEECH_OFF%A bit of variety wouldn\'t hurt, you agree. | %randombrother% comes to you and slams a spoon on your desk. There\'s something on the spoon, but what exactly you can\'t tell. The mercenary leans back, thumbs jacked into %their_randombrother% beltline, %their_randombrother% chest growing with breath. Then %they_randombrother% sighs, for %they_randombrother% knows not to behave in such ill-manner in your presence. But %they_randombrother% does explain %themselves_randombrother%.%SPEECH_ON%Sir, the men are complaining about the food. I think it\'d be great for company morale if perhaps we picked up some meats and other goods in the next town. Only a suggestion, of course.%SPEECH_OFF%%They_randombrother% quickly leaves. You pick up the spoon and look at whatever is in the scoop of it. That... that can\'t really be what they\'re eating out there, can it? Perhaps some variety wouldn\'t hurt... | %randombrother% approaches with a bowl in hand. %They_randombrother% tilts it forward, showing the contents which are colorless and slide ever so slowly down the rim of the bowl. The mercenary shakes %their_randombrother% head.%SPEECH_ON%The men are unhappy sir, and myself too, about the dinners we\'ve been eating. A man can only eat the same contents day after day for so long, especially when %they_randombrother% knows %they_randombrother% can afford so much more. It is only a suggestion, sir, from myself and from all the men, that perhaps we liven up our food stocks so that not every meal is... well, this.%SPEECH_OFF%%They_randombrother% sets the bowl down and walks off. | A few of your mercenaries are complaining around a campfire. You stay within earshot, carefully listening as they might say things they wouldn\'t in your presence. Thankfully, it\'s not a mutiny in motion, but instead a series of cooking criticisms. There simply is not enough variety in the company\'s food stocks. They\'re tired of eating the same thing over and over. Perhaps this could be remedied in the next town the %companyname% visits?}";
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;
		onUpdateScore();
	}
})
